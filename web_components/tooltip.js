// # documentation
// ? https://developer.mozilla.org/en-US/docs/Web/Web_Components
// Need to extend HTMLElement to create custom HTML element
class Tooltip extends HTMLElement {
    // Like PHP, runs this function each time an object is instantiated
    // good for basic initialization basic info
    constructor() {
        super();
        this._tooltipContainer;
        this._tooltipIcon;
        this._tooltipText = "Default tooltip text!";
        // add the shadow dom
        this.attachShadow({mode: "open"});
        this.shadowRoot.innerHTML = `
            <style>
                /*styling our main component*/
                :host {
                    padding: 7px 10px;
                    border: 1px solid purple; 
                    /*display: block;*/
                    position: relative;
                }

                /*styling our main component that has an attribute, class, or ID etc.*/
                :host(.important) {
                    border: 1px solid red; 
                }

                /*styling our main component, with surrounding conditions*/
                :host-context(div) {
                    color: blueviolet;
                }

                div {
                    position: absolute;
                    top: 30px;
                    left: 0;
                    z-index: 10;
                    background-color: #000000;
                    color: #ffffff;
                    padding: 5px 7px;
                }
                
                .icon {
                    /*can use CSS variables from the light dom*/
                    background-color: var(--main-color);
                    border-radius: 50%;
                    color: #fff;
                    padding: 4px 7px 5px;
                    font-size: 11px;
                    font-weight: bold;
                }

                /*styling are slotted content, limitation on selection only the top-level element*/
                ::slotted(span) {
                    border-bottom: 1px dotted #fa9601;
                }
            </style>
            <slot>Default slot text</slot> 
            <span class="icon">?</span>
        `;
    }
    
    // This method is called when the web component connects to the real dom
    connectedCallback() {
        // Check to see if we have attribute, if true, set
        if (this.hasAttribute('text')) {
            this._tooltipText = this.getAttribute('text'); 
        }
        this._tooltipIcon = this.shadowRoot.querySelector('span');
        // bind(this) Makes sure that "this" in side of _showTooltip Refers to the class
        this._tooltipIcon.addEventListener('mouseenter', this._showTooltip.bind(this));
        this._tooltipIcon.addEventListener('mouseleave', this._hideTooltip.bind(this));
        // this.style.position = "relative";
    }

    // this is called when an observable attribute has changed
    // when called it receives three arguments, 
        // the name of the attribute = name
        // the value of the old attribute = oldValue
        // the value of the new attribute = newValue
    attributeChangedCallback(name, oldValue, newValue) {
        // console.log(name, oldValue, newValue);
        if (name === "text") {
            if (oldValue !== newValue) {
                this._tooltipText = newValue;  
            }  
        }
    }

    // setting Observable attributes, send back an array of all desired observable attributes, only the ones that we want to watch for changes
    static get observedAttributes() {
        return ["text"];
    }

    // Invoked when the custom element is disconnected from the document's DOM. perform code cleanup here
    disconnectedCallback() {
        this._tooltipIcon.removeEventListener('mouseenter', this._showTooltip);
        this._tooltipIcon.removeEventListener('mouseleave', this._hideTooltip);
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
// todo: add variables for a theme
// todo: add array of info, or list that will be compiled to an array
// todo: style based off of outward conditions, grid, not grid
// todo: make a render method