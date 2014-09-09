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

import org.opencms.file.CmsObject;
import org.opencms.file.CmsResource;
import org.opencms.main.CmsException;

import java.util.LinkedList;
import java.util.List;

public class PageTodos {

    private CmsObject m_cmsObject;
    private PageBean m_pageBean;
    private CmsResource m_page;
    private TopicBean m_topicTodos;
    private List<SectionBean> m_sectionTodos;

    public PageTodos(CmsResource page, CmsObject cmsObject)
    throws CmsException {

        m_page = page;
        m_cmsObject = cmsObject;
        m_topicTodos = null;
        m_sectionTodos = new LinkedList<SectionBean>();
        initPageBean();
    }

    void initPageBean() throws CmsException {

        m_pageBean = new PageBean(m_cmsObject.getSitePath(m_page), m_cmsObject.readPropertyObject(
            m_page,
            "NavText",
            true).getValue(), m_cmsObject.readPropertyObject(m_page, "Title", true).getValue());
    }

    public PageBean getPageInfo() {

        return m_pageBean;
    }

    public void addTopic(TopicBean topic) {

        m_topicTodos = topic;
    }

    public void addSection(SectionBean section) {

        m_sectionTodos.add(section);
    }

    public TopicBean getTopic() {

        return m_topicTodos;
    }

    public List<SectionBean> getSectionList() {

        return m_sectionTodos;
    }
}