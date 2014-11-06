<%@page trimDirectiveWhitespaces="true" buffer="none" session="false" taglibs="c,cms,fmt,fn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict //EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<cms:formatter var="content">
<head>
<title>${content.value.Title}</title>
	<link rel="stylesheet" href="<cms:link>%(link.weak:/system/modules/com.alkacon.opencms.documentation/resources/demo/css/pdf.css:243ee99e-64f7-11e4-9296-005056b61161)</cms:link>" type="text/css" />
</head>
<body>
<div>
	<h1>
		${content.value.Title}
	</h1>
	<c:if test="${content.value.Image.isSet}">
		<div style="float:left; padding-right:20px;">
			<cms:img src="${content.value.Image}" width="200" />
		</div>
	</c:if>
    <div>
        ${content.value.Text}
    </div>
	<div style="clear:left;"></div>
</div>
</body>
</cms:formatter>
</html>