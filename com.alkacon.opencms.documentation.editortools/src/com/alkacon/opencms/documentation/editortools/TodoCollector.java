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
import org.opencms.jsp.CmsJspBean;
import org.opencms.main.CmsException;
import org.opencms.main.CmsLog;
import org.opencms.main.OpenCms;
import org.opencms.relations.CmsRelation;
import org.opencms.relations.CmsRelationFilter;
import org.opencms.search.CmsSearchException;
import org.opencms.search.CmsSearchResource;
import org.opencms.search.solr.CmsSolrIndex;
import org.opencms.search.solr.CmsSolrResultList;
import org.opencms.util.CmsUUID;

import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.PageContext;

import org.apache.commons.logging.Log;

public class TodoCollector extends CmsJspBean {

    /** The log object for this class. */
    private static final Log LOG = CmsLog.getLog(CmsUUID.class);

    private static final String CONTENT_SEARCH_FOLDER = "/opencms-documentation/.content";
    private static final String TOPIC_TYPE_NAME = "documentation-topic";
    private static final String SECTION_TYPE_NAME = "documentation-section";
    private static final String SOLR_INDEX_NAME = "Solr Offline";

    /** Type id of container pages */
    private static final int CONTAINERPAGE_TYPE_ID = 13;

    Map<CmsUUID, PageTodos> m_todos = null;
    String m_locale;

    @Override
    public void init(PageContext pageContext, HttpServletRequest request, HttpServletResponse response) {

        super.init(pageContext, request, response);
        try {
            collectTodos();
        } catch (CmsSearchException e) {
            LOG.error("CollectionError:\n" + CmsException.getStackTraceAsString(e));
        }
    }

    public Collection<PageTodos> getTodos() {

        return m_todos.values();
    }

    private void collectTodos() throws CmsSearchException {

        m_locale = getCmsObject().getRequestContext().getLocale().getLanguage();
        m_todos = new HashMap<CmsUUID, PageTodos>();
        collectTopicTodos();
        collectSectionTodos();
    }

    private void collectTopicTodos() throws CmsSearchException {

        CmsSolrIndex index = OpenCms.getSearchManager().getIndexSolr(SOLR_INDEX_NAME);
        String squery = buildQuery(TOPIC_TYPE_NAME);
        CmsSolrResultList results = index.search(getCmsObject(), squery);
        for (CmsSearchResource result : results) {
            addTopicTodos(result);
        }
    }

    private String buildQuery(String requestedType) {

        return "q=todos_"
            + m_locale
            + ":[* TO *]&fq=type:"
            + requestedType
            + "&parent-folders=\""
            + this.getRequestContext().getSiteRoot()
            + CONTENT_SEARCH_FOLDER
            + "\"&rows=100000";
    }

    private void addTopicTodos(CmsSearchResource topic) {

        List<CmsResource> pages = getPagesForResource(topic.getStructureId());
        TopicBean topicBean = new TopicBean(topic.getStructureId(), topic.getMultivaluedField("todos_en"));
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

    private void collectSectionTodos() throws CmsSearchException {

        CmsSolrIndex index = OpenCms.getSearchManager().getIndexSolr(SOLR_INDEX_NAME);
        String squery = buildQuery(SECTION_TYPE_NAME);
        CmsSolrResultList results = index.search(getCmsObject(), squery);
        for (CmsSearchResource result : results) {
            addSectionTodos(result);
        }
    }

    private void addSectionTodos(CmsSearchResource section) {

        List<CmsResource> pages = getPagesForResource(section.getStructureId());
        SectionBean sectionBean = new SectionBean(
            section.getStructureId(),
            section.getField("headline_en"),
            section.getField("refId_en"),
            section.getMultivaluedField("todos_en"));
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

    private List<CmsResource> getPagesForResource(final CmsUUID structureId) {

        List<CmsResource> result = new LinkedList<CmsResource>();
        try {
            CmsObject cmsObject = this.getCmsObject();
            CmsRelationFilter filter = CmsRelationFilter.SOURCES;
            CmsResource resource = cmsObject.readResource(structureId);
            List<CmsRelation> relations = cmsObject.getRelationsForResource(resource, filter);
            result = new LinkedList<CmsResource>();
            for (CmsRelation relation : relations) {
                result.add(cmsObject.readResource(relation.getSourceId()));
            }
            Iterator<CmsResource> sourceIterator = result.iterator();
            while (sourceIterator.hasNext()) {
                CmsResource source = sourceIterator.next();
                if (source.getTypeId() != CONTAINERPAGE_TYPE_ID) {
                    sourceIterator.remove();
                }
            }
            return result;
        } catch (Exception e) {
            LOG.error(e.getStackTrace());
            return result;
        }
    }

    private String getTodosFieldName() {

        return "todos_" + m_locale;
    }

    private String getHeadlineFieldName() {

        return "headline_" + m_locale;
    }

    private String getRefIdFieldName() {

        return "refId_" + m_locale;
    }
}
