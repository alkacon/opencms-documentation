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

package com.alkacon.opencms.documentation.sectionindexer;

import java.util.LinkedList;
import java.util.List;

public class SectionIndexer {

    private List<Integer> m_prefix;
    private Integer m_sectionCount;

    public SectionIndexer() {

        m_prefix = new LinkedList<Integer>();
        m_sectionCount = 1;
    }

    public String getEnterSubsections() {

        m_prefix.add(m_sectionCount);
        m_sectionCount = 1;
        return null;
    }

    public String getExitSubsections() {

        int lastIndex = m_prefix.size() - 1;
        m_sectionCount = m_prefix.get(lastIndex);
        if (!m_prefix.isEmpty()) {
            m_prefix.remove(lastIndex);
        }
        return null;
    }

    public String getExitSection() {

        m_sectionCount += 1;
        return null;
    }

    public String getSectionNumber() {

        String sectionNumber = "";
        for (Integer i : m_prefix) {
            sectionNumber += (i.toString() + ".");
        }
        sectionNumber += m_sectionCount.toString();

        return sectionNumber;
    }

    public int getSectionLevel() {

        return m_prefix.size() + 1;
    }
}
