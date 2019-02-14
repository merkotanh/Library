class CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  
  def show
  end

  def new
  end

  def create
    @book = Book.find(params[:book_id])
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
    @book = Book.find(params[:book_id])
    @comment = @book.comments.find(params[:id])
    record_activity("Destroys a comment #{@comment.content}")
    @comment.destroy
    redirect_to image_path(@book)
  end

  private
    def comment_params
      params.require(:comment).permit(:content, :user_id, :book_id)
    end
end
