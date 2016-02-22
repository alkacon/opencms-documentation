/*
 * File   : $Source$
 * Date   : $Date$
 * Version: $Revision$
 *
 * This library is part of OpenCms -
 * the Open Source Content Management System
 *
 * Copyright (C) 2002 - 2009 Alkacon Software (http://www.alkacon.com)
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

package com.alkacon.opencms.documentation.decorator;

import org.opencms.file.CmsFile;
import org.opencms.file.CmsObject;
import org.opencms.file.CmsResource;
import org.opencms.jsp.decorator.CmsDecorationBundle;
import org.opencms.jsp.decorator.CmsDecorationDefintion;
import org.opencms.main.CmsException;
import org.opencms.main.OpenCms;
import org.opencms.search.CmsSearchResource;
import org.opencms.search.solr.CmsSolrIndex;
import org.opencms.search.solr.CmsSolrQuery;
import org.opencms.search.solr.CmsSolrResultList;
import org.opencms.xml.content.CmsXmlContent;
import org.opencms.xml.content.CmsXmlContentFactory;

import java.util.Iterator;
import java.util.List;
import java.util.Locale;

import org.apache.commons.logging.Log;

/**
 *  An extension to the text decoration defining class which allows to use a
 *  Solr Query result as collection of keyword-mappings instead .
 */
public class CmsSolrBasedDecorationDefinition extends CmsDecorationDefintion {

    /** The object used for logging */
    private static final Log LOG = OpenCms.getLog(CmsSolrBasedDecorationDefinition.class);

    /**
     * Overwritten to implement a SolrSearch based glossary to provide the decorators mappings.
     * @see org.opencms.jsp.decorator.CmsDecorationDefintion#createDecorationBundle(org.opencms.file.CmsObject, java.util.Locale)
     */
    @Override
    public CmsDecorationBundle createDecorationBundle(CmsObject cms, Locale locale) throws CmsException {

        // create decoration maps
        // take every entry and map the key to the description text
        LOG.debug("SolrBasedDecoration: Starting search!");
        LOG.debug("Locale: " + locale);
        CmsSolrIndex index = OpenCms.getSearchManager().getIndexSolr("Solr online");
        CmsSolrQuery query = new CmsSolrQuery(cms, null);

        // request glossary entries from SOLR
        String type = "documentation-glossar-entry";
        query.setResourceTypes(type);
        query.setSearchRoots("/sites/default/");
        query.setRows(Integer.valueOf(50000));
        CmsSolrResultList results = index.search(cms, query, true);
        long resultCount = results.getNumFound();

        LOG.debug("Found " + resultCount + " results searching for docs of type: " + type);

        // steps to take:
        // 1. combine every key and its decoration with the definition data and put it 
        //      into a decorationObject.
        // 2. put the decorationObjects in a bundle.

        CmsEnhancedDecorationBundle decBundle = new CmsEnhancedDecorationBundle(locale);
        Iterator<CmsSearchResource> resultsIt = results.iterator();
        LOG.debug("Filling result values into DecorationBundle.");
        while (resultsIt.hasNext()) {
            CmsSearchResource res = resultsIt.next();
            String content = getResourceContent(cms, res);

            // First for the case insensitive matches
            List<String> matches = res.getMultivaluedField("match_en");
            if (matches != null) {
                for (String match : matches) {
                    CmsCaseSensDecorationObject decObject = new CmsCaseSensDecorationObject(
                        match,
                        content,
                        this,
                        locale);
                    decObject.setCaseSensitive(CmsCaseSensDecorationObject.CASE_INSENSITIVE);
                    LOG.debug("Putting entry '" + match + "' in bundle.");
                    decBundle.put(match, decObject);
                }
            }

            // Now for the case sensitive matches
            List<String> matchesCaseSensitive = res.getMultivaluedField("match_case_en");
            if (matchesCaseSensitive != null) {
                for (String match : matchesCaseSensitive) {
                    CmsCaseSensDecorationObject decObject = new CmsCaseSensDecorationObject(
                        match,
                        content,
                        this,
                        locale);
                    decObject.setCaseSensitive(CmsCaseSensDecorationObject.CASE_SENSITIVE);
                    LOG.debug("Putting case sensitive entry '" + match + "' in bundle.");
                    decBundle.put(match, decObject);
                }
            }
        }

        // now that we have all decoration maps we can build the decoration bundle
        // the bundle is depending on the locale, if a locale is given, only those decoration maps that contain the
        // locale (or no locale at all) must be used. If no locale is given, all decoration maps are
        // put into the decoration bundle

        LOG.debug("Bundle done!");
        return decBundle;
    }

    private String getResourceContent(CmsObject cms, CmsSearchResource searchRes) {

        String path = searchRes.getRootPath();
        path = path.substring(path.indexOf('/', "/sites/".length()));

        CmsXmlContent entry = null;
        String description = "null";
        try {
            CmsResource res = cms.readResource(path);
            CmsFile file = cms.readFile(res);
            entry = CmsXmlContentFactory.unmarshal(cms, file);
            description = entry.getValue("Description", cms.getRequestContext().getLocale()).getStringValue(cms);
        } catch (CmsException e) {
            LOG.debug("Error while reading Glossary entry.");
            LOG.debug(CmsException.getStackTraceAsString(e));
        }
        return description;
    }
}
