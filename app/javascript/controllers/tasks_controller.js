import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['item', 'form', 'completedCheckbox'];

  connect() {
    console.log('Tasks controller connected');
  }

  toggleComplete(event) {
    const checkbox = event.target;
    const taskId = checkbox.dataset.taskId;
    const todoListId = checkbox.dataset.todoListId;
    const isCompleted = checkbox.checked;

    const span = checkbox.nextElementSibling;
    if (isCompleted) {
      span.classList.add('completed');
    } else {
      span.classList.remove('completed');
    }

    fetch(`/todo_lists/${todoListId}/tasks/${taskId}/toggle_completed`, {
      method: 'PATCH',
      headers: {
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content,
        'Accept': 'text/vnd.turbo-stream.html',
      },
    });
  }
}
