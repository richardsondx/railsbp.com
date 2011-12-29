class CollaboratorsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_current_user, only: [:sync, :create]
  before_filter :load_repository

  def index
    @collaborators = @repository.users
  end

  def create
    @repository.add_collaborator(params[:collaborator])
    redirect_to [@repository, :collaborators], notice: "Add collaborator successfully"
  end

  def sync
    @repository.sync_collaborators
    redirect_to [@repository, :collaborators], notice: "Synchronize collaborators successfully"
  end

  def destroy
    user = User.find(params[:id])
    @repository.users.delete(user)
    redirect_to [@repository, :collaborators], notice: "Delete collaborator successfully"
  end

  protected
    def load_repository
      @repository = Repository.find(params[:repository_id])
    end
end