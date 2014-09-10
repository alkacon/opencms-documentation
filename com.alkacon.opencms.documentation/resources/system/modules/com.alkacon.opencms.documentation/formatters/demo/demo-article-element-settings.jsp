<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setLocale value="${cms.locale}" />
<cms:formatter var="content" val="value">
<div style="margin-bottom:30px;">

	<%-- Abbreviate "cms.element.settings" with "settings" --%>
	<c:set var="settings" value="${cms.element.settings}" />

	<%-- Set the title of the article via an element setting --%>
	<div class="headline">
		<h3>${settings['text']}</h3>
	</div>
	<div>

		<%-- Check if the image should be shown --%>
		<c:set var="showing" value="${settings['showimage']?settings['showimage']:false}" />
		<c:if test="${showing && value.Image.isSet}">
			<%-- Show the image --%>
			<div style="float:left;margin-right:10px;margin-bottom:10px;">
				<cms:img src="${value.Image}" width="200" />
			</div>
		</c:if>
		
		<p>
			<%-- Get the date and show it --%>
			<c:set var="date" value="${settings['date']}" />
			<c:if test="${not empty date}">
				<i><fmt:formatDate value="${cms:convertDate(date)}" 
				                   dateStyle="SHORT" 
				                   timeStyle="SHORT" 
				                   type="${settings['format']}" /></i>
				<br/>
			</c:if>
			<%-- Show the text of the article --%>
			${value.Text}
		</p>
		
	</div>
	<div style="clear:left;"></div>
	
	<%-- show the element settings --%>
	<h4>Settings values:</h4>
	<div>
		<pre>
<b>Text field</b> "Text" = <cms:elementsetting name="text" /> <br/>
<b>Check box</b> "Show Image" = <cms:elementsetting name="showimage" default="false" /> <br/>
<b>Date picker</b> "Date" = <cms:elementsetting name="date" /> <br/>
<b>Radio buttons</b> "Date Format" = <cms:elementsetting name="format" />
		</pre>
	</div>
</div>
</cms:formatter>