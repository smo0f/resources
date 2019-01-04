class ConfirmLink extends HTMLAnchorElement {
    connectedCallback() {
        this.addEventListener('click', event => {
            if (!confirm('Do you want to leave the site?')) {
                event.preventDefault();
            }
        })
    }
}

customElements.define('l-c', ConfirmLink, { extends: 'a'});