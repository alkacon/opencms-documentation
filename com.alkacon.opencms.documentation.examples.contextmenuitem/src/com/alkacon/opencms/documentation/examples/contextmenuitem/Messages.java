
package com.alkacon.opencms.documentation.examples.contextmenuitem;

import org.opencms.i18n.A_CmsMessageBundle;
import org.opencms.i18n.I_CmsMessageBundle;

/**
 * Convenience class to access the localized messages of this OpenCms package.<p>
 *
 * @since 10.0.0
 */
public final class Messages extends A_CmsMessageBundle {

    /** Name of the used resource bundle. */
    private static final String BUNDLE_NAME = "com.alkacon.opencms.documentation.examples.contextmenuitem.messages";

    /** Static instance member. */
    private static final I_CmsMessageBundle INSTANCE = new Messages();
    /** Message constant for key in the resource bundle. */
    public static final String GUI_CONTEXTMENU_GREET_0 = "GUI_CONTEXTMENU_GREET_0";
    /** Message constant for key in the resource bundle. */
    public static final String GUI_CONTEXTMENU_HELLO_0 = "GUI_CONTEXTMENU_HELLO_0";
    /** Message constant for key in the resource bundle. */
    public static final String GUI_MESSAGE_HELLO_1 = "GUI_MESSAGE_HELLO_1";

    /**
     * Hides the public constructor for this utility class.<p>
     */
    private Messages() {

        // hide the constructor
    }

    /**
     * Returns an instance of this localized message accessor.<p>
     *
     * @return an instance of this localized message accessor
     */
    public static I_CmsMessageBundle get() {

        return INSTANCE;
    }

    /**
     * @see org.opencms.i18n.I_CmsMessageBundle#getBundleName()
     */
    @Override
    public String getBundleName() {

        return BUNDLE_NAME;
    }
}
