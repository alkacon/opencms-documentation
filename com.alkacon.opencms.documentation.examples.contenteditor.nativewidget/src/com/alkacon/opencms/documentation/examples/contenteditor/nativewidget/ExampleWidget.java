/*
 * File   : $Source$
 * Date   : $Date$
 * Version: $Revision$
 *
 * This library is part of OpenCms -
 * the Open Source Content Management System
 *
 * Copyright (C) 2002 - 2008 Alkacon Software (http://www.alkacon.com)
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * Lesser General Public License for more details.
 *
 * For further information about Alkacon Software, please see the
 * company website: http://www.alkacon.com
 *
 * For further information about OpenCms, please see the
 * project website: http://www.opencms.org
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

package com.alkacon.opencms.documentation.examples.contenteditor.nativewidget;

import org.opencms.file.CmsObject;
import org.opencms.file.CmsResource;
import org.opencms.i18n.CmsMessages;
import org.opencms.main.OpenCms;
import org.opencms.widgets.A_CmsWidget;
import org.opencms.widgets.I_CmsADEWidget;
import org.opencms.widgets.I_CmsWidget;
import org.opencms.widgets.I_CmsWidgetDialog;
import org.opencms.widgets.I_CmsWidgetParameter;
import org.opencms.xml.content.I_CmsXmlContentHandler.DisplayType;
import org.opencms.xml.types.A_CmsXmlContentValue;

import java.util.Collections;
import java.util.List;
import java.util.Locale;

/**
 * Server-side part of an example for a native widget that just renders an input field
 * like {@link org.opencms.widgets.CmsInputWidget}.
 */
public class ExampleWidget extends A_CmsWidget implements I_CmsADEWidget {

    /**
     * @see org.opencms.widgets.I_CmsADEWidget#getConfiguration(org.opencms.file.CmsObject, org.opencms.xml.types.A_CmsXmlContentValue, org.opencms.i18n.CmsMessages, org.opencms.file.CmsResource, java.util.Locale)
     */
    @Override
    public String getConfiguration(
        CmsObject cms,
        A_CmsXmlContentValue contentValue,
        CmsMessages messages,
        CmsResource resource,
        Locale contentLocale) {

        // Return the configuration as given <layout> node in the schema (XSD) where the widget is configured.
        // The returned String will be passed on to the client side widget
        return getConfiguration();
    }

    /**
     * @see org.opencms.widgets.I_CmsADEWidget#getCssResourceLinks(org.opencms.file.CmsObject)
     */
    @Override
    public List<String> getCssResourceLinks(CmsObject cms) {

        // We do not use any specific CSS for our widget.
        return null;
    }

    /**
     * The default display type to use. The type can be overwritten in the schema (XSD)
     * in the &lt;layout&gt; node where the widget is configured.
     *
     * @see org.opencms.widgets.I_CmsADEWidget#getDefaultDisplayType()
     */
    @Override
    public DisplayType getDefaultDisplayType() {

        return DisplayType.singleline;
    }

    /**
     * @see org.opencms.widgets.I_CmsWidget#getDialogWidget(org.opencms.file.CmsObject, org.opencms.widgets.I_CmsWidgetDialog, org.opencms.widgets.I_CmsWidgetParameter)
     */
    @Override
    public String getDialogWidget(CmsObject cms, I_CmsWidgetDialog widgetDialog, I_CmsWidgetParameter param) {

        // The method is not used in the ADE content editor it needs only to be implemented for the
        // default content editor used in before OpenCms 8.5. So we just return null
        //
        // If you still want to support the old editor, the method should return the HTML of the widget
        // @see org.opencms.widgets.CmsInputWidget#getDialogWidget(org.opencms.file.CmsObject, org.opencms.widgets.I_CmsWidgetDialog, org.opencms.widgets.I_CmsWidgetParameter)
        //   for an example implementation.
        return null;
    }

    /**
     * @see org.opencms.widgets.I_CmsADEWidget#getInitCall()
     */
    @Override
    public String getInitCall() {

        // Return the name of the Java Script function to call for initializing the widget.
        return "initNativeExampleWidget";
    }

    /**
     * @see org.opencms.widgets.I_CmsADEWidget#getJavaScriptResourceLinks(org.opencms.file.CmsObject)
     */
    @Override
    public List<String> getJavaScriptResourceLinks(CmsObject cms) {

        // The Java Script resources that should be included when the widget is used.
        return Collections.singletonList(
            OpenCms.getLinkManager().substituteLink(
                cms,
                "/system/modules/com.alkacon.opencms.documentation.examples.contenteditor.nativewidget/resources/js/examplewidget.js"));
    }

    /**
     * @see org.opencms.widgets.I_CmsADEWidget#getWidgetName()
     */
    @Override
    public String getWidgetName() {

        // the widget name and identifier, also used in client side Java Script
        return "NativeExampleWidget";
    }

    /**
     * Since only widgets belonging to the core should be marked internal, we return <code>false</code>.
     *
     * @see org.opencms.widgets.I_CmsADEWidget#isInternal()
     */
    @Override
    public boolean isInternal() {

        // this is no internal core widget, so return false
        return false;
    }

    /**
     * @see org.opencms.widgets.I_CmsWidget#newInstance()
     */
    @Override
    public I_CmsWidget newInstance() {

        return new ExampleWidget();
    }

}
