class NotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_notable

  def create
    @note = @notable.notes.build(note_params)
    @note.user = current_user

    if @note.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_back(fallback_location: root_path, notice: "Note added.") }
      end
    else
      respond_to do |format|
        format.html { redirect_back(fallback_location: root_path, alert: "Failed to add note.") }
      end
    end
  end

  def destroy
    @note = @notable.notes.find(params[:id])

    if @note.user == current_user
      @note.destroy
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_back(fallback_location: root_path, notice: "Note removed.") }
      end
    else
      redirect_back(fallback_location: root_path, alert: "You can't delete this note.")
    end
  end

  private

  def set_notable
    if params[:todo_list_id]
      @notable = TodoList.find(params[:todo_list_id])
    elsif params[:task_id]
      @notable = Task.find(params[:task_id])
    end
  end

  def note_params
    params.require(:note).permit(:content)
  end
end
