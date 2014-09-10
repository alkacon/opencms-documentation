<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" taglibs="cms,c" %>
<cms:formatter var="content" val="value">
<%-- This simple example displays the current date on clicking the refresh button.
  The required javascript is loaded in the html <head> of the template dynamiccaly using <cms:headinclude>.
--%>
<div class="demo-article-headinclude">
	<div class="headline"><h3>${value.Title}</h3></div>
	<div class="paragraph">
		<%-- Use the displayDate from the imported script to refresh the date. --%>
		<p id="dateText">Please click the button to refresh the date.</p>
		<div><button type="button" onclick="displayDate();">Refresh date</button></div>
		<%-- Set the required variables for the image. --%>
		${value.Text}
	</div>
</div>
</cms:formatter>