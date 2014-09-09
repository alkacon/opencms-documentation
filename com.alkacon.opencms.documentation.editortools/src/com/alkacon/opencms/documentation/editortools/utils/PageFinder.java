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

package com.alkacon.opencms.documentation.editortools.utils;

import org.opencms.file.CmsObject;
import org.opencms.file.CmsResource;
import org.opencms.file.types.CmsResourceTypeXmlContainerPage;
import org.opencms.main.CmsLog;
import org.opencms.relations.CmsRelation;
import org.opencms.relations.CmsRelationFilter;
import org.opencms.util.CmsUUID;

import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;

import org.apache.commons.logging.Log;

/** */
public class PageFinder {

    /** The log object for this class. */
    private static final Log LOG = CmsLog.getLog(CmsUUID.class);

    /**Get all container pages where a content is placed on.
     * 
     * @param cmsObject CmsObject used for resource access.
     * @param structureId Structure id of the content for which the pages where it is displayed on are returned.
     * @return List of CmsResource objects of the container pages where the given content is placed on.
     */
    public static List<CmsResource> getDisplayedOnPages(final CmsObject cmsObject, final CmsUUID structureId) {

        List<CmsResource> pages = new LinkedList<CmsResource>();
        try {
            CmsRelationFilter filter = CmsRelationFilter.SOURCES;
            CmsResource resource = cmsObject.readResource(structureId);
            List<CmsRelation> relations = cmsObject.getRelationsForResource(resource, filter);
            for (CmsRelation relation : relations) {
                pages.add(cmsObject.readResource(relation.getSourceId()));
            }
            Iterator<CmsResource> pageIterator = pages.iterator();
            while (pageIterator.hasNext()) {
                CmsResource source = pageIterator.next();
                if (source.getTypeId() != CmsResourceTypeXmlContainerPage.getContainerPageTypeId()) {
                    pageIterator.remove();
                }
            }
        } catch (Exception e) {
            LOG.error(e.getStackTrace());
            return (new LinkedList<CmsResource>());
        }
        return pages;
    }
}