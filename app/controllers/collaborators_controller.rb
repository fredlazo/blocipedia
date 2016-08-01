class CollaboratorsController < ApplicationController

  def new
    @collaborator = Collaborator.new
    @user = User.all
    @wiki = Wiki.find(params[:wiki_id])
  end

  def create
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.new(user_id: params[:user_id], wiki_id: params[:wiki_id])

    if @collaborator.save
      flash[:notice] = "You added a collaborator for your wiki."
      redirect_to @wiki
    else
      flash[:error] = "There was an error adding this collaborator. Please try again."
      render :new
    end
  end

  def destroy
    @collaborator = Collaborator.find(params[:id])
    @wiki = @collaborator.wiki
    if @collaborator.destroy
      flash[:notice] = "Collaborator was removed successfully"
      redirect_to new_wiki_collaborator_path(@wiki)
    else
      flash[:error] = "There was an error removing a collaborator.Please try again"
      render "show"
    end
  end

end
