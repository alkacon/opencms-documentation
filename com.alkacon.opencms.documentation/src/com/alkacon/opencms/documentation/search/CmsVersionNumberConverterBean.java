package com.alkacon.opencms.documentation.search;

import java.util.Map;

import org.apache.commons.collections.Transformer;
import org.opencms.util.CmsCollectionsGenericWrapper;

public class CmsVersionNumberConverterBean {

	private Map<String, String> m_encode = null;
	private Map<String, String> m_decode = null;

	public Map<String, String> getEncode() {
		if (m_encode == null) {
			m_encode = CmsCollectionsGenericWrapper
					.createLazyMap(new Transformer() {

						@Override
						@SuppressWarnings("synthetic-access")
						public Object transform(Object versionNumber) {

							String version = versionNumber.toString();
							return CmsVersionNumberConverter.encode(version);
						}
					});
		}
		return m_encode;
	}

	public Map<String, String> getDecode() {
		if (m_decode == null) {
			m_decode = CmsCollectionsGenericWrapper
					.createLazyMap(new Transformer() {

						@Override
						@SuppressWarnings("synthetic-access")
						public Object transform(Object versionNumber) {

							String version = versionNumber.toString();
							long number = 0;
							try {
								number = Long.valueOf(version);
							} catch (NumberFormatException e) {
								// nothing to do - return 0
							}
							return CmsVersionNumberConverter.decode(number);
						}
					});
		}
		return m_decode;

	}
}
