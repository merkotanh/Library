class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  def permitted_to_delete_comment?(comment)
    current_user == comment.user || current_user.admin
  end
  helper_method :permitted_to_delete_comment?

  def take_book!(book)
    book.status = true
    book.save
    book.histories.create(user_id: current_user.id, book_id: book.id, taken: Time.now)
  end
  helper_method :take_book!

  def return_book!(book)
    book.status = false
    book.save
    h = History.where(book_id:book.id).last # History.where(book_id:book.id).last.returned = Time.now <- так не срабатывает почему-то
    h.returned = Time.now
    h.save
  end
  helper_method :return_book!
end
