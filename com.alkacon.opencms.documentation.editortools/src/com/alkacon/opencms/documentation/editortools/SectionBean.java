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

import org.opencms.util.CmsUUID;

import java.util.List;

/** Bean to expose information about a section and it's TODOs easily in a JSP. */
public class SectionBean {

    /** Structure id of the documentation-section content */
    private CmsUUID m_structureId;
    /** Headline of the section */
    private String m_headline;
    /** RefId of the section content */
    private String m_refId;
    /** Todos of the section */
    private List<String> m_todos;

    /** Constructor for the section bean where all values are set.
     * @param structureId Structure id of the documentation-section content
     * @param headline The section's headline
     * @param refId The section's RefId
     * @param todos the TODOs for the section
     */
    public SectionBean(final CmsUUID structureId, final String headline, final String refId, final List<String> todos) {

        m_headline = headline;
        m_refId = refId;
        m_todos = todos;
        m_structureId = structureId;
    }

    /**
     * @return Headline of the section
     */
    public String getHeadline() {

        return m_headline;
    }

    /**
     * @return RefId of the section
     */
    public String getRefId() {

        return m_refId;
    }

    /**
     * @return Todos for the section
     */
    public List<String> getTodos() {

        return m_todos;
    }

    /**
     * @return Structure id of the documentation-section resource.
     */
    public CmsUUID getStructureId() {

        return m_structureId;
    }
}
