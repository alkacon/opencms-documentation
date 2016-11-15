/** 
 * The function that is called to initialize the widget.
 * The name has to be the same as the one returned by
 * the getInitCall() in the server-side code of the widget.
 */
function initNativeExampleWidget(){
	/**
	 * The function registerWidgetFactory(..) is called when the editor
	 * is rendered and a field uses this widget.
	 * The object given as argument has to be structured as in
	 * the example.
	 */
	registerWidgetFactory({
	
    /**
     * The widget name and identifier.
     * This needs to be the same name as the one returned by getWidgetName()
     * in the server-side widget code.
     */         
    widgetName: "NativeExampleWidget",
	
    /**
     * Creates a new widget instance according to the configuration.
     */         
    createNativeWidget: function(/*String*/configuration){
	
      var widget ={
        _element: null, // the HTML element to render for the widget
        _active: true, // flag, indicating if the widget is active or not
        _input: null, // stores a reference to the input field
		
        /**
         * Returns the widget root element.
         */                 
        getElement: function(){
          if (!this._element){
		  	// create the HTML for the widget, if not already done
            this._element=document.createElement("div");
			// The widget renders the label and the input field
            var inner = 
				// The class for the label is important to support the different display types
            	'<div class="org-opencms-acacia-client-css-I_CmsLayoutBundle-I_Style-label"></div>'
				// The class at the div is important to support the different display types
            	+ '<div class="org-opencms-acacia-client-css-I_CmsLayoutBundle-I_Style-widget">'
					// Styling could be much more elegant with css classes and style changes for active/inactive widgets - but that's not the point of the demo.
            		+ '<input style="width: 100%; border-radius: 4px; border-color: blue; border-width:1px; border-style: solid; padding: 4px; background-color:white;" type="text"/>'
            	+ '</div>';
			console.log("Inner HTML: " + inner);
            this._element.innerHTML = inner;
			// store the input element for convenience reasons
            this._input = this._element.querySelector(".org-opencms-acacia-client-css-I_CmsLayoutBundle-I_Style-widget > input");
          }
          return this._element;
        },
        /**
         * Returns the widget value.
         */                 
        getValue: function(){
          return this._input.value;
        },
        /**
         * Returns if the widget is active.
         */                 
        isActive: function(){
          return this._active;
        },
        /**
         * Will be called once the widget element is attached to the DOM.
         */
        onAttachWidget: function(){
			// It's important do add the event listeners to make the editor aware of
			// value changes and focus events
            if (typeof this.onChangeCommand === "function") {
				// use the "keypress" event to track every change.
				// E.g. to get the "Save" option activated on your first key press in the widget
            	this._input.addEventListener("keypress", this.onChangeCommand);
            }
            if (typeof this.onFocusCommand === "function") {
				// The editor will only adjust it's own highlighting for focused fields if you add this handler
            	this._input.addEventListener("focus", this.onFocusCommand);
            }
			// Optionally implement an entity change listener
			// it is called when the watched fields change.
			// The path to the watched field can be provided via the configuration.
			// The DependentSelectWidget of the core uses the function.
            // cmsAddEntityChangeListener({
            //    onChange: function(entity){
            //        // do something
            //    }
            // }, "path to content field to watch eg. '/Title'")
        },
        /**
         * Activates or deactivates the widget. 
		 *
		 * The function is called by the editor, so it must be implemented.
         */
        setActive: function(/*boolean*/active){
          this._active=active;
		  // It's important to call onChangeCommand. Otherwise the edit-point options are not shown again
		  if(active && typeof this.onChangeCommand === "function") this.onChangeCommand();
        },
        /**
         * Sets the widget value and fires the change event if required.
		 *
		 * The function is called by the editor, so it must be implemented.
         */                
        setValue: function(/*String*/value, /*boolean*/fireEvent){
          this._input.value=value;
          if (fireEvent && typeof this.onChangeCommand === "function"){
            this.onChangeCommand();
          }
        },
        /**
         * Set label and help text. Called by the editor if needed.
		 *
		 * The function is called by the editor, so it must be implemented.		 
         */
        setWidgetInfo: function(/*String*/ label, /*String*/ help){
        	var element = this.getElement();
        	var labelelement = element.querySelector(".org-opencms-acacia-client-css-I_CmsLayoutBundle-I_Style-label");
        	labelelement.setAttribute('title', help);
        	labelelement.innerText = label;
        },
        /**
         * Delegates the value change event to the editor.
         * This function will be attached to the widget by the editor.
         * 
         * It is required to call this function every time the widget value changes.
         * Changes that are not propagated through this function won't be saved.                           
         */                           
        onChangeCommand: null,
        /**
         * Delegates the focus event to the editor.
         * This function will be attached to the widget by the editor.
         * 
         * It is required to call this function on widget focus, so the editor 
         * highlighting can be updated.                   
         */
        onFocusCommand: null
      }
      return widget;
    }
    /** 
     * Optionally add an implementation of 
     */
     // createNativeWrapedElement: function(/*String*/configuration, /*Element*/ element){ /*TODO*/ }
    /**
     * to support inline editing for your widget. The function is structurally identical 
     * to "createNativeWidget". The configuration is also the same. The additional argument "element"
     * contains the HTML element that has the rdfa annotation for the element using the widget.
     * 
     * Your task is to make the provided element editable. The widgets shipped with the core use
     * TinyMCE to do so. But of course, you can go a different way.
     */
})
}
