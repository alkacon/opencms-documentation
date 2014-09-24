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

    /** folders where content is searched in */
    private String[] m_folders = null;
    /** type id of the content that is searched for */
    private Integer m_typeId = null;

    /**
     * Command interface used to allow several tasks to be preformed on each resource.
     */
    public interface Command {

        /**
         * Method that should be executed to perform a task/command.
         * @param cmsObject CmsObject that can be used for the task
         * @param resource Resource on which the task is performed
         * @return true if the task was successfully performed, false otherwise
         * @throws CmsException can be thrown to allow resource operations without direct error handling.
         */
        public boolean execute(CmsObject cmsObject, CmsResource resource) throws CmsException;
    }

    /**
     * Wraps the auto-correct-content method as command.
     */
    public class AutoCorrectCommand implements Command {

        /**
         * Autocorrects the content of the given CmsResource.
         * @see com.alkacon.opencms.documentation.editortools.ContentActionPerformer.Command#execute(org.opencms.file.CmsObject, org.opencms.file.CmsResource)
         */
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

    /**
     * Wraps the delete-unused-content method as command.
     */
    public class DeleteUnusedContentCommand implements Command {

        /**
         * Checks if the provided resource is placed on a container page. If not, it deletes the resource. Deletion is not published.
         * 
         * @see com.alkacon.opencms.documentation.editortools.ContentActionPerformer.Command#execute(org.opencms.file.CmsObject, org.opencms.file.CmsResource)
         */
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

    /**
     * Searches all resources of specified type and folder and performs the given action on each of the found resources.
     * @param action The action to perform on all found resources.
     * @return A String value saying on how many resources the action has been performed, or the stacktrace of an exception, if one occurs.
     */
    public String doAction(final Command action) {

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
                    if (resource.getTypeId() == m_typeId.intValue()) { //if m_typeId would be null, this line is never reached
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

    /**
     * Sets the member variables m_folders and m_typeId
     * 
     * @throws CmsLoaderException Can occur when getting the type id from a type name.
     */
    private void setFoldersAndTypeId() throws CmsLoaderException {

        setFolders();
        setTypeId();
    }

    /**
     * Read the folder parameters and store the values in m_folders.
     */
    private void setFolders() {

        Map<String, String[]> parameterMap = getRequest().getParameterMap();
        m_folders = parameterMap.get("folder");
    }

    /**
     * Read the typeName parameter, get the type id for the name and store it in m_typeId.
     * 
     * @throws CmsLoaderException
     */
    private void setTypeId() throws CmsLoaderException {

        String typeName = getRequest().getParameter("typeName");
        CmsResourceManager manager = OpenCms.getResourceManager();
        I_CmsResourceType type = manager.getResourceType(typeName);
        m_typeId = Integer.valueOf(type.getTypeId());
    }
}
