<%@page buffer="none" session="false" taglibs="c,cms" %>
<cms:formatter var="content" val="value" rdfa="rdfa">

<div style="margin:40px;border-style: solid;">
	
    <div class="headline">
	<p>
	${value.Text}
	</p>
		<h3 style="background-color:lightgrey;" ${rdfa.Title}>${value.Title}</h3>
	</div>
	Description: 
	<h3 style="background-color:lightgrey;" ${content.value.MetaInfo.rdfa.Description}>${value.MetaInfo.value.Description}</h3>
	Keywords: 
	<h3 style="background-color:lightgrey;" ${content.value.MetaInfo.rdfa.Keywords}>${value.MetaInfo.value.Keywords}</h3>
	${cms.enableReload}
</div>
</cms:formatter>