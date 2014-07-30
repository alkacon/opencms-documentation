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

package com.alkacon.opencms.toolscripts;

import org.opencms.file.CmsFile;
import org.opencms.file.CmsObject;
import org.opencms.file.CmsResource;
import org.opencms.file.CmsResourceFilter;
import org.opencms.file.types.I_CmsResourceType;
import org.opencms.jsp.CmsJspActionElement;
import org.opencms.loader.CmsResourceManager;
import org.opencms.main.CmsException;
import org.opencms.main.OpenCms;
import org.opencms.xml.content.CmsXmlContent;
import org.opencms.xml.content.CmsXmlContentFactory;

import java.util.List;

public class AutoCorrectContent extends CmsJspActionElement {

    public String autocorrect() {

        String folder = getRequest().getParameter("folder");
        String typeName = getRequest().getParameter("typeName");
        CmsObject cmsObject = getCmsObject();
        try {
            CmsResourceManager manager = OpenCms.getResourceManager();
            I_CmsResourceType type = manager.getResourceType(typeName);
            if (type != null) {
                int wantedTypeId = type.getTypeId();
                List<CmsResource> files = cmsObject.getResourcesInFolder(folder, CmsResourceFilter.ALL);
                for (CmsResource resource : files) {
                    if (resource.isFile()) {
                        CmsFile file = cmsObject.readFile(resource);
                        if (file.getTypeId() == wantedTypeId) {
                            CmsXmlContent xmlContent = CmsXmlContentFactory.unmarshal(cmsObject, file);
                            xmlContent.setAutoCorrectionEnabled(true);
                            file = xmlContent.correctXmlStructure(cmsObject);
                            cmsObject.lockResource(file);
                            cmsObject.writeFile(file);
                            cmsObject.unlockResource(file);
                        }
                    }
                }
            }
        } catch (CmsException e) {
            return CmsException.getStackTraceAsString(e);

        }
        return "Ok";
    }
}
