class TodoListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_todo_list, only: [ :show, :edit, :update, :destroy ]
  def index
    @todo_lists = current_user.todo_lists
    @shared_lists = current_user.shared_todo_lists
    render layout: false if turbo_frame_request?
  end

  def show
    @tasks = @todo_list.tasks
    render layout: false if turbo_frame_request?
  end

  def new
    @todo_list = current_user.todo_lists.build
    render layout: false if turbo_frame_request?
  end

  def create
    @todo_list = current_user.todo_lists.build(todo_list_params)
    if @todo_list.save
      redirect_to todo_list_path(@todo_list), notice: "Todo list created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @todo_list.update(todo_list_params)
      redirect_to todo_list_path(@todo_list), notice: "Todo list updated."
    else
      render :edit
    end
  end

  def destroy
    @todo_list.destroy
    redirect_to todo_lists_path, notice: "Todo list deleted."
  end

def share
  @todo_list = current_user.todo_lists.find(params[:id])
  render layout: false if turbo_frame_request?
end

def create_share
  @todo_list = current_user.todo_lists.find(params[:id])
  user = User.find_by(email: params[:email])

  if user && user != current_user
    if @todo_list.shared_users.include?(user)
      redirect_to share_todo_list_path(@todo_list), alert: "Already shared with this user."
    else
      @todo_list.shared_lists.create(user: user, permission: params[:permission])
      redirect_to share_todo_list_path(@todo_list), notice: "List shared successfully."
    end
  else
    redirect_to share_todo_list_path(@todo_list), alert: "User not found."
  end
end

  private

  def set_todo_list
    @todo_list = TodoList.find(params[:id])

    unless @todo_list.user == current_user || current_user.shared_todo_lists.include?(@todo_list)
      redirect_to todo_lists_path, alert: "You don't have access to that list."
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to todo_lists_path, alert: "List not found."
  end

  def todo_list_params
    params.require(:todo_list).permit(:title, :description)
  end
end
