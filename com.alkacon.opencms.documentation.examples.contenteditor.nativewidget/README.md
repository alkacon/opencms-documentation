# Example for a custom editor widget without using GWT #

OpenCms allows to extend the editor by custom widgets. The example shows the
implementation of a very simple input field as custom widget.

## Result ##
When you install the module and restart OpenCms (to load the Jar shipped with the module),
the new resource type "Example content using native custom input widget" (documentation-native-widget-example)
should be available.
You can add a content of that type via the explorer. Open it and you see the custom widget in action.
The content uses the custom widget for the first two element sequences. The third sequence uses the default
widget for String input that is shipped with OpenCms.

## Implementation ##
The widget is implemented in two parts: server-side Java code and client-side Java Script code.

The server-side code is found under `src/com.alkacon.opencms.documentation.examples.contenteditor.nativewidget.ExampleWidget.java`.

The client-side code is found under `resources/system/modules/com.alkacon.opencms.documentation.examples.contenteditor.nativewidget/resources/js/examplewidget.js`.

Both files are well-documented so have a look at the comments.

## Using the widget in the editor ##
To use the widget in the editor, you need to refer to the class of the server-side widget part in the <layout> node in your content's schema.
See `/resources/system/modules/com.alkacon.opencms.documentation.examples.contenteditor.nativewidget/schemas/documentation-native-widget-example.xsd` for an example.

### Registering the widget under a special name ###
If you do not want to refer to the widget via the complete class name, you can alias your widget in the
`opencms-vfs.xml` by adding a `widget` sub-node under `opencms/vfs/xmlcontent/widgets`.

## Enable inline editing ##
Inline editing is not enabled. To enable it, add the function `createNativeWrapedElement` in the client-side
code as already stated there via comments.