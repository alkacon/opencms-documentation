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

import org.opencms.file.CmsFile;
import org.opencms.file.CmsObject;
import org.opencms.file.CmsResource;
import org.opencms.file.CmsResourceFilter;
import org.opencms.file.types.I_CmsResourceType;
import org.opencms.jsp.CmsJspActionElement;
import org.opencms.loader.CmsLoaderException;
import org.opencms.loader.CmsResourceManager;
import org.opencms.main.CmsException;
import org.opencms.main.OpenCms;
import org.opencms.xml.content.CmsXmlContent;
import org.opencms.xml.content.CmsXmlContentFactory;

import java.util.List;
import java.util.Map;

/**
 * Class to auto-correct content. Used by the auto-correct-xml content formatter.
 */
public class ContentActionPerformer extends CmsJspActionElement {

    private String[] m_folders;
    private Integer m_typeId;

    /**
     * Does the auto-correction. Folder and type of the contents are specified via parameters handed over to the JSP that instantiates AutoCorrectContent.
     * 
     * @return Either "Ok", if everything went right, or otherwise the stacktrace of the error
     */
    public interface Command {

        public boolean execute(CmsObject cmsObject, CmsResource resource) throws CmsException;
    }

    public class AutoCorrectCommand implements Command {

        public boolean execute(CmsObject cmsObject, CmsResource resource) throws CmsException {

            if (resource.isFile()) {
                CmsFile file = cmsObject.readFile(resource);
                CmsXmlContent xmlContent = CmsXmlContentFactory.unmarshal(cmsObject, file);
                xmlContent.setAutoCorrectionEnabled(true);
                file = xmlContent.correctXmlStructure(cmsObject);
                cmsObject.lockResource(file);
                cmsObject.writeFile(file);
                cmsObject.unlockResource(file);
                return true;
            } else {
                return false;
            }
        }
    }

    public class DeleteUnusedContentCommand implements Command {

        public boolean execute(CmsObject cmsObject, CmsResource resource) throws CmsException {

            if (PageFinder.getDisplayedOnPages(cmsObject, resource.getStructureId()).isEmpty()) {
                cmsObject.lockResource(resource);
                cmsObject.deleteResource(cmsObject.getSitePath(resource), CmsResource.DELETE_PRESERVE_SIBLINGS);
                cmsObject.unlockResource(resource);
                return true;
            } else {
                return false;
            }
        }
    }

    public String doAction(Command action) {

        int countActions = 0;
        try {
            setFoldersAndTypeId();

            if ((m_folders == null) || (m_folders.length == 0) || (m_typeId == null)) {
                return ("Done nothing. No folders or type name where specified.");
            }

            CmsObject cmsObject = getCmsObject();
            for (String folder : m_folders) {
                List<CmsResource> resources = cmsObject.getResourcesInFolder(folder, CmsResourceFilter.ALL);
                for (CmsResource resource : resources) {
                    if (resource.getTypeId() == m_typeId) {
                        if (action.execute(cmsObject, resource) == true) {
                            countActions++;
                        }
                    }
                }
            }
        } catch (CmsException e) {
            return CmsException.getStackTraceAsString(e);
        }
        return ("Performed action on " + countActions + " contents.");
    }

    private void setFoldersAndTypeId() throws CmsLoaderException {

        setFolders();
        setTypeId();
    }

    private void setFolders() {

        Map<String, String[]> parameterMap = getRequest().getParameterMap();
        m_folders = parameterMap.get("folder");
    }

    private void setTypeId() throws CmsLoaderException {

        String typeName = getRequest().getParameter("typeName");
        CmsResourceManager manager = OpenCms.getResourceManager();
        I_CmsResourceType type = manager.getResourceType(typeName);
        m_typeId = type.getTypeId();
    }
}
