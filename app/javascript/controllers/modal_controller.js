import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
static targets = ['container'];

  connect() {
    this.toggleClass = 'hidden';
    this.backgroundId = 'modal-background';
    this.backgroundHtml = this._backgroundHTML();
    this.allowBackgroundClose = true;
  }

  disconnect() {
    this.close();
  }

  open() {
    document.addEventListener("submit:success", () => {
      this.close()
    }, { once: true });
    document.addEventListener("modal:loaded", () => {
      this.containerTarget.classList.remove(this.toggleClass);
    }, { once: true });
    
    document.body.classList.add('fixed', 'inset-x-0', 'overflow-hidden');
    document.body.insertAdjacentHTML('beforeend', this.backgroundHtml);
    this.background = document.querySelector(`#${this.backgroundId}`);
  }

  close() {
    if (typeof event !== 'undefined') {
      event.preventDefault()
    }
    this.containerTarget.classList.add(this.toggleClass);
    if (this.background) { this.background.remove() }
  }

  _backgroundHTML() {
    return `<div id="${this.backgroundId}" class="fixed top-0 left-0 w-full h-full" style="background-color: rgba(0, 0, 0, 0.7); z-index: 9998;"></div>`;
  }
}