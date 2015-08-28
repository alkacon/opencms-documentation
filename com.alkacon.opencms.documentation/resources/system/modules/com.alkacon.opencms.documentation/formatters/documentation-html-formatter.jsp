<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<cms:formatter var="content">
<div>
	<cms:decorate file="/system/modules/com.alkacon.opencms.documentation/decoration/configuration.xml">
	<div ${content.rdfa.Html}>${content.value.Html}</div>
	</cms:decorate>
</div>
</cms:formatter>