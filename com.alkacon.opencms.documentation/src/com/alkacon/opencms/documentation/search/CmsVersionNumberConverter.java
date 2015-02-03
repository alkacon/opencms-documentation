package com.alkacon.opencms.documentation.search;

import org.apache.commons.logging.Log;
import org.opencms.main.CmsLog;
import org.opencms.util.CmsStringUtil;

/**
 * 
 * @author Daniel Seidel
 *
 */
public class CmsVersionNumberConverter {

	/** Logger for the class */
	protected static final Log LOG = CmsLog
			.getLog(CmsVersionNumberConverter.class);

	public static final int OFFSET = 1000;
	public static final int MAX_PARTS = 4;

	public static long encode(String versionNumber) {
		long encodedNumber = 0;
		String[] versionParts = CmsStringUtil.splitAsArray(
				versionNumber.trim(), '.');
		int count = versionParts.length < MAX_PARTS ? versionParts.length
				: MAX_PARTS;
		try {
			for (int part = 0; part < count; part++) {
				int partNumber = Integer.parseInt(versionParts[part]);
				if (partNumber >= OFFSET) {
					throw new Exception(
							"Invalid version number. Each part must have less than "
									+ Integer.toString(Integer.toString(OFFSET)
											.length()) + ".");
				}
				encodedNumber += partNumber * shift(MAX_PARTS - part - 1);
			}
			return encodedNumber;
		} catch (Exception e) {
			LOG.error("Could not encode version number. Will return 0.", e);
			return 0;
		}
	}

	private static long shift(int times) {
		long shift = 1;
		for (int i = 0; i < times; i++) {
			shift *= OFFSET;
		}

		return shift;
	}

	public static String decode(final long versionNumber) {

		String number = "";
		int part = MAX_PARTS - 1;
		long remainder = versionNumber;
		while ((remainder > 0) || (part > 0)) {
			long currentOffset = shift(part);
			long current = remainder / currentOffset;
			number += number.isEmpty() ? Long.toString(current) : "."
					+ Long.toString(current);
			remainder = remainder % currentOffset;
			part--;
		}
		return number.isEmpty() || number.equals("0") ? "unspecified" : number;
	}
}
