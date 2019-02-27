class CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_book, only: [:create, :destroy]

  def show
  end

  def new
  end

  def create
    @comment = @book.comments.create(comment_params)
    @comment.user_id = current_user.id
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @book, notice: 'Comment was successfully created.' }
        format.js {}
      else
        format.html { render 'books/show', notice: 'Comment was not created.' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
        format.js {}
      end
    end
  end

  def edit
  end

  def destroy
    @comment = @book.comments.find(params[:id])
    @comment.destroy
    if permitted_to_delete_comment?(@comment) && @comment.destroy
      respond_to do |format|
        format.html { redirect_to book_path(@book), notice: "Commented successfully deleted" }
        format.js {}
      end
    else
      redirect_to :back
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:content, :user_id, :book_id)
    end

    def find_book
      @book = Book.find(params[:book_id])
    end
end
