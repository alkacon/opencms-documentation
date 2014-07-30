
package com.alkacon.opencms.documentation.navigation;

import org.opencms.configuration.CmsConfigurationException;
import org.opencms.file.CmsObject;
import org.opencms.file.CmsResource;
import org.opencms.file.types.I_CmsResourceType;
import org.opencms.jsp.util.CmsJspContentAccessBean;
import org.opencms.loader.CmsLoaderException;
import org.opencms.loader.CmsResourceManager;
import org.opencms.main.CmsException;
import org.opencms.main.OpenCms;
import org.opencms.security.CmsRoleViolationException;
import org.opencms.xml.containerpage.CmsContainerBean;
import org.opencms.xml.containerpage.CmsContainerElementBean;
import org.opencms.xml.containerpage.CmsContainerPageBean;

import java.util.Collection;
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

public class PageNavBuilder {

    private static String SECTION_TYPE_NAME = "documentation-section";

    private CmsContainerPageBean m_page;
    private CmsContainerBean m_container;
    private CmsObject m_cmsObject;
    private Integer m_sectionTypeId = null;

    public PageNavBuilder(CmsContainerPageBean page, CmsContainerBean container, CmsObject cmsObject) {

        m_page = page;
        m_container = container;
        m_cmsObject = cmsObject;
    }

    public List<PageNavElement> getElements() {

        if (m_container == null) {
            return null;
        }

        List<PageNavElement> elements = null;
        try {
            elements = getElements(m_container, 1, "");
        } catch (CmsException e) {
            System.err.println(e.getStackTrace());
        }
        return elements;
    }

    private List<PageNavElement> getElements(CmsContainerBean container, int level, String prefix) throws CmsException {

        List<PageNavElement> elements = new LinkedList<PageNavElement>();
        int position = 1;
        for (CmsContainerElementBean elem : container.getElements()) {
            elem.initResource(m_cmsObject);
            CmsResource elemResource = elem.getResource();
            if (elemResource.getTypeId() == getSectionTypeId()) {
                CmsJspContentAccessBean sectionContent = new CmsJspContentAccessBean(m_cmsObject, elemResource);
                String newPrefix = prefix.isEmpty() ? Integer.toString(position) : prefix
                    + "."
                    + Integer.toString(position);
                String title = newPrefix + " " + sectionContent.getValue().get("Headline").toString();
                elements.add(new PageNavElement(level, position, title, newPrefix));
                elements.addAll(getPossibleSubElements(elem, level, newPrefix));
                position += 1;
            }
        }
        return elements;
    }

    private int getSectionTypeId() throws CmsRoleViolationException, CmsConfigurationException, CmsLoaderException {

        if (m_sectionTypeId == null) {
            CmsResourceManager manager = OpenCms.getResourceManager();
            I_CmsResourceType type = manager.getResourceType(SECTION_TYPE_NAME);
            m_sectionTypeId = Integer.valueOf(type.getTypeId());
        }
        return m_sectionTypeId.intValue();
    }

    private List<PageNavElement> getPossibleSubElements(CmsContainerElementBean elem, int level, String prefix)
    throws CmsException {

        String elemInstanceId = elem.getInstanceId();
        Collection<CmsContainerBean> containers = m_page.getContainers().values();
        for (CmsContainerBean container : containers) {
            if ((container.getParentInstanceId() != null) && container.getParentInstanceId().equals(elemInstanceId)) {
                return getElements(container, level + 1, prefix);
            }
        }
        return new LinkedList<PageNavElement>();
    }
}
