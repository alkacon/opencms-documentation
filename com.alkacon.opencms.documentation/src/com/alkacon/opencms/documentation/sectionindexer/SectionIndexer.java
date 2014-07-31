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

/**
 * The section indexer calculates the section numbering for
 * sections in the documentation.
 * 
 * To index a section call {@link #getSectionIndex(int)}. This
 * returns the section number and adjusts the internal section
 * counter.
 * 
 * The indexer is able to handle at most for levels. 
 * That is, "2.1.3.2" is ok, but "2.1.3.2.1" not.
 */
public class SectionIndexer {

    /** internal section counter */
    private int[] m_index;

    /**
     * Default constructor. Initializes the internal section counter.
     */
    public SectionIndexer() {

        m_index = new int[] {0, 0, 0, 0};
    }

    /**
     * EL-friendly wrapper for getSectionIndex, having the level parameter in it's name
     * @return Section index
     */
    public String getSectionIndex1() {

        return getSectionIndex(1);
    }

    /**
     * EL-friendly wrapper for getSectionIndex, having the level parameter in it's name
     * @return Section index
     */
    public String getSectionIndex2() {

        return getSectionIndex(2);
    }

    /**
     * EL-friendly wrapper for getSectionIndex, having the level parameter in it's name
     * @return Section index
     */
    public String getSectionIndex3() {

        return getSectionIndex(3);
    }

    /**
     * EL-friendly wrapper for getSectionIndex, having the level parameter in it's name
     * @return Section index
     */
    public String getSectionIndex4() {

        return getSectionIndex(4);
    }

    /**
     * @param level The section level.
     * @return The index of the section, e.g. "2.1.3"
     */
    private String getSectionIndex(int level) {

        increaseSectionIndex(level);
        return indexToString(level);

    }

    /**
     * Increases the section index, according to the level of the
     * current section.
     * @param level The level of the current section.
     */
    private void increaseSectionIndex(final int level) {

        m_index[level - 1] += 1;
        for (int i = level; i < m_index.length; i++) {
            m_index[i] = 0;
        }
    }

    /**
     * @param level The level of the current section
     * @return The current section's index, e.g. "2.1.3"
     */
    private String indexToString(final int level) {

        String result = Integer.toString(m_index[0]);
        for (int i = 1; i < level; i++) {
            result += "." + Integer.toString(m_index[i]);
        }
        return result;
    }
}
