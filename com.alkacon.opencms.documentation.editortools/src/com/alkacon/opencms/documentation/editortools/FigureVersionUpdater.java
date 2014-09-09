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

import org.opencms.file.CmsFile;
import org.opencms.file.CmsObject;
import org.opencms.file.CmsResource;
import org.opencms.jsp.CmsJspBean;
import org.opencms.main.CmsException;
import org.opencms.main.CmsLog;
import org.opencms.main.OpenCms;
import org.opencms.util.CmsUUID;
import org.opencms.xml.content.CmsXmlContent;
import org.opencms.xml.content.CmsXmlContentFactory;
import org.opencms.xml.types.I_CmsXmlContentValue;

import org.apache.commons.logging.Log;

public class FigureVersionUpdater extends CmsJspBean {

    /** The log object for this class. */
    private static final Log LOG = CmsLog.getLog(CmsUUID.class);

    private static final int DOCUMENTATION_FIGURE_TYPE_ID = 356;
    private String m_newVersion = null;
    private CmsResource m_figureResource = null;

    public void setFileAndVersion(String uuid, String newVersion) {

        try {
            CmsUUID id = new CmsUUID(uuid);
            if (id == null) {
                throw (new Exception("The provided UUID is invalid"));
            }
            CmsResource resource = getCmsObject().readResource(id);
            if (resource.getTypeId() != DOCUMENTATION_FIGURE_TYPE_ID) {
                throw (new Exception("The provided UUID belongs not to a resource of type documentation-figure"));
            }
            m_figureResource = resource;
            m_newVersion = newVersion;
        } catch (Exception e) {
            LOG.error(CmsException.getStackTraceAsString(e));
        }
    }

    public boolean getUpdateVersionNumber() {

        if ((m_figureResource == null) || (m_newVersion == null)) {
            LOG.error("figure id or version number not set.");
            return false;
        }
        CmsObject cmsObject = getCmsObject();
        try {
            CmsFile file = cmsObject.readFile(m_figureResource);
            CmsXmlContent xmlContent = CmsXmlContentFactory.unmarshal(cmsObject, file);
            xmlContent.setAutoCorrectionEnabled(true);
            file = xmlContent.correctXmlStructure(cmsObject);
            I_CmsXmlContentValue versionValue = xmlContent.getValue(
                "OpenCmsVersion",
                getCmsObject().getRequestContext().getLocale());
            versionValue.setStringValue(cmsObject, m_newVersion);
            file.setContents(xmlContent.marshal());
            cmsObject.lockResource(file);
            cmsObject.writeFile(file);
            cmsObject.unlockResource(file);
            OpenCms.getSearchManager().updateOfflineIndexes(2000);
        } catch (CmsException e) {
            LOG.error(CmsException.getStackTraceAsString(e));
            return false;
        }
        return true;
    }
}
