json.extract! book, :id, :title, :author, :description, :image, :status, :votes, :created_at, :updated_at
json.url book_url(book, format: :json)
