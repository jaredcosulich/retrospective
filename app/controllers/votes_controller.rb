class VotesController < ApplicationController
  before_action :set_board
  before_action :set_item
  before_action :set_vote, only: [:destroy]

  def new
    @vote = @item.votes.new(user_name: cookies.signed[:last_user_name])
  end
  
  def index
    @votes = @item.votes.recent
  end
  
  # POST /votes
  # POST /votes.json
  def create
    cookies.signed[:last_user_name] = vote_params[:user_name]
    
    @vote = @item.votes.new(vote_params)

    respond_to do |format|
      if @vote.save
        format.html { redirect_to @board, notice: 'Vote was successfully created.' }
        format.json { render :show, status: :created, location: @vote }
      else
        format.html { render :new }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /votes/1
  # DELETE /votes/1.json
  def destroy
    @vote.destroy
    respond_to do |format|
      format.html { redirect_to @board, notice: 'Vote was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_board
      @board = Board.find(params[:board_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = @board.items.find(params[:item_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_vote
      @vote = @item.votes.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vote_params
      params.require(:vote).permit(:user_name)
    end
end
