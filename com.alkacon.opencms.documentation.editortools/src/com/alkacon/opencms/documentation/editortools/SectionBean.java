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

public class SectionBean {

    private CmsUUID m_structureId;
    private String m_headline;
    private String m_refId;
    private List<String> m_todos;

    public SectionBean(CmsUUID structureId, String headline, String refId, List<String> todos) {

        m_headline = headline;
        m_refId = refId;
        m_todos = todos;
        m_structureId = structureId;
    }

    public String getHeadline() {

        return m_headline;
    }

    public String getRefId() {

        return m_refId;
    }

    public List<String> getTodos() {

        return m_todos;
    }

    public CmsUUID getStructureId() {

        return m_structureId;
    }
}
