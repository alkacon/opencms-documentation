<%@page buffer="none" session="false" taglibs="c,cms" %>
<cms:formatter var="content" val="value" rdfa="rdfa" >
<div style="margin-bottom:30px;" ${not value.Image.isSet?rdfa.Image:""} >
    <div class="headline"><h3 ${rdfa.Title}>${value.Title}</h3></div>
	<c:if test="${value.Image.isSet}">
		<div style="float:left;" ${rdfa.Image}>
			<cms:img src="${value.Image}" height="100" width="300" />
		</div>
	</c:if>
    <div ${content.rdfa.Text}>
        ${value.Text}
    </div>
	<div style="clear:left;"></div>
</div>
</cms:formatter>