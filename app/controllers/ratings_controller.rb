class RatingsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_book, only: [:create]
  respond_to :js, :json, :html

  def new
  end

  def index
  	@ratings = Rating.all
  end

  def create
    unless @book.voted_by?(user: current_user)
      @rating = @book.ratings.build(rating_params)
      @rating.user_id = current_user.id
    else
      flash[:error] = "U v voted already"
    end
    respond_to do |format|
      if @rating.save
        @book.count_book_rating(@rating.rate)
        format.html { redirect_back(fallback_location: root_path) }
        format.json { render json: @rating, status: :created }
        format.js {}
      else
        format.html { render 'books/show'}
        format.json { render json: @rating.errors, status: :unprocessable_entity }
        format.js {}
      end
    end
  end

  private

    def rating_params
      params.require(:rating).permit(:rate)
    end

    def find_book
      @book = Book.find(params[:book_id])  
    end
end
