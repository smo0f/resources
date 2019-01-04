// Need to extend HTMLElement to create custom HTML element
class Tooltip extends HTMLElement {
    // Like PHP, runs this function each time an object is instantiated
    // good for basic initialization basic info
    constructor() {
        super();
        this._tooltipContainer;
        this._tooltipText = "Default tooltip text!";
        // add the shadow dom
        this.attachShadow({mode: "open"});
        this.shadowRoot.innerHTML = `
            <style>
                div {
                    position: absolute;
                    top: 20px;
                    left: 0;
                    z-index: 10;
                    background-color: #000000;
                    color: #ffffff;
                    padding: 5px 7px;
                }
            </style>
            <slot>Default slot text</slot> 
            <span> (?)</span>
        `;
    }
    
    // This method is called when the web component connects to the real dom
    connectedCallback() {
        // Check to see if we have attribute, if true, set
        if (this.hasAttribute('text')) {
            this._tooltipText = this.getAttribute('text'); 
        }
        const tooltipIcon = this.shadowRoot.querySelector('span');
        // bind(this) Makes sure that "this" in side of _showTooltip Refers to the class
        tooltipIcon.addEventListener('mouseenter', this._showTooltip.bind(this));
        tooltipIcon.addEventListener('mouseleave', this._hideTooltip.bind(this));
        this.shadowRoot.appendChild(tooltipIcon);
        this.style.position = "relative";
    }

    // Class methods
    // the "_"  Indicates that you should use it outside of the class, it can, but you should
    _showTooltip() {
        this._tooltipContainer = document.createElement('div');
        this._tooltipContainer.textContent = this._tooltipText;
        this.shadowRoot.appendChild(this._tooltipContainer);
    }

    _hideTooltip() {
        this.shadowRoot.removeChild(this._tooltipContainer);
    }
}

// Has to be at lest two words extended by a "-" dash
customElements.define('wrap-tooltip', Tooltip);

// todo: add resize listener, for concept
// todo: add array of info, or list that will be compiled to an array