class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_todo_list
  before_action :set_task, only: [ :show, :edit, :update, :destroy ]

  def index
    @tasks = @todo_list.tasks
  end

  def show
  end

  def new
    @task = @todo_list.tasks.build
  end

  def create
    @task = @todo_list.tasks.build(task_params)
    if @task.save
      redirect_to todo_list_path(@todo_list), notice: "Task created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to todo_list_path(@todo_list), notice: "Task updated."
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to todo_list_path(@todo_list), notice: "Task deleted."
  end

  private

  def toggle_completed
    @task = @todo_list.tasks.find(params[:id])
    @task.update(completed: !@task.completed)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to todo_list_path(@todo_list) }
    end
  end

  def set_todo_list
    @todo_list = TodoList.find(params[:todo_list_id])

    shared_list = current_user.shared_lists.find_by(todo_list: @todo_list)

    unless @todo_list.user == current_user || shared_list
      redirect_to todo_lists_path, alert: "You don't have access to that list."
      return
    end

    if [ "create", "update", "destroy", "edit", "new" ].include?(action_name) &&
       shared_list && shared_list.permission == "read"
      redirect_to todo_list_path(@todo_list), alert: "You only have read permission for this list."
    end
  end

  def set_task
    @task = @todo_list.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:content, :completed, :deadline, :notes)
  end
end
