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
import org.opencms.main.CmsLog;
import org.opencms.relations.CmsRelation;
import org.opencms.relations.CmsRelationFilter;
import org.opencms.util.CmsCollectionsGenericWrapper;
import org.opencms.util.CmsUUID;

import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.Transformer;
import org.apache.commons.logging.Log;

/**
 * Helper to find pages where a content is placed on.
 */
public class PageFinder extends CmsJspBean {

    /** The log object for this class. */
    private static final Log LOG = CmsLog.getLog(CmsUUID.class);

    /** Type id of container pages */
    private static final int CONTAINERPAGE_TYPE_ID = 13;

    /** the lazily initialized map of resource - pages on relations */
    private Map<CmsUUID, List<PageBean>> m_pages;

    /**
     * Returns the links to the pages where the content is displayed.
     * @return map from UUIDs to lists of the pages where the specified resources are displayed.
     */
    public Map<CmsUUID, List<PageBean>> getDisplayedOnLinks() {

        try {
            if (isNotInitialized()) {
                throw (new Exception("Object of type TopicExplorer is not initialized. Pleas call init(...)"));
            }
            return getDisplayedOnLinksInternal();
        } catch (Exception e) {
            LOG.error(e.getStackTrace());
            return null;
        }
    }

    /**
     * Returns the links to the pages where the content is displayed.
     * @return map from UUIDs to lists of the pages where the specified resources are displayed.
     */
    private Map<CmsUUID, List<PageBean>> getDisplayedOnLinksInternal() {

        if (m_pages == null) {
            m_pages = CmsCollectionsGenericWrapper.createLazyMap(new Transformer() {

                public Object transform(Object resourceId) {

                    String id = resourceId.toString();
                    if (CmsUUID.isValidUUID(id)) {
                        return getDisplayedOnLinksForResource(CmsUUID.valueOf(id));
                    } else {
                        LOG.error("Provided Resource ID is invalid");
                        return (new LinkedList<PageBean>());
                    }
                }
            });
        }
        return m_pages;
    }

    private List<PageBean> getDisplayedOnLinksForResource(final CmsUUID structureId) {

        List<PageBean> result = new LinkedList<PageBean>();
        try {
            CmsObject cmsObject = this.getCmsObject();
            CmsRelationFilter filter = CmsRelationFilter.SOURCES;
            CmsResource resource = cmsObject.readResource(structureId);
            List<CmsRelation> relations = cmsObject.getRelationsForResource(resource, filter);
            List<CmsResource> sources = new LinkedList<CmsResource>();
            for (CmsRelation relation : relations) {
                sources.add(cmsObject.readResource(relation.getSourceId()));
            }
            Iterator<CmsResource> sourceIterator = sources.iterator();
            while (sourceIterator.hasNext()) {
                CmsResource source = sourceIterator.next();
                if (source.getTypeId() != CONTAINERPAGE_TYPE_ID) {
                    sourceIterator.remove();
                }
            }
            for (CmsResource source : sources) {
                result.add(new PageBean(cmsObject.getSitePath(source), cmsObject.readPropertyObject(
                    source,
                    "Title",
                    true).getValue(), cmsObject.readPropertyObject(source, "NavText", true).getValue()));
            }
            return result;
        } catch (Exception e) {
            LOG.error(e.getStackTrace());
            return result;
        }
    }
}
