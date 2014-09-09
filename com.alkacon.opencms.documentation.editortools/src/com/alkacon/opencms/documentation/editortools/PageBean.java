/*
 * This library is part of OpenCms -
 * the Open Source Content Management System
 *
 * Copyright (c) Alkacon Software GmbH (http://www.alkacon.com)
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

package com.alkacon.opencms.documentation.editortools;

/** Bean to provide information to build a link to a page (i.e., a Title, NavText and the VFS URI). */
public class PageBean {

    /** The page title */
    private String m_title;
    /** A navigation text for the page */
    private String m_navText;
    /** Link to the page (VFS URI) */
    private String m_link;

    /**
     * Page bean constructor that get's all the values available via the bean as arguments. 
     * 
     * @param link VFS URI of the page
     * @param navText NavText property of the page
     * @param title Title property of the page
     */
    public PageBean(final String link, final String navText, final String title) {

        m_title = title;
        m_navText = navText;
        m_link = link;
    }

    /**
     * @return Title of the page
     */
    public String getTitle() {

        return m_title;
    }

    /**
     * @return Navigation text for the page
     */
    public String getNavText() {

        return m_navText;
    }

    /**
     * @return Link to the page (VFS URI).
     */
    public String getLink() {

        return m_link;
    }
}
