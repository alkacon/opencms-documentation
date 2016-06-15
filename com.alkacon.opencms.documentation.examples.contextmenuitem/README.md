# Example for a new context menu item #
Since OpenCms 10 Explorer is very easily configurable.
Here we show how to add new context menu items.

## Result ##
When you install the module and restart OpenCms (to load the Jar shipped with the module),
the context menu for resources in the Explorer is extended - depending on the resources you
call the menu on:

* For a single folder, the menu has not changed
* For multiple resources the entry "Greet" with a deactivated sub-entry "Say hello" appears
* For a single non-folder resource, the menu is extended by the entry "Greet" with the active sub-entry "Say hello"

If you click the new entry, an alert box is displayed, saying hello.
 
## Implementation ##
Just for convenience, we produced a whole module. The only interesting stuff is in the jar, shipped with the module.
These are the resources in the `src/` subfolder, in particular the folder contains:

* A context menu item provider (`ExampleContextMenuItemProvider`)
* A context menu item (`ExampleHelloContextMenuItem`)
* Localizations (`Messages` and the `.properties` files)
* The registration information for the context menu item provider.

### Writing a context menu item provider ###
A context menu item provider is a class implementing `I_CmsContextMenuItemProvider`.
It basically provides one or more context menu items and fixes the item structure, i.e., which item is provided as subitem of another.

See the example implementation for more details.

### Writing a context menu item ###
Context menu items are classes implementing `I_CmsContextMenuItem`.
Typically, the have a constructor that takes the id of the parent menu item.
The interface of a context menu item has several methods that allow to:

* use items of the same class at different places (via the parent id)
* replace items by others (via a priority)
* fix the position of the item relative to other items on the same menu level (via the order)
* provide a localized item title (via getTitle(locale))
* tell when the item is visible and activated or deactivated - typically this depends on the resource selection and the role of the current user
* tell if the item is a leaf - meaning if it has sub-items or not.
 
For non-leaf items the class `CmsSubmenu` eases creating such items (see the example provider). Leaf-items you typically implement yourself. See the `ExampleHelloContextMenuItem` for details.

### Localizations ###
The OpenCms workplace is multilingual. You can change the workplace locale. So your context menu items should usually support multiple languages as well.
The example reflects how localizations are usually done in OpenCms. 

### Registering the context menu item provider ###
To get the whole thing working, you have to register your `org.opencms.ui.contextmenu.I_CmsContextMenuItemProvider` implementation.

To do so, add the file `META-INF/services/org.opencms.ui.contextmenu.I_CmsContextMenuItemProvider` to your jar,
containing just one line: the fully qualified class name of your `I_CmsContextMenuItemProvider` implementation.