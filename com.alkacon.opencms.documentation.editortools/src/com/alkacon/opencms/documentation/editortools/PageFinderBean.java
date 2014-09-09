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

import org.opencms.file.CmsObject;
import org.opencms.file.CmsResource;
import org.opencms.jsp.CmsJspBean;
import org.opencms.main.CmsLog;
import org.opencms.util.CmsCollectionsGenericWrapper;
import org.opencms.util.CmsUUID;

import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.Transformer;
import org.apache.commons.logging.Log;

/**
 * Helper to find pages where a content is placed on.
 */
public class PageFinderBean extends CmsJspBean {

    /** The log object for this class. */
    private static final Log LOG = CmsLog.getLog(CmsUUID.class);

    /** the lazily initialized map of resource - pages on relations */
    private Map<CmsUUID, List<PageBean>> m_pages;

    /**
     * Returns the links to the pages where the content is displayed.
     * @return map from UUIDs to lists of the pages where the specified resources are displayed.
     */
    public Map<CmsUUID, List<PageBean>> getDisplayedOnLinks() {

        try {
            if (isNotInitialized()) {
                throw (new Exception("Object of type TopicExplorer is not initialized. Please call init(...)"));
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

                @SuppressWarnings("synthetic-access")
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

    /** Returns a list of container pages (as PageBeans) on which the given resource is shown.
     * @param structureId Structure id of the resource for which pages should be searched.
     * @return List of PageBean objects intantiated with the container pages the given resource is shown at
     */
    private List<PageBean> getDisplayedOnLinksForResource(final CmsUUID structureId) {

        List<PageBean> result = new LinkedList<PageBean>();
        CmsObject cmsObject = this.getCmsObject();
        List<CmsResource> sources = PageFinder.getDisplayedOnPages(cmsObject, structureId);
        try {
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
