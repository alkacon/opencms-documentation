
package com.alkacon.opencms.documentation;

import org.opencms.file.CmsResource;
import org.opencms.jsp.CmsJspBean;
import org.opencms.jsp.util.CmsJspContentAccessBean;
import org.opencms.jsp.util.CmsJspStandardContextBean;
import org.opencms.main.CmsLog;
import org.opencms.xml.containerpage.CmsContainerBean;
import org.opencms.xml.containerpage.CmsContainerElementBean;
import org.opencms.xml.containerpage.CmsContainerPageBean;

import org.apache.commons.logging.Log;

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

/** The class is used to retrieve topic information in a
 *  documentations container page template.
 *  In particular, the documentation-topic-container is searched
 *  for the topic and the topic can be exposed to the JSP.
 * 
 */
public class TopicExplorer extends CmsJspBean {

    protected static final Log LOG = CmsLog.getLog(TopicExplorer.class);

    public CmsJspContentAccessBean getTopicContent() {

        try {
            if (isNotInitialized()) {
                throw (new Exception("Object of type TopicExplorer is not initialized. Pleas call init(...)"));
            }
            return getTopicContentInternal();
        } catch (Exception e) {
            LOG.error(e.getStackTrace());
            return null;
        }
    }

    private CmsJspContentAccessBean getTopicContentInternal() throws Exception {

        CmsJspStandardContextBean cmsBean = CmsJspStandardContextBean.getInstance(getRequest());
        CmsContainerPageBean page = cmsBean.getPage();
        CmsContainerBean container = page.getContainers().get("documentation-topic-container");
        CmsContainerElementBean topicElement = container.getElements().get(0);
        topicElement.initResource(getCmsObject());
        CmsResource topicResource = topicElement.getResource();
        return new CmsJspContentAccessBean(getCmsObject(), topicResource);
    }
}
