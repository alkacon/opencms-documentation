package com.alkacon.opencms.documentation.search;

import java.util.List;
import java.util.Map;

import org.opencms.file.CmsObject;
import org.opencms.file.CmsProperty;
import org.opencms.file.CmsResource;
import org.opencms.search.extractors.I_CmsExtractionResult;
import org.opencms.search.fields.CmsSearchFieldMappingType;
import org.opencms.search.fields.I_CmsSearchFieldMapping;
import org.opencms.util.CmsStringUtil;
import org.opencms.xml.CmsXmlUtils;

public class CmsVersionNumberSearchFieldMapping implements
I_CmsSearchFieldMapping {

	/**
	 * 
	 */
	private static final long serialVersionUID = -7688151144778066004L;
	private static final String DEFAULT_VALUE = "0";

	private String m_param;
	private CmsSearchFieldMappingType m_type;

	/**
	 * Public constructor for a new search field mapping.
	 * <p>
	 */
	public CmsVersionNumberSearchFieldMapping() {

		m_param = null;
		setType(CmsSearchFieldMappingType.DYNAMIC);
	}

	/**
	 * Public constructor for a new search field mapping.
	 * <p>
	 * 
	 * @param type
	 *            the type to use, see
	 *            {@link #setType(CmsSearchFieldMappingType)}
	 * @param param
	 *            the mapping parameter, see {@link #setParam(String)}
	 */
	public CmsVersionNumberSearchFieldMapping(CmsSearchFieldMappingType type,
			String param) {

		this();
		setParam(param);
		setType(type);
	}

	@Override
	public String getDefaultValue() {
		return DEFAULT_VALUE;
	}

	@Override
	public String getStringValue(CmsObject cms, CmsResource res,
			I_CmsExtractionResult extractionResult,
			List<CmsProperty> properties, List<CmsProperty> propertiesSearched) {
		String content = null;
		if ((extractionResult != null)
				&& CmsStringUtil.isNotEmptyOrWhitespaceOnly(getParam())) {
			content = getContentItemForXPath(
					extractionResult.getContentItems(),
					normalizeParam(getParam(), cms.getRequestContext()
							.getLocale().toString()));
		}

		if (content == null) {
			return getDefaultValue();
		}
		return Long.toString(CmsVersionNumberConverter.encode(content));
	}

	private String normalizeParam(String param, String locale) {
		String p = locale + "/" + param;
		if (!p.endsWith("]")) {
			p += "[1]";
		}
		return p;
	}

	@Override
	public void setDefaultValue(String defaultValue) {

		// Should not be setable
	}

	@Override
	public void setType(CmsSearchFieldMappingType type) {

		m_type = type;

	}

	@Override
	public void setType(String type) {
		m_type = CmsSearchFieldMappingType.valueOf(type);

	}

	/**
	 * Returns a "\n" separated String of values for the given XPath if
	 * according content items can be found.
	 * <p>
	 * 
	 * @param contentItems
	 *            the content items to get the value from
	 * @param xpath
	 *            the short XPath parameter to get the value for
	 * 
	 * @return a "\n" separated String of element values found in the content
	 *         items for the given XPath
	 */
	private String getContentItemForXPath(Map<String, String> contentItems,
			String xpath) {

		if (contentItems.get(xpath) != null) { // content item found for XPath
			return contentItems.get(xpath);
		} else { // try a multiple value mapping
			StringBuffer result = new StringBuffer();
			for (Map.Entry<String, String> entry : contentItems.entrySet()) {
				if (CmsXmlUtils.removeXpath(entry.getKey()).equals(xpath)) { // the
					// removed
					// path
					// refers
					// an
					// item
					result.append(entry.getValue());
					result.append("\n");
				}
			}
			return result.length() > 1 ? result.toString().substring(0,
					result.length() - 1) : null;
		}
	}

	@Override
	public String getParam() {
		return m_param;
	}

	@Override
	public CmsSearchFieldMappingType getType() {
		return m_type;
	}

	@Override
	public void setParam(String param) {
		m_param = param;

	}

}
