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

package com.alkacon.opencms.documentation.topics;

import org.opencms.file.CmsObject;
import org.opencms.file.CmsResource;
import org.opencms.file.types.CmsResourceTypeXmlContainerPage;
import org.opencms.jsp.CmsJspBean;
import org.opencms.jsp.util.CmsJspContentAccessBean;
import org.opencms.main.CmsLog;
import org.opencms.util.CmsCollectionsGenericWrapper;
import org.opencms.xml.containerpage.CmsContainerBean;
import org.opencms.xml.containerpage.CmsContainerElementBean;
import org.opencms.xml.containerpage.CmsContainerPageBean;
import org.opencms.xml.containerpage.CmsXmlContainerPage;
import org.opencms.xml.containerpage.CmsXmlContainerPageFactory;

import java.util.Map;

import org.apache.commons.collections.Transformer;
import org.apache.commons.logging.Log;

/** The class is used to retrieve topic information in a
 *  documentations container page template.
 *  In particular, the documentation-topic-container is searched
 *  for the topic and the topic can be exposed to the JSP.
 *
 */
public class TopicGrabber extends CmsJspBean {

    /** Logger for the class */
    protected static final Log LOG = CmsLog.getLog(TopicGrabber.class);

    /** Lazily generated map that has page URLs as keys and topic contents as values. */
    private Map<String, CmsJspContentAccessBean> m_topics = null;

    /**
     * Returns a lazily initialized map with links to pages as keys and the content of the topic found on the respective page as value, or null if no topic was found.
     * @return lazy map with URLs to pages as keys and the topics found on the pages as values, or null as value if no topic was found.
     */
    public Map<String, CmsJspContentAccessBean> getTopicContent() {

        try {
            if (isNotInitialized()) {
                throw (new Exception("Object of type TopicGrabber is not initialized. Pleas call init(...)"));
            }
            return getTopicContentInternal();
        } catch (Exception e) {
            LOG.error("TopicGrabber not initialized: ", e);
            return null;
        }
    }

    /** Returns the topic placed on the page with the given VFS URL
     * @param url VFS URL of the page where the topic is searched on
     * @return Topic content as CmsJspContentAccessBean
     */
    CmsJspContentAccessBean getTopicContentForPage(String url) {

        try {
            CmsObject cmsObject = this.getCmsObject();
            if (url.endsWith("/")) {
                url += "index.html";
            }
            if (!cmsObject.existsResource(url)) {
                throw (new Exception("Resource " + url + " does not exist."));
            }
            CmsResource resource = cmsObject.readResource(url);
            if (!(CmsResourceTypeXmlContainerPage.isContainerPage(resource))) {
                throw (new Exception("Resource " + url + " is not a container page."));
            }
            CmsXmlContainerPage xmlPage = CmsXmlContainerPageFactory.unmarshal(cmsObject, resource);
            CmsContainerPageBean page = xmlPage.getContainerPage(cmsObject);
            CmsContainerBean container = page.getContainers().get("documentation-topic-container");
            if (container == null) {
                throw (new Exception(
                    "Container page with URL " + url + " has no container with name 'documentation-topic-container'."));
            }
            CmsContainerElementBean topicElement = container.getElements().get(0);
            topicElement.initResource(getCmsObject());
            CmsResource topicResource = topicElement.getResource();
            return new CmsJspContentAccessBean(getCmsObject(), topicResource);
        } catch (Exception e) {
            if (LOG.isDebugEnabled()) {
                LOG.debug("Problem getting the topic content: ", e);
            }
            return null;
        }
    }

    /**
     * Returns the content of the topic found on the explored page.
     * @return content of the found topic
     */
    private Map<String, CmsJspContentAccessBean> getTopicContentInternal() {

        if (m_topics == null) {
            m_topics = CmsCollectionsGenericWrapper.createLazyMap(new Transformer() {

                public Object transform(Object url) {

                    String urlString = url.toString();
                    int rauteIndex = urlString.indexOf("#");
                    if (rauteIndex > -1) {
                        urlString.substring(0, rauteIndex);
                    }
                    return getTopicContentForPage(url.toString());
                }
            });
        }
        return m_topics;
    }

}
