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

import org.opencms.jsp.decorator.CmsDecorationObject;

import java.util.Locale;

/**
 * Allows the possibility of case sensitive and insensitive keywords by setting a flag.
 * See {@link org.opencms.jsp.decorator.CmsDecorationObject CmsDecorationObject} for more information.
 */
public class CmsCaseSensDecorationObject extends CmsDecorationObject {

    /** Constant for use as a parameter */
    public static final boolean CASE_SENSITIVE = true;

    /** Constant for use as a parameter */
    public static final boolean CASE_INSENSITIVE = false;

    private boolean caseSensitive;

    /**
     * Constructor, creates a new decoration object with given values. Per default the
     * match is treated as case insensitive.
     * @param match the decoration key
     * @param content the decoration for this decoration key
     * @param cmsDecDef the decoration definition to be used
     * @param locale the locale of this decoration object
     */
    public CmsCaseSensDecorationObject(
        String match,
        String content,
        CmsSolrBasedDecorationDefinition cmsDecDef,
        Locale locale) {

        super(match, escape(content), cmsDecDef, locale);
        setCaseSensitive(CASE_INSENSITIVE);
    }

    /**
     * A setter to set the case sensitive flag.
     * @param b - sets the flag to its value
     */
    public void setCaseSensitive(boolean b) {

        caseSensitive = b;
    }

    /**
     * Checks if the case sensitive flag is set.
     * @return True if the flag is set, false if not.
     */
    public boolean isCaseSensitive() {

        return caseSensitive;
    }

    /**
     * Returns the key, converting it to lowercase before if the case sensitive flag is set.
     * @see org.opencms.jsp.decorator.CmsDecorationObject#getDecorationKey()
     */
    @Override
    public String getDecorationKey() {

        // Interesting: the super method of this one is never used...
        // Maybe because these objects are wrapped by a map holding their own copies of the keys.
        String key = super.getDecorationKey();
        if (!isCaseSensitive()) {
            return key.toLowerCase();
        }
        return key;
    }

    /**
     * Checks if the key is exactly the same as the decoration key.
     * @param key the key to check for
     * @return True if the keys match, false if not.
     */
    public boolean matches(String key) {

        if (!isCaseSensitive()) {
            key = key.toLowerCase();
        }
        return getDecorationKey().equals(adjustKey(key));
    }

    /**
     * Adjusts the key for the decoration.<p>
     * The following adjustments are made:
     * <ul>
     * <li>&nbsp; is replaced with space</li>
     * <li>multiple spaces are replaced with a single space</li>
     * </ul>
     * @param key the key to adjust
     * @return the adjusted key
     */
    private String adjustKey(String key) {

        // replace the &nbsp; with spaces
        key = key.replaceAll("&nbsp;", " ");
        // now eliminate all double spaces
        int keyLen;
        do {
            keyLen = key.length();
            key = key.replaceAll("  ", " ");
        } while (key.length() != keyLen);
        return key;
    }

    private static String escape(String text) {

        String result = text.replace("\"", "&quot;").replace("'", "&apos;");
        return result;
    }

}
