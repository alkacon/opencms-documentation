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

package com.alkacon.opencms.documentation.examples.contextmenuitem;

import org.opencms.file.CmsObject;
import org.opencms.file.CmsResource;
import org.opencms.main.OpenCms;
import org.opencms.ui.I_CmsDialogContext;
import org.opencms.ui.contextmenu.CmsMenuItemVisibilityMode;
import org.opencms.ui.contextmenu.I_CmsContextMenuItem;

import java.util.List;
import java.util.Locale;

import com.vaadin.ui.JavaScript;
import com.vaadin.ui.UI;

/** An example for a context menu item. It just displays a hello message if clicked. */
public class ExampleHelloContextMenuItem implements I_CmsContextMenuItem {

    /** The id of the parent context menu item. */
    private String m_parentId;

    /**
     * @param parentId the id of the parent context menu item.
     */
    public ExampleHelloContextMenuItem(String parentId) {

        m_parentId = parentId;
    }

    /**
     * @see org.opencms.ui.contextmenu.I_CmsContextMenuItem#executeAction(org.opencms.ui.I_CmsDialogContext)
     */
    @Override
    public void executeAction(I_CmsDialogContext context) {

        JavaScript.getCurrent().execute(
            "alert('"
                + Messages.get().getBundle(UI.getCurrent().getLocale()).key(
                    Messages.GUI_MESSAGE_HELLO_1,
                    context.getCms().getRequestContext().getCurrentUser().getFullName())
                + "')");
    }

    /**
     * @see org.opencms.ui.contextmenu.I_CmsContextMenuItem#getId()
     */
    @Override
    public String getId() {

        return "goodby";
    }

    /**
     * @see org.opencms.ui.contextmenu.I_CmsContextMenuItem#getOrder()
     */
    @Override
    public float getOrder() {

        return 20;
    }

    /**
     * @see org.opencms.ui.contextmenu.I_CmsContextMenuItem#getParentId()
     */
    @Override
    public String getParentId() {

        return m_parentId;
    }

    /**
     * @see org.opencms.ui.contextmenu.I_CmsContextMenuItem#getPriority()
     */
    @Override
    public int getPriority() {

        return 0;
    }

    /**
     * @see org.opencms.ui.contextmenu.I_CmsContextMenuItem#getTitle(java.util.Locale)
     */
    @Override
    public String getTitle(Locale locale) {

        return Messages.get().getBundle(locale).key(Messages.GUI_CONTEXTMENU_HELLO_0);
    }

    /**
     * @see org.opencms.ui.contextmenu.I_CmsContextMenuItem#getVisibility(org.opencms.file.CmsObject, java.util.List)
     */
    @Override
    public CmsMenuItemVisibilityMode getVisibility(CmsObject cms, List<CmsResource> resources) {

        if (resources.size() == 1) {
            CmsResource resource = resources.get(0);
            if (OpenCms.getResourceManager().matchResourceType("folder", resource.getTypeId())) {
                return CmsMenuItemVisibilityMode.VISIBILITY_INVISIBLE;
            } else {
                return CmsMenuItemVisibilityMode.VISIBILITY_ACTIVE;
            }
        }
        return CmsMenuItemVisibilityMode.VISIBILITY_INACTIVE;
    }

    /**
     * @see org.opencms.ui.contextmenu.I_CmsHasMenuItemVisibility#getVisibility(org.opencms.ui.I_CmsDialogContext)
     */
    @Override
    public CmsMenuItemVisibilityMode getVisibility(I_CmsDialogContext context) {

        return getVisibility(context.getCms(), context.getResources());
    }

    /**
     * @see org.opencms.ui.contextmenu.I_CmsContextMenuItem#isLeafItem()
     */
    @Override
    public boolean isLeafItem() {

        return true;
    }

}
