<%@page import="com.alkacon.opencms.documentation.editortools.ContentActionPerformer" %>
<div>
<%
	ContentActionPerformer performer = new ContentActionPerformer();
	performer.init(pageContext,request,response);
	String output = performer.doAction(performer.new DeleteUnusedContentCommand());
	out.println(output);
%>
</div>