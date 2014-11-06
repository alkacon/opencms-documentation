<%@page buffer="none" session="false" taglibs="c,cms" %>
<cms:formatter var="content" val="value">
<div style="margin-bottom:30px;">
    <div class="headline">
		<h3>${value.Title}</h3>       
	</div>
	<c:if test="${value.Image.isSet}">
		<div style="float:left;">
			<cms:img src="${value.Image}" height="100" width="300" />
		</div>
	</c:if>
    <div>
        ${value.Text}
    </div>
    <div style="padding-top:10px;">
         <a href="<cms:pdf format='%(link.weak:/system/modules/com.alkacon.opencms.documentation/pages/demo/demo-article-pdf.jsp:d53aaf1c-64d2-11e4-9296-005056b61161)'
		                   content='${content.filename}' 
						   locale='en' />"
			target="pdf">
            <cms:img height="32" src="%(link.strong:/system/modules/com.alkacon.opencms.documentation/resources/demo/img/218-PDFPage.png:a1ddf340-64d0-11e4-9296-005056b61161)" alt="Download PDF" title="Download as PDF" />
        </a>
    </div>
	<div style="clear:left;"></div>
</div>
</cms:formatter>