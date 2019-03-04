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
    if @book.voted_by(user_id: params[:user_id])
      flash[:error] = "params = #{params[:user_id]}"
      @rating = @book.ratings.build(rating_params)
      @book.count_book_rating(@book, @rating.rate)
    else
      flash[:error] = "U v voted already"
    end
    respond_to do |format|
      if @rating.save
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
      params.require(:rating).permit(:rate, :user_id, :book_id)
    end

    def find_book
      @book = Book.find(params[:book_id])  
    end
end
