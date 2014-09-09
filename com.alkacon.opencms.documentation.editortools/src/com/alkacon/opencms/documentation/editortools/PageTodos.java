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

/** Bean for convenient access of all TODOs on one page */
public class PageTodos {

    /** page bean */
    private PageBean m_pageBean;
    /** topic todos */
    private TopicBean m_topicTodos;
    /** section todos for each section */
    private List<SectionBean> m_sectionTodos;

    /** Construct a new PageTodos object, holding the todos for the given page.
     * @param page Page for which todos are stored
     * @param cmsObject CmsObject used to initialize the page bean
     * @throws CmsException
     */
    public PageTodos(final CmsResource page, final CmsObject cmsObject)
    throws CmsException {

        m_topicTodos = null;
        m_sectionTodos = new LinkedList<SectionBean>();
        initPageBean(page, cmsObject);
    }

    /** Init the page bean.
     * @param page resource of the container page
     * @param cmsObject CmsObject used to get informations from the provided page
     * @throws CmsException
     */
    private void initPageBean(final CmsResource page, final CmsObject cmsObject) throws CmsException {

        m_pageBean = new PageBean(
            cmsObject.getSitePath(page),
            cmsObject.readPropertyObject(page, "NavText", true).getValue(),
            cmsObject.readPropertyObject(page, "Title", true).getValue());
    }

    /**
     * @return PageBean holding the page information
     */
    public PageBean getPageInfo() {

        return m_pageBean;
    }

    /** Set the topic todos. If set more than once, the Topic bean gets overwritten.
     * @param topic TopicBean to add
     */
    public void addTopic(final TopicBean topic) {

        m_topicTodos = topic;
    }

    /**Add section todos for one section.
     * @param section SectionBean to add
     */
    public void addSection(final SectionBean section) {

        m_sectionTodos.add(section);
    }

    /**
     * @return TopicBean with the topic TODOs
     */
    public TopicBean getTopic() {

        return m_topicTodos;
    }

    /**
     * @return Get the list of sections holding there TODOs
     */
    public List<SectionBean> getSectionList() {

        return m_sectionTodos;
    }
}