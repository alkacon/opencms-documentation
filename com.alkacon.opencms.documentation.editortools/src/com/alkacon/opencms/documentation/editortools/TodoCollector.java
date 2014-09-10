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

import com.alkacon.opencms.documentation.editortools.utils.PageFinder;

import org.opencms.file.CmsResource;
import org.opencms.jsp.CmsJspBean;
import org.opencms.main.CmsException;
import org.opencms.main.CmsLog;
import org.opencms.main.OpenCms;
import org.opencms.search.CmsSearchException;
import org.opencms.search.CmsSearchResource;
import org.opencms.search.solr.CmsSolrIndex;
import org.opencms.search.solr.CmsSolrResultList;
import org.opencms.util.CmsUUID;

import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.PageContext;

import org.apache.commons.logging.Log;

/** Collect all TODOs from Topics and Sections, sort them by pages and expose them as Collection of PageTodos. */

public class TodoCollector extends CmsJspBean {

    /** The log object for this class. */
    private static final Log LOG = CmsLog.getLog(CmsUUID.class);

    /** Folder where the content of the documentation is stored in (relative to the site path) */
    private static final String CONTENT_SEARCH_FOLDER = "/opencms-documentation/.content";
    /** Name of the documentation's topic type */
    private static final String TOPIC_TYPE_NAME = "documentation-topic";
    /** Name of the documentation's section type */
    private static final String SECTION_TYPE_NAME = "documentation-section";
    /** Search index used for collecting TODOs */
    private static final String SOLR_INDEX_NAME = "Solr Offline";

    /** Headline Solr field */
    static final String HEADLINE_SOLR_FIELD = "headline_en";
    /** RefId Solr field */
    static final String REF_ID_SOLR_FIELD = "refId_en";
    /** Todos Solr field */
    static final String TODOS_SOLR_FIELD = "todos_en";

    /** Map with containerpages as keys (UUIDs) and the corresponding page todos as values */
    Map<CmsUUID, PageTodos> m_todos = null;
    /** Locale for which all TODOs are collected for */
    String m_locale;

    /** Initialize the bean and collect all TODOs.
     * @see org.opencms.jsp.CmsJspBean#init(javax.servlet.jsp.PageContext, javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
     */
    @Override
    public void init(final PageContext pageContext, final HttpServletRequest request, final HttpServletResponse response) {

        super.init(pageContext, request, response);
        try {
            collectTodos();
        } catch (CmsSearchException e) {
            LOG.error("CollectionError:\n" + CmsException.getStackTraceAsString(e));
        }
    }

    /**
     * @return Collection of all PageTodos
     */
    public Collection<PageTodos> getTodos() {

        return m_todos.values();
    }

    /** Collect the TODOs for all Topics and Sections of the documentation.
     * 
     * @throws CmsSearchException
     */
    private void collectTodos() throws CmsSearchException {

        m_locale = getCmsObject().getRequestContext().getLocale().getLanguage();
        m_todos = new HashMap<CmsUUID, PageTodos>();
        collectTopicTodos();
        collectSectionTodos();
    }

    /** Collect all Topic TODOs
     * 
     * @throws CmsSearchException
     */
    private void collectTopicTodos() throws CmsSearchException {

        CmsSolrIndex index = OpenCms.getSearchManager().getIndexSolr(SOLR_INDEX_NAME);
        String squery = buildQuery(TOPIC_TYPE_NAME);
        CmsSolrResultList results = index.search(getCmsObject(), squery);
        for (CmsSearchResource result : results) {
            addTopicTodos(result);
        }
    }

    /**
     * Build the Solr query for collecting TODOs
     * @param requestedType requested resource type (by name, e.g. TOPIC_TYPE_NAME or SECTION_TYPE_NAME)
     * @return Solr query for collecting the TODOs from the contents of the given resource type
     */
    private String buildQuery(final String requestedType) {

        return "q=todos_"
            + m_locale
            + ":[* TO *]&fq=type:"
            + requestedType
            + "&parent-folders=\""
            + this.getRequestContext().getSiteRoot()
            + CONTENT_SEARCH_FOLDER
            + "\"&rows=100000";
    }

    /** Add the TODOs of a found Topic to the pageTodos
     * 
     * @param topic Topic found via the Solr search
     */
    private void addTopicTodos(final CmsSearchResource topic) {

        List<CmsResource> pages = PageFinder.getDisplayedOnPages(getCmsObject(), topic.getStructureId());
        TopicBean topicBean = new TopicBean(topic.getStructureId(), topic.getMultivaluedField(TODOS_SOLR_FIELD));
        for (CmsResource page : pages) {
            if (!m_todos.containsKey(page.getStructureId())) {
                try {
                    m_todos.put(page.getStructureId(), new PageTodos(page, this.getCmsObject()));
                } catch (CmsException e) {
                    LOG.error("Could not create PageTodos." + CmsException.getStackTraceAsString(e));
                }
            }
            PageTodos pageTodos = m_todos.get(page.getStructureId());
            pageTodos.addTopic(topicBean);
        }
    }

    /** Collect all Section TODOs
     * 
     * @throws CmsSearchException
     */
    private void collectSectionTodos() throws CmsSearchException {

        CmsSolrIndex index = OpenCms.getSearchManager().getIndexSolr(SOLR_INDEX_NAME);
        String squery = buildQuery(SECTION_TYPE_NAME);
        CmsSolrResultList results = index.search(getCmsObject(), squery);
        for (CmsSearchResource result : results) {
            addSectionTodos(result);
        }
    }

    /** Add a section with it's TODOs to the correct PageTodo in the map of PageTodos
     * 
     * @param section
     */
    private void addSectionTodos(final CmsSearchResource section) {

        List<CmsResource> pages = PageFinder.getDisplayedOnPages(getCmsObject(), section.getStructureId());
        SectionBean sectionBean = new SectionBean(
            section.getStructureId(),
            section.getField(HEADLINE_SOLR_FIELD),
            section.getField(REF_ID_SOLR_FIELD),
            section.getMultivaluedField(TODOS_SOLR_FIELD));
        for (CmsResource page : pages) {
            if (!m_todos.containsKey(page.getStructureId())) {
                try {
                    m_todos.put(page.getStructureId(), new PageTodos(page, this.getCmsObject()));
                } catch (CmsException e) {
                    LOG.error("Could not create PageTodos." + CmsException.getStackTraceAsString(e));
                }
            }
            PageTodos pageTodos = m_todos.get(page.getStructureId());
            pageTodos.addSection(sectionBean);
        }
    }
}