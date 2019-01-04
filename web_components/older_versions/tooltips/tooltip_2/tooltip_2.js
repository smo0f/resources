// Need to extend HTMLElement to create custom HTML element
class Tooltip extends HTMLElement {
    // Like PHP, runs this function each time an object is instantiated
    // good for basic initialization basic info
    constructor() {
        super();
        this._tooltipContainer;
        this._tooltipText = "Default tooltip text!";
        // add the shadow dom
        // this.attachShadow({mode: "open"});
    }
    
    // This method is called when the web component connects to the real dom
    connectedCallback() {
        // Check to see if we have attribute, if true, set
        if (this.hasAttribute('text')) {
            this._tooltipText = this.getAttribute('text'); 
        }
        const tooltipIcon = document.createElement('span');
        tooltipIcon.textContent = ' (?)';
        // bind(this) Makes sure that "this" in side of _showTooltip Refers to the class
        tooltipIcon.addEventListener('mouseenter', this._showTooltip.bind(this));
        tooltipIcon.addEventListener('mouseleave', this._hideTooltip.bind(this));
        this.appendChild(tooltipIcon);
        this.style.position = "relative";
    }

    // Class methods
    // the "_"  Indicates that you should use it outside of the class, it can, but you should
    _showTooltip() {
        this._tooltipContainer = document.createElement('div');
        this._tooltipContainer.textContent = this._tooltipText;
        this._tooltipContainer.style.backgroundColor = "black";
        this._tooltipContainer.style.color = "white";
        this._tooltipContainer.style.position = "absolute";
        this._tooltipContainer.style.zIndex = "10";
        this.appendChild(this._tooltipContainer);
    }

    _hideTooltip() {
        this.removeChild(this._tooltipContainer);
    }
}

// Has to be at lest two words extended by a "-" dash
customElements.define('wrap-tooltip', Tooltip);

// todo: add resize listener, for concept
// todo: add array of info, or list that will be compiled to an array