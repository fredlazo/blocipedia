class WikisController < ApplicationController

  before_action :authenticate_user!

  def index
    @wikis = Wiki.all
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.private = params[:wiki][:private]

    if @wiki.save
      flash[:notice] = "Saved!"
      redirect_to @wiki
    else
      flash.now[:alert] = "Fail!"
      redirect_to :new
    end
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.private = params[:wiki][:private]

    if @wiki.save
      flash[:notice] = "Saved!"
      redirect_to @wiki
    else
      flash.now[:alert] = "Fail!"
      redirect_to :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash.now[:alert] = "There was an error deleting the wiki."
      render :show
    end
  end

  private

	def user_params
		params.require(:user).permit(:email)
	end

end
