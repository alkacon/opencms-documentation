
package com.alkacon.opencms.documentation.navigation;

import com.alkacon.opencms.documentation.sectionindexer.SectionIndexer;

import org.opencms.file.CmsObject;
import org.opencms.file.CmsResource;
import org.opencms.file.types.I_CmsResourceType;
import org.opencms.jsp.util.CmsJspContentAccessBean;
import org.opencms.jsp.util.CmsJspStandardContextBean;
import org.opencms.loader.CmsLoaderException;
import org.opencms.loader.CmsResourceManager;
import org.opencms.main.CmsException;
import org.opencms.main.OpenCms;
import org.opencms.xml.containerpage.CmsContainerBean;
import org.opencms.xml.containerpage.CmsContainerElementBean;
import org.opencms.xml.containerpage.CmsContainerPageBean;

import java.util.LinkedList;
import java.util.List;

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
/**
 * Builder for a page-navigation in the documentation. 
 * Builds up a list of navigation elements similar to the OpenCms navigation mechanism.
 */
public class PageNavBuilder {

    /** Type name of the sections that should appear in the navigation. */
    private static String SECTION_TYPE_NAME = "documentation-section";

    /** Container where to search for sections. */
    private CmsContainerBean m_container;

    /** CmsObject for the request context in which the page for which the navigation is build is accessed. */
    private CmsObject m_cmsObject;

    /** Type-id of the sections that should appear in the navigation. Initialized lazily. */
    private Integer m_sectionTypeId = null;

    /** Current position in the navigation */
    private int m_position;

    /** Section indexer to generate the section numbers */
    private SectionIndexer m_indexer;

    /** List of the navigation elements extracted from the sections. */
    private List<PageNavElement> m_navElements;

    /**
     * @param cmsBean the current CmsJspStandardContextBean
     * @param containerName name of the container where the content that should be navigated is in.
     */
    public PageNavBuilder(final CmsJspStandardContextBean cmsBean, final String containerName) {

        CmsContainerPageBean containerpage = cmsBean.getPage();
        m_container = containerpage.getContainers().get(containerName);
        m_cmsObject = cmsBean.getVfs().getCmsObject();
        m_position = 1;
        m_navElements = new LinkedList<PageNavElement>();
    }

    /**
     * @return list of navigation elements
     */
    public List<PageNavElement> getNavElements() {

        // collect elements if possible and not already done
        if ((m_container != null) && m_navElements.isEmpty()) {
            collectNavElements();
        }
        return m_navElements;
    }

    /**
     * Collect navigation elements with error handling.
     */
    private void collectNavElements() {

        try {
            collectNavElementsInternal();
        } catch (Exception e) {
            System.err.println(e.getStackTrace());
        }
    }

    /**
     * Collect navigation elements.
     * @throws CmsException 
     */
    private void collectNavElementsInternal() throws CmsException {

        m_indexer = new SectionIndexer();

        for (CmsContainerElementBean elem : m_container.getElements()) {
            CmsResource elemResource = getElemResource(elem);
            if (isSection(elemResource)) {
                String levelString = elem.getSettings().get("level");
                // the following works because the element setting is present only if explicitly set
                // default values are not present, thus take the default value if the setting is not present. 
                int level = levelString != null ? Integer.valueOf(levelString).intValue() : 1;
                addSectionToPageNav(elemResource, level);
            }
        }
    }

    /**
     * @param elem container element where the resource should be returned from
     * @return resource of the container element
     * @throws CmsException
     */
    private CmsResource getElemResource(final CmsContainerElementBean elem) throws CmsException {

        elem.initResource(m_cmsObject);
        return elem.getResource();
    }

    /**
     * Checks if a resource has the section type.
     * 
     * @param resource the resource to check
     * @return flag, indicating if the resource has the section type.
     * @throws CmsLoaderException
     */
    private boolean isSection(final CmsResource resource) throws CmsLoaderException {

        return resource.getTypeId() == getSectionTypeId();
    }

    /**
     * @return the section type id.
     * @throws CmsLoaderException
     */
    private int getSectionTypeId() throws CmsLoaderException {

        if (m_sectionTypeId == null) {
            CmsResourceManager manager = OpenCms.getResourceManager();
            I_CmsResourceType type = manager.getResourceType(SECTION_TYPE_NAME);
            m_sectionTypeId = Integer.valueOf(type.getTypeId());
        }
        return m_sectionTypeId.intValue();
    }

    /**
     * Adds a section to the list of navigation elements.
     * @param section the section to add
     * @param level the level of the section
     */
    private void addSectionToPageNav(final CmsResource section, final int level) {

        CmsJspContentAccessBean sectionContent = new CmsJspContentAccessBean(m_cmsObject, section);
        String index = m_indexer.getSectionIndex(level);
        String title = index + " " + sectionContent.getValue().get("Headline").toString();
        m_navElements.add(new PageNavElement(level, m_position, title, index));
        m_position += 1;
    }
}
