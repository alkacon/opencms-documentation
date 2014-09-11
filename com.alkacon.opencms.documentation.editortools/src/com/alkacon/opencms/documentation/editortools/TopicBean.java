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

/**
 * Bean to conveniently get topic TODOs in a JSP.
 */
public class TopicBean {

    /** Sturcture id of the topic resource. */
    private CmsUUID m_structureId;
    /** List of the Topic's TODOs */
    private List<String> m_todos;

    /** Construct the bean and set it's values. 
     * @param structureId Structure id of the topic resource.
     * @param todos TODOs for the topic. 
     */
    public TopicBean(final CmsUUID structureId, final List<String> todos) {

        m_todos = todos;
        m_structureId = structureId;
    }

    /**
     * @return The TODOs of the topic.
     */
    public List<String> getTodos() {

        return m_todos;
    }

    /**
     * @return The sturcture id of the topic resource.
     */
    public CmsUUID getStructureId() {

        return m_structureId;
    }
}
