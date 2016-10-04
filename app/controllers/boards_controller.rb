class BoardsController < ApplicationController
  before_action :set_board, only: [:show, :edit, :update, :destroy, :password]

  # GET /boards
  # GET /boards.json
  def index
    @boards = Board.all
  end

  # GET /boards/1
  # GET /boards/1.json
  def show
    @last_user_name = cookies.signed[:last_user_name]

    items = @board.items
    if items.present?
      contributors = (items + items.map(&:comments) + items.map(&:votes)).flatten.map(&:user).uniq.compact
      @contributor_names = contributors.map(&:name).sort.join(', ') if contributors.present?
    end

    @contributor_names = 'None Yet' if contributors.blank?

    respond_to do |format|
      format.html do
        if @board.password.present?
          cookies.signed["board_#{@board.slug}_password"] = params[:p] if params.include?(:p)
          saved_password = params[:p] || cookies.signed["board_#{@board.slug}_password"]
          if saved_password.blank? or saved_password != @board.password
            flash[:alert] = 'That password was incorrect.' unless saved_password.blank?
            redirect_to board_password_path(@board)
            return
          end
        end

        @sort = params[:sort]
        @sort = @board.closed? ? 'vote' : 'recent' if @sort.blank?
        case @sort
        when 'vote'
          @items = @board.items.voted
        when 'recent'
          @items = @board.items.recent
        end
      end
      format.json do
        @time = Time.at( params[:time].to_i / 1000.0 )
        if @board.updated_at < @time
          head :ok
        else
          render :show, status: :created, location: @board
        end
      end
    end
  end

  def password
    render and return if request.get?
    cookies.signed["board_#{@board.slug}_password"] = params[:password]
    redirect_to @board
  end

  # GET /boards/new
  def new
    @group = Group.friendly.find(params[:group_id]) if params.include?(:group_id)

    @board = Board.new(
      name: "#{Date.today.strftime('%m/%d/%Y')} Retro",
      password: Board.generate_password,
      duration: 24,
      good_column_name: 'Good',
      bad_column_name: 'Bad',
      meh_column_name: 'Meh',
      good_column_description: 'What worked well this past week?',
      bad_column_description: 'What went badly this past week?',
      meh_column_description: 'What were you concerned about this past week?',
      group_id: params[:group_id]
    )
  end

  # GET /boards/1/edit
  def edit
  end


  # POST /boards
  # POST /boards.json
  def create
    @board = Board.new(board_params)

    if !verify_recaptcha(model: @board)
      render :new
      return
    end

    respond_to do |format|
      if @board.save
        format.html { redirect_to board_path(@board, p: @board.password), notice: 'Board was successfully created.' }
        format.json { render :show, status: :created, location: @board }
      else
        format.html { render :new }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /boards/1
  # PATCH/PUT /boards/1.json
  def update
    respond_to do |format|
      if @board.update(board_params)
        format.html { redirect_to @board, notice: 'Board was successfully updated.' }
        format.json { render :show, status: :ok, location: @board }
      else
        format.html { render :edit }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /boards/1
  # DELETE /boards/1.json
  def destroy
    @board.destroy
    respond_to do |format|
      format.html { redirect_to boards_url, notice: 'Board was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_board
      @board = Board.friendly.find(params[:id] || params[:board_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def board_params
      params.require(:board).permit(:name, :password, :good_column_name, :bad_column_name, :meh_column_name, :good_column_description, :bad_column_description, :meh_column_description, :duration, :group_id)
    end
end
