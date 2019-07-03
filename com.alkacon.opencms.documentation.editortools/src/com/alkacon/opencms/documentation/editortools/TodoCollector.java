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
import org.opencms.file.CmsResourceFilter;
import org.opencms.jsp.CmsJspBean;
import org.opencms.main.CmsException;
import org.opencms.main.CmsLog;
import org.opencms.main.OpenCms;
import org.opencms.search.CmsSearchException;
import org.opencms.search.CmsSearchResource;
import org.opencms.search.solr.CmsSolrIndex;
import org.opencms.search.solr.CmsSolrQuery;
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

    /** The folders to search in. */
    String m_folderRestriction;

    /**
     * @return Collection of all PageTodos
     */
    public Collection<PageTodos> getTodos() {

        return m_todos.values();
    }

    /** Initialize the bean and collect all TODOs.
     * @param pageContext current page context.
     * @param request current request.
     * @param response current response.
     * @param searchSiteFolders the site relative folders to search in. Defaults to the root path (of the site).
     * @see org.opencms.jsp.CmsJspBean#init(javax.servlet.jsp.PageContext, javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
     */
    @Override
    public void init(
        final PageContext pageContext,
        final HttpServletRequest request,
        final HttpServletResponse response) {

        init(pageContext, request, response, new String[] {});
    }

    /** Initialize the bean and collect all TODOs.
     * @param pageContext current page context.
     * @param request current request.
     * @param response current response.
     * @param searchSiteFolders the site relative folders to search in. Defaults to the root path (of the site).
     * @see org.opencms.jsp.CmsJspBean#init(javax.servlet.jsp.PageContext, javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
     */
    public void init(
        final PageContext pageContext,
        final HttpServletRequest request,
        final HttpServletResponse response,
        final String... searchSiteFolders) {

        super.init(pageContext, request, response);
        String siteRoot = super.getCmsObject().getRequestContext().getSiteRoot();
        if (!siteRoot.endsWith("/")) {
            siteRoot = siteRoot + "/";
        }
        if ((null == searchSiteFolders) || (searchSiteFolders.length == 0)) {
            m_folderRestriction = "\"" + siteRoot + "\"";
        } else {
            String folder = searchSiteFolders[0];
            if (folder.startsWith("/")) {
                folder = folder.substring(1);
            }

            if (searchSiteFolders.length == 1) {
                m_folderRestriction = "\"" + siteRoot + folder + "\"";
            } else {
                m_folderRestriction = "(\"" + siteRoot + folder + "\"";
                for (int i = 1; i < searchSiteFolders.length; i++) {

                    folder = searchSiteFolders[0];
                    if (folder.startsWith("/")) {
                        folder = folder.substring(1);
                    }
                    m_folderRestriction = m_folderRestriction + " OR \"" + siteRoot + folder + "\"";
                }
                m_folderRestriction = m_folderRestriction + ")";
            }
        }
        try {
            collectTodos();
        } catch (CmsSearchException e) {
            LOG.error("CollectionError:", e);
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
                    LOG.error("Could not create PageTodos.", e);
                }
            }
            PageTodos pageTodos = m_todos.get(page.getStructureId());
            pageTodos.addSection(sectionBean);
        }
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
                    LOG.error("Could not create PageTodos.", e);
                }
            }
            PageTodos pageTodos = m_todos.get(page.getStructureId());
            pageTodos.addTopic(topicBean);
        }
    }

    /**
     * Build the Solr query for collecting TODOs
     * @param requestedType requested resource type (by name, e.g. TOPIC_TYPE_NAME or SECTION_TYPE_NAME)
     * @return Solr query for collecting the TODOs from the contents of the given resource type
     */
    private CmsSolrQuery buildQuery(final String requestedType) {

        CmsSolrQuery result = new CmsSolrQuery();
        result.setQuery(TODOS_SOLR_FIELD + ":[* TO *]");
        result.addFilterQuery("parent-folders:" + m_folderRestriction);
        result.addFilterQuery("type:" + requestedType);
        result.setRows(Integer.valueOf(1000000));
        return result;
    }

    /** Collect all Section TODOs
     *
     * @throws CmsSearchException
     */
    private void collectSectionTodos() throws CmsSearchException {

        CmsSolrResultList results = search(SECTION_TYPE_NAME);
        for (CmsSearchResource result : results) {
            addSectionTodos(result);
        }
    }

    /** Collect the TODOs for all Topics and Sections of the documentation.
     *
     * @throws CmsSearchException
     */
    private void collectTodos() throws CmsSearchException {

        m_locale = getCmsObject().getRequestContext().getLocale().getLanguage();
        m_todos = new HashMap<>();
        collectTopicTodos();
        collectSectionTodos();
    }

    /** Collect all Topic TODOs
     *
     * @throws CmsSearchException
     */
    private void collectTopicTodos() throws CmsSearchException {

        CmsSolrResultList results = search(TOPIC_TYPE_NAME);
        for (CmsSearchResource result : results) {
            addTopicTodos(result);
        }
    }

    /**
     * Performs the actual search.
     * @param typeName the type of content to search.
     * @return the results.
     * @throws CmsSearchException thrown if searching fails.
     */
    private CmsSolrResultList search(String typeName) throws CmsSearchException {

        CmsSolrIndex index = OpenCms.getSearchManager().getIndexSolr(SOLR_INDEX_NAME);
        CmsSolrQuery query = new CmsSolrQuery();
        query.setQuery(TODOS_SOLR_FIELD + ":[* TO *]");
        query.addFilterQuery("parent-folders:" + m_folderRestriction);
        query.addFilterQuery("type:" + typeName);
        query.setRows(Integer.valueOf(1000000));
        return index.search(getCmsObject(), query, true, null, true, CmsResourceFilter.DEFAULT, 1000000);

    }
}