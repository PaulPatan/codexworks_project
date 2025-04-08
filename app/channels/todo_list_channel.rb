class TodoListChannel < ApplicationCable::Channel
  def subscribed
    todo_list = TodoList.find(params[:id])
    stream_for todo_list
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
