class ToggleBtn extends HTMLElement {
    // @ initializer method
    constructor() {
        super();
        // toggle switch
        this._isHidden = true;
        // shadow Dom button
        this._toggleBtn;
        // shadow Dom message
        this._togglePTag;
        // add the shadow dom
        this.attachShadow({mode: "open"});
        // default button text
        this.hideBtn = "Hide";
        this.showBtn = "Show";
        // HTML shadow Dom template structure, next one put this higher in the order
        this.shadowRoot.innerHTML = `
            <style>
                #info-box {
                    display: none;
                }

                button {
                    margin: 20px 0px;
                }
            </style>
            <button class="toggleBtn">Show</button>
            <p id="info-box">
                <slot>Default Toggle Text!</slot>
            </p>
        `;
        // shadow Dom button
        this._toggleBtn = this.shadowRoot.querySelector('.toggleBtn');
        // shadow Dom message
        this._togglePTag = this.shadowRoot.querySelector('#info-box');
    }

    // @ built-in class method when component mounts
    connectedCallback() {
        // Check to see if we have the attributes, if true, set
        if (this.hasAttribute('hideText')) {
            this.hideBtn = this.getAttribute('hideText');
        }
        if (this.hasAttribute('showText')) {
            this.showBtn = this.getAttribute('showText');
            this._toggleBtn.textContent = this.showBtn; 
        }
        
        //  console.log(this._togglePTag);
        // event listener for toggle button
        this._toggleBtn.addEventListener('click', this._toggleButton.bind(this));
        this.style.display = "block";
    }

    // @ class method
    _toggleButton() {
        // console.log('Hi, I am here!!!');
        if (this._isHidden) {
            this._togglePTag.style.display = 'block';
            this._toggleBtn.textContent = this.hideBtn;
            this._isHidden = false;
            // console.log('false');
        } else {
            this._togglePTag.style.display = 'none';
            this._toggleBtn.textContent = this.showBtn;
            this._isHidden = true;
            // console.log('true');
        }
    }
}

customElements.define('toggle-button', ToggleBtn);