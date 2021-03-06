class BooksController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_book, only: [:show, :edit, :update, :destroy, :takebook, :toggle_enable_status, :vote]
  respond_to :js, :json, :html
  
  def index
    @top_books = Book.order(taken_count: :desc, stars_count: :desc).limit(5)
    if params[:search] && params[:search] != ''
      @search_books = Book.where(title: Regexp.new(params[:search], true))
    end
    @books = Book.order(title: :asc).page(params[:page]).per(5)
  end

  def show
  end

  def new
    @book = Book.new
  end

  def edit
  end

  def create
    @book = Book.new(book_params)
    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def toggle_enable_status
    if @book.taken?(current_user)
      return_book!(@book)
    else
      take_book!(@book)
    end
    @history = @book.histories.last
  end

  def vote
    @book.ratings.create(user_id: current_user.id, book_id: @book.id)
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :author, :description, :image, :status, :votes)
  end

end
