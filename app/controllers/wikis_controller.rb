class WikisController < ApplicationController
  before_action :authenticate_user!
  #before_action :authorize_user, only: [:update]

  def index
    @wikis = Wiki.visible_to(current_user)
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = current_user.wikis.build(wiki_params)
    #@wiki = Wiki.new(wiki_params)
    #@wiki.user = current_user

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
    #@wiki.update_attribute(:private, false) if current_user.standard?
    authorize @wiki
  end

  def update
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.private = params[:wiki][:private]
    @wiki.update_attribute(:private, false) if current_user.standard?


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

  def wiki_params
    params.require(:wiki).permit(:title,:body,:private)
  end

	def user_params
		params.require(:user).permit(:email)
	end


end
