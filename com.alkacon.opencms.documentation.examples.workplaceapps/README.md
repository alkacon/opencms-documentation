# Example for a new context menu item #
Since OpenCms 10 the workplace is easily extendible.
Here we show how to add new apps and how to make up a new app category.

## Result ##
When you install the module and restart OpenCms (to load the Jar shipped with the module),
the Launchpad should show a new app category "Example Apps" with the new apps "Form" and "List".

The "Form" app shows an input form and features three other states just showing labels.
It is very simple in terms of functionality, but explains the main features for apps.

The "List" app shows a list of xml contents of a selectable type. The list is similar to the list
in the explorer. The resources shown can be determined via different options. The example is more
involved in terms of functionality than the "Form" app. The main extra knowledge you can gain 
compared to the "Form" app is about creating resource lists and using OpenCms specific components.

## Implementation ##
Just for convenience, we produced a whole module. The only interesting stuff is in the jar, shipped with the module.
These are the resources in the `src/` subfolder, in particular the folder contains:

* A new app category (`AppCategoryExample`)
* The "Form" workplace app (`FormApp`) and it's configuration (`FormAppConfiguration`)
* The "List" workplace app (`ListApp`) and it's configuration (`ListAppConfiguration`)
* An icon used in the "Form" app is located in the `OPENCMS` subfolder
* The registration information for the apps and the app category located under `META-INF/services`.

### Implementing the app category ###
An app category is a class implementing `I_CmsAppCategory`. It set up a new panel in the Launchpad.

See the example implementation `AppCategoryExample`for more details.

To make the system aware of the app category, it has to be registered by adding a file `META-INF/services/org.opencms.ui.apps.I_CmsAppCategory` containing just one line with the fully qualified name of the category implementation.

### Writing a workplace app ###
Workplace apps are classes implementing `I_CmsWorkplaceApp`. In the examples, we extend the abstract
class `A_CmsWorkplaceApp` that implements the interface and adds a lot more methods. Extending this class is 
typically the way to create own workplace apps. It ensures that look & feel of your app is similar to the
look & feel of the default apps.
Workplace apps need to be configured. They need a name, an app category they should be placed in and some other
information on how and when they should be shown in the Launchpad. The configuration is an implementation of the
interface `I_CmsWorkplaceAppConfiguration`. Via the method `getAppInstance` in that interface, the app itself
is returned.

To make the system aware of an app, it's configuration has to be registered by adding a file `META-INF/services/org.opencms.ui.apps.I_CmsWorkplaceAppConfiguration` containing (for each app you want to register) a line with
the fully qualified name of the app configuration.

#### The "Form" app ####
Have a look at `FormApp`. It's an app implementation with multiple states (or views) and (state-dependent) sub-navigation. To help you exploring the code:

* `getBreadCrumbForState` tells how the breadcrumb navigation should look for different states
* `getComponentForState` provides the state specific GUI (Vaadin) Component that is shown
* `getSubNavEntries` tells which navigation entries should be shown in a certain state

#### The "List" app ####
The "List" app shows how to use a resource list in a workplace app. Watch out for `m_fileTable` in
the code. Apart from resource list, and its configuration - which is app specific functionality, the
app is extremely simple. It has just one state.

### Localizations ###
The OpenCms workplace is multilingual. You can change the workplace locale. So your apps should usually support multiple languages as well. The examples do not. Have a look at the
documentation example for implementing context menu items to see how localization works.
The example reflects how localizations are usually done in OpenCms. 
