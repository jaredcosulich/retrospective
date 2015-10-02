class ItemsController < ApplicationController
  before_action :set_board
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /items/1
  # GET /items/1.json
  def show
    @comments = @item.comments.recent
    @votes = @item.votes.recent
  end

  # GET /items/new
  def new
    @item = @board.items.new(column_name: params[:column_name], user_name: cookies.signed[:last_user_name])
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    cookies.signed[:last_user_name] = item_params[:user_name]
    
    @item = @board.items.new(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to @board, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @board, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to @board, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_board
      @board = Board.friendly.find(params[:board_id])
    end
  
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = @board.items.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:title, :column_name, :user_name, :comment)
    end
end
