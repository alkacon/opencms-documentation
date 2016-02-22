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

import org.opencms.jsp.decorator.CmsDecorationBundle;
import org.opencms.jsp.decorator.CmsDecorationObject;

import java.util.Locale;
import java.util.Map;
import java.util.Set;

/**
 * <p>This decoration bundle supports case insensitive keywords. This is achieved by
 * converting every key to lower case and searching for them by converting the key to search for 
 * to lower case. Then, when a CmsCaseSensitiveDecorationObject is found, its flag is checked to
 * see whether it is case sensitive. If it is, the unconverted search key is again checked against
 * the unconverted entry key.</p>
 * <p>For more information about decoration bundles, see here:
 * {@link org.opencms.jsp.decorator.CmsDecorationBundle </code>CmsDecorationBundle<code>}.</p>
 */
public class CmsEnhancedDecorationBundle extends CmsDecorationBundle {

    /**
     * Constructor, creates a new CmsDecorationBundle for a given locale. It is capable of
     * case sensitive and insensitive decorations.
     * @param locale the locale of this bundle or null
     */
    public CmsEnhancedDecorationBundle(Locale locale) {

        super(locale);
    }

    /**
     * Put alls entries of the input map into the bundle, making keys lower case
     * in order to allow case insensitive entries.
     * @see org.opencms.jsp.decorator.CmsDecorationBundle#putAll(java.util.Map)
     */
    @Override
    public void putAll(Map<String, CmsDecorationObject> map) {

        Set<String> keys = map.keySet();
        for (String key : keys) {
            put(key, map.get(key));
        }
    }

    /**
     * Puts a decoration object into the map, converting the key to 
     * lower case in order to allow case insensitive entries.
     * @see org.opencms.jsp.decorator.CmsDecorationBundle#put(java.lang.String, org.opencms.jsp.decorator.CmsDecorationObject)
     */
    @Override
    public void put(String key, CmsDecorationObject value) {

        super.put(key.toLowerCase(), value);
    }

    /**
     * Overriden to allow case insensitive entries.
     * @see org.opencms.jsp.decorator.CmsDecorationBundle#get(java.lang.Object)
     */
    @Override
    public Object get(Object key) {

        CmsCaseSensDecorationObject object;
        object = (CmsCaseSensDecorationObject)super.get(((String)key).toLowerCase());
        if (object != null) {
            // This test is done to filter out case sensitive keys not matching.
            // The tests so far were all case insensitive...
            if (!object.matches((String)key)) {
                return null;
            }
        }
        return object;
    }

}
