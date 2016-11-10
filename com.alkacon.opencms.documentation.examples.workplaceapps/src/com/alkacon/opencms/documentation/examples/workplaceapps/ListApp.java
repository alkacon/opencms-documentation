/*
 * File   : $Source$
 * Date   : $Date$
 * Version: $Revision$
 *
 * This library is part of OpenCms -
 * the Open Source Content Management System
 *
 * Copyright (C) 2002 - 2008 Alkacon Software (http://www.alkacon.com)
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

package com.alkacon.opencms.documentation.examples.workplaceapps;

import org.opencms.file.CmsObject;
import org.opencms.file.CmsResource;
import org.opencms.file.CmsResourceFilter;
import org.opencms.file.types.CmsResourceTypeXmlAdeConfiguration;
import org.opencms.file.types.CmsResourceTypeXmlContainerPage;
import org.opencms.file.types.CmsResourceTypeXmlContent;
import org.opencms.file.types.I_CmsResourceType;
import org.opencms.main.CmsException;
import org.opencms.main.OpenCms;
import org.opencms.relations.CmsRelation;
import org.opencms.relations.CmsRelationFilter;
import org.opencms.ui.A_CmsUI;
import org.opencms.ui.I_CmsDialogContext;
import org.opencms.ui.I_CmsDialogContext.ContextType;
import org.opencms.ui.apps.A_CmsWorkplaceApp;
import org.opencms.ui.apps.CmsFileExplorer;
import org.opencms.ui.apps.I_CmsContextProvider;
import org.opencms.ui.components.CmsErrorDialog;
import org.opencms.ui.components.CmsFileTable;
import org.opencms.ui.components.CmsFileTableDialogContext;
import org.opencms.ui.components.OpenCmsTheme;
import org.opencms.ui.components.fileselect.CmsPathSelectField;
import org.opencms.ui.contextmenu.CmsResourceContextMenuBuilder;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;

import com.vaadin.data.Property.ValueChangeEvent;
import com.vaadin.data.Property.ValueChangeListener;
import com.vaadin.ui.Alignment;
import com.vaadin.ui.CheckBox;
import com.vaadin.ui.ComboBox;
import com.vaadin.ui.Component;
import com.vaadin.ui.FormLayout;
import com.vaadin.ui.Panel;
import com.vaadin.ui.VerticalLayout;

/**
 * Sample app.<p>
 */
public class ListApp extends A_CmsWorkplaceApp implements ValueChangeListener {

    /** Serialization id, only necessary because we implement {@link ValueChangeListener}. */
    private static final long serialVersionUID = -2605810932903346039L;

    /** The file table. */
    CmsFileTable m_fileTable;

    /** The select box for the type. */
    ComboBox m_typeSelector;

    /** The select box for the folder. */
    CmsPathSelectField m_folderSelector;

    /** The check box, to the select if only unused content should be shown. */
    CheckBox m_onlyUnusedCheckBox;

    /**
     * Listens to changes on all of the form fields.
     *
     * @see com.vaadin.data.Property.ValueChangeListener#valueChange(com.vaadin.data.Property.ValueChangeEvent)
     */
    @Override
    public void valueChange(ValueChangeEvent event) {

        fillTable();

    }

    /**
     * @see org.opencms.ui.apps.A_CmsWorkplaceApp#getBreadCrumbForState(java.lang.String)
     */
    @Override
    protected LinkedHashMap<String, String> getBreadCrumbForState(String state) {

        //using linked hash map to have an ordered map.
        LinkedHashMap<String, String> crumbs = new LinkedHashMap<String, String>();
        crumbs.put("", "List");
        return crumbs;
    }

    /**
     * @see org.opencms.ui.apps.A_CmsWorkplaceApp#getComponentForState(java.lang.String)
     */
    @Override
    protected Component getComponentForState(String state) {

        // The main component of the app, typically a vertical layout
        VerticalLayout main = new VerticalLayout();
        main.setSizeFull();
        main.setDefaultComponentAlignment(Alignment.TOP_CENTER);
        main.setSpacing(true);

        // Component for the form with input fields
        FormLayout form = new FormLayout();
        form.setMargin(true);
        // Style the form as typical for the workplace
        form.addStyleName(OpenCmsTheme.FORMLAYOUT_WORKPLACE_MAIN);

        m_typeSelector = new ComboBox("Resource type");
        m_typeSelector.setNullSelectionAllowed(false);
        m_typeSelector.setNewItemsAllowed(false);
        m_typeSelector.addValueChangeListener(this);
        m_typeSelector.setWidth("100%");
        m_typeSelector.addItems(getAvailableTypes());
        form.addComponent(m_typeSelector);

        m_folderSelector = new CmsPathSelectField();
        m_folderSelector.setCaption("Below folder");
        m_folderSelector.setResourceFilter(CmsResourceFilter.DEFAULT_FOLDERS);
        m_folderSelector.setFileSelectCaption("Select the base folder.");
        m_folderSelector.setValue("/");
        m_folderSelector.addValueChangeListener(this);
        form.addComponent(m_folderSelector);

        m_onlyUnusedCheckBox = new CheckBox("Only contents not directly placed on a containerpage");
        m_onlyUnusedCheckBox.addValueChangeListener(this);
        form.addComponent(m_onlyUnusedCheckBox);

        Panel formPanel = new Panel("Select options");
        formPanel.setContent(form);

        main.addComponent(formPanel);

        // create and add the table component
        I_CmsContextProvider contextProvider = new I_CmsContextProvider() {

            @Override
            public I_CmsDialogContext getDialogContext() {

                CmsFileTableDialogContext context = new CmsFileTableDialogContext(
                    ListAppConfiguration.APP_ID,
                    ContextType.fileTable,
                    m_fileTable,
                    m_fileTable.getSelectedResources());
                context.setEditableProperties(CmsFileExplorer.INLINE_EDIT_PROPERTIES);
                return context;
            }
        };

        m_fileTable = new CmsFileTable(contextProvider);
        m_fileTable.setSizeFull();
        m_fileTable.setMenuBuilder(new CmsResourceContextMenuBuilder());
        main.addComponent(m_fileTable);
        main.setExpandRatio(m_fileTable, 2);
        return main;
    }

    /**
     * @see org.opencms.ui.apps.A_CmsWorkplaceApp#getSubNavEntries(java.lang.String)
     */
    @Override
    protected List<NavEntry> getSubNavEntries(String state) {

        return null;

    }

    /**
     * Fills the table according to the selected type, folder and display-option
     */
    private void fillTable() {

        CmsObject cms = A_CmsUI.getCmsObject();
        String typeName = (String)m_typeSelector.getValue();
        String folderName = m_folderSelector.getValue();
        boolean onlyUnused = m_onlyUnusedCheckBox.getValue().booleanValue();
        if ((typeName != null) && cms.existsResource(folderName)) {
            try {
                CmsResourceFilter filter = CmsResourceFilter.ONLY_VISIBLE.addRequireType(
                    OpenCms.getResourceManager().getResourceType(typeName));
                List<CmsResource> resources = cms.readResources(folderName, filter);
                List<CmsResource> resourcesToShow = resources;
                if (onlyUnused) {
                    resourcesToShow = new ArrayList<CmsResource>();
                    for (CmsResource res : resources) {
                        if (getDisplayedOnPages(cms, res).isEmpty()) {
                            resourcesToShow.add(res);
                        }
                    }
                }
                m_fileTable.fillTable(cms, resourcesToShow);
            } catch (CmsException e) {
                CmsErrorDialog.showErrorDialog(e);
            }
        } else {
            m_fileTable.fillTable(cms, Collections.<CmsResource> emptyList());
        }
    }

    /**
     * Returns the list of all XML content types, except containerpage and module/sitemap configs.
     * @return the list of all XML content types, except containerpage and module/sitemap configs.
     */
    private Collection<String> getAvailableTypes() {

        Collection<String> result = new ArrayList<String>();
        List<I_CmsResourceType> types = OpenCms.getResourceManager().getResourceTypes();
        for (I_CmsResourceType type : types) {
            if ((type instanceof CmsResourceTypeXmlContent)
                && !((type instanceof CmsResourceTypeXmlContainerPage)
                    || (type instanceof CmsResourceTypeXmlAdeConfiguration))) {
                result.add(type.getTypeName());
            }
        }
        return result;
    }

    /**Get all container pages where a content is placed on.
     *
     * @param cmsObject CmsObject used for resource access.
     * @param resource the resource of the content for which the pages where it is displayed on are returned.
     * @return List of CmsResource objects of the container pages where the given content is placed on.
     * @throws CmsException
     */
    private List<CmsResource> getDisplayedOnPages(final CmsObject cmsObject, final CmsResource resource)
    throws CmsException {

        List<CmsResource> pages = new LinkedList<CmsResource>();
        CmsRelationFilter filter = CmsRelationFilter.SOURCES;
        List<CmsRelation> relations = cmsObject.getRelationsForResource(resource, filter);
        for (CmsRelation relation : relations) {
            pages.add(cmsObject.readResource(relation.getSourceId()));
        }
        Iterator<CmsResource> pageIterator = pages.iterator();
        while (pageIterator.hasNext()) {
            CmsResource source = pageIterator.next();
            if (source.getTypeId() != CmsResourceTypeXmlContainerPage.getContainerPageTypeId()) {
                pageIterator.remove();
            }
        }
        return pages;
    }
}
