import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['mainContentFrame'];

  connect() {
    const lastUrl = window.sessionStorage.getItem('spaFrameUrl');
    if (lastUrl) {
      this.mainContentFrameTarget.src = lastUrl;
    }

    this.mainContentFrameTarget.addEventListener('turbo:frame-load', (event) => {
      const newUrl = event.detail.url;
      window.sessionStorage.setItem('spaFrameUrl', newUrl);
    });
  }
}
