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

package com.alkacon.opencms.documentation.navigation;

/**
 * Wraps a navigation entry of the page navigation.
 */
public class PageNavElement {

    /** Title of the navigation element */
    private String m_title;

    /** Nesting level of the navigation element */
    private int m_level;

    /** Position of the element in the navigation list */
    private int m_position;

    /** Link to the element on the page */
    private String m_link;

    /**
     * @param level Nesting level of the navigation element
     * @param position Position of the element on the page
     * @param title Title of the element
     * @param link Link to the element
     */
    public PageNavElement(final int level, final int position, final String title, final String link) {

        m_level = level;
        m_position = position;
        m_title = title;
        m_link = link;
    }

    /**
     * @return Title of the navigation element
     */
    public String getTitle() {

        return m_title;
    }

    /**
     * @return Nesting level of the navigation element
     */
    public int getNavLevel() {

        return m_level;
    }

    /**
     * @return Position of the navigation element
     */
    public int getPosition() {

        return m_position;
    }

    /**
     * @return Link to the navigation element
     */
    public String getLink() {

        return m_link;
    }
}
