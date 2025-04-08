class SharedListsController < ApplicationController
  before_action :authenticate_user!

  def destroy
    shared_list = SharedList.find(params[:id])
    todo_list = shared_list.todo_list

    if todo_list.user == current_user || shared_list.user == current_user
      shared_list.destroy
      flash[:notice] = "Sharing removed successfully."
    else
      flash[:alert] = "You don't have permission to remove this sharing."
    end

    redirect_to share_todo_list_path(todo_list)
  end
end
