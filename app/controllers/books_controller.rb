class BooksController < ApplicationController

  before_action :correct_user, only: [:edit, :update, :destroy]

  def show
  	@new_book = Book.new
  	@book = Book.find(params[:id])
  	@user = @book.user
  end

  def index
  	@new_book = Book.new
  	@books = Book.all
    @user = current_user

  end

  def create
    @new_book = Book.new(book_params)
    @new_book.user_id = current_user.id
    if @new_book.save
      flash[:create] = "You have created book successfully."
      redirect_to book_path(@new_book.id)
    else
      @books = Book.all
      @user = current_user
      render 'index'
    end
  end

  def edit
     @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
    flash[:update] = "You have updated book successfully."
    redirect_to book_path(@book.id)
    else
    render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end


  private
  def correct_user
    user = Book.find(params[:id]).user
    if current_user != user  # ←１段上のuserのこと
      redirect_to books_path
    end
  end

  def book_params
  	params.require(:book).permit(:title,:body)
  end

end
