<%@page buffer="none" session="false" taglibs="c,cms" %>
<cms:formatter var="content" val="value">
<div style="margin-bottom:30px;">
    <div class="headline">
		<h3>${value.Title}</h3>       
	</div>
	<c:if test="${value.PDF.exists}">
		<div style="float:right;width:40%;text-align:center;">
			 <a href="<cms:link>${value.PDF}</cms:link>"
				target="pdf">
				<img src='<cms:pdfthumbnail file="${value.PDF}" height="200" format="png" />' alt="Download PDF" title="Download PDF" />
			</a>
		</div>
	</c:if>
    <div>
        ${value.Text}
    </div>
	<div style="clear:right;"></div>
</div>
</cms:formatter>