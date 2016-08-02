class CollaborationsController < ApplicationController

before_action :set_wiki

  def index
  end

  def new
    @collaboration = @wiki.collaborations.new

  end

  def create
    @collaboration = @wiki.collaborations.new( collaboration_params )


    if @collaboration.save
      flash[:notice] = "Collaboration was saved."
      redirect_to @wiki
    else
      flash[:error] = "Error. Could not save the collaboration."
      redirect_to @wiki
    end
  end

  def destroy

    @collaboration = Collaboration.find(params[:id])
    @wiki = @collaboration.wiki
    if @collaborator.destroy
      flash[:notice] = "Collaborator was removed successfully"
      redirect_to edit_wiki_path(@wiki)
    else
      flash[:error] = "There was an error removing a collaborator.Please try again"
      render "show"
    end
  end

  private

  def set_wiki
    @wiki = Wiki.find(params[:wiki_id])
  end

  def collaboration_params
    params.require(:collaboration).permit(:wiki_id, :user_id)
  end
end
