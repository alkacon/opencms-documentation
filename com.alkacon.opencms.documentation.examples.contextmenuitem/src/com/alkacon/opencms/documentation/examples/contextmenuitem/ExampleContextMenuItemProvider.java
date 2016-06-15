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

import org.opencms.ui.contextmenu.CmsSubmenu;
import org.opencms.ui.contextmenu.I_CmsContextMenuItem;
import org.opencms.ui.contextmenu.I_CmsContextMenuItemProvider;

import java.util.ArrayList;
import java.util.List;

/** Example for a context menu item provider, providing a main entry "greet" with a subentry "hello". */
public class ExampleContextMenuItemProvider implements I_CmsContextMenuItemProvider {

    /**
     * @see org.opencms.ui.contextmenu.I_CmsContextMenuItemProvider#getMenuItems()
     */
    @Override
    public List<I_CmsContextMenuItem> getMenuItems() {

        List<I_CmsContextMenuItem> items = new ArrayList<I_CmsContextMenuItem>(3);
        I_CmsContextMenuItem greet = new CmsSubmenu(
            "greet",
            null,
            "%(key." + Messages.GUI_CONTEXTMENU_GREET_0 + ")",
            3000,
            0);
        I_CmsContextMenuItem hello = new ExampleHelloContextMenuItem("greet");
        items.add(greet);
        items.add(hello);
        return items;
    }

}
