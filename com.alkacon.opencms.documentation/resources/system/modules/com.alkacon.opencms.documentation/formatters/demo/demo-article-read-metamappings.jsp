<%@page buffer="none" session="false" taglibs="c,cms" %>
<cms:formatter var="content">

<div style="margin-bottom:30px;">
	<c:choose>
	
	<%-- check if the element added on the page includes the meta mappings of the wanted kind --%>
		<c:when test="${cms.meta.containsMeta}">
		
			<div style="background-color:palegreen; text-align:center;">
				<h3>${content.value.Title}</h3>
				
		<%-- show the meta information mapped with the key "MainTitle" --%>
				<h4>The title of the element you have dropped: <br>
					<span style="background-color:lightgrey">${cms.meta.MainTitle}</span>
				</h4>
				
				<h4>The meta information of the added element is:</h4>
	
		<%-- show the meta information mapped with the keys "Description" and "Keywords" --%>
				<div style="text-align:center;">
					<h4>Description: <br>
						<span style="background-color:lightgrey">${cms.meta.Description}</span>
					</h4>
					<h4>
						Keywords: <br>
						<span style="background-color:lightgrey">${cms.meta.Keywords}</span>
					</h4></div>
			</div>
		</c:when>
		
		<%-- message, when wrong formatter is chosen --%>
		<c:otherwise>
			<div style="vertical-align: middle;background-color:Tomato;height: 100px;">
			<h3 style="text-align:center;line-height: 50px;">You either put the wrong element (without any meta information) or you have chosen the wrong formatter</h3>
			</div>
		</c:otherwise>
	</c:choose>
</div>
</cms:formatter>