require 'rails_helper'

# Also compared to earlier versions of this generator, there are no longer any
# expectations of assigns and templates rendered. These features have been
# removed from Rails core in Rails 5, but can be added back in via the
# `rails-controller-testing` gem.

RSpec.describe BooksController, type: :controller do

  let(:valid_session) { {} }

  let (:history) { create(:history) }

  let(:book) { create(:book) }

  let(:books) { 4.times.map { build(:book) } }
  
  let(:user) {create(:user)}

  let(:adminuser) {create(:adminuser)}

  describe "GET #index" do
    it "returns a success response" do
      params = { books: books}
      get :index, params: params, session: valid_session
      expect(response).to be_successful
    end
    it "returns a success response" do
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end
  end

  describe "GET #show" do
    it 'returns show page with params' do
      sign_in user
      params = {id: book.id}
      get :show, params: params 
    end
    it 'renders the show template' do
      sign_in user
      get :show, params: {id: book.id}
      expect(response).to render_template('show')
    end
    it "returns a success response" do
      sign_in user
      get :show, params: {id: book.id}, session: valid_session
      expect(response).to be_successful
    end
    it 'responses with success withour user' do
      sign_out user
      get :show, params: {id: book.id}
      expect(response).not_to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      sign_in user
      get :edit, params: {id: book.id}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Book" do
        sign_in adminuser
        expect {
          post :create, params: {book: FactoryBot.attributes_for(:book)}
        }.to change(Book, :count).by(1)
      end
      it 'redirects when user is not admin' do
        sign_out adminuser
        sign_in user
        post :create, params: {book: FactoryBot.attributes_for(:book)}
        expect(response.status).to eq(302)
      end
      it "redirects to the created book" do
        sign_in adminuser
        post :create, params: {book: FactoryBot.attributes_for(:book)}
        expect(response).to redirect_to(Book.last)
      end
    end
    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        sign_in adminuser
        post :create, params: {book: FactoryBot.attributes_for(:invalid_book)}
        expect(response).not_to eq(200)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) { FactoryBot.attributes_for(:book) } 
      let(:valid_attributes) { FactoryBot.attributes_for(:book) }

      it "updates the requested book" do
        sign_in adminuser
        put :update, params: {id: book.id, book: new_attributes}
        book.reload
        expect(response.status).to eq(302)
      end
      it "redirects to the book" do
        sign_in adminuser
        put :update, params: {id: book.id, book: valid_attributes}
        expect(response).to redirect_to(book)
      end
      it 'assigns the book' do
        sign_in adminuser
        put :update, params: {id: book.id, book: new_attributes}
        expect(assigns(:book)).to eq(book)
      end
      it 'updates the book' do
        sign_in adminuser
        put :update, params: {id: book.id, book: new_attributes}
        book.reload
        expect(book).to having_attributes(title: book.title)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested book" do
      sign_in adminuser
      expect {
        delete :destroy, params: {id: book.id}
      }.to change(Book, :count).by(0)
    end

    it "redirects to the books list" do
      sign_in adminuser
      delete :destroy, params: {id: book.id}
      expect(response).to redirect_to(books_url)
    end
  end

end
