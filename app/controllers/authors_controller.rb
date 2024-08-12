class AuthorsController < ApplicationController
  def show
    @author = Author.find(params[:id])
  end

  def edit
    @author = Author.find(params[:id])
  end

  def new
    @author = Author.new
  end

  def update
    @author = Author.find(params[:id])

    if @author.update(post_params)
      redirect_to author_path(@author)
    else
      render :edit
    end

  end

  def create
    @author = Author.new(author_params)
  
    if @author.save
      redirect_to author_path(@author)
    else
      render :new
    end
  end

  private

  def author_params
    params.permit(:name, :email, :phone_number)
  end
end
