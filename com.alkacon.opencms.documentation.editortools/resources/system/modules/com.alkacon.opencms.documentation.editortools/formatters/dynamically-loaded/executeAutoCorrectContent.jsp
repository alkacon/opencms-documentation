<%@page import="com.alkacon.opencms.documentation.editortools.AutoCorrectContent" %>
<div>
<%
	AutoCorrectContent autocorrect = new AutoCorrectContent();
	autocorrect.init(pageContext,request,response);
	String output = autocorrect.autocorrect();
	out.println(output);
%>
</div>