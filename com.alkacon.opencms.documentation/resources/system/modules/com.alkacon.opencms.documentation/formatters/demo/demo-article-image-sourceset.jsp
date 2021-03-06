<%@page pageEncoding="UTF-8" buffer="none" session="false" trimDirectiveWhitespaces="true"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>

<cms:formatter var="content" val="value">

  <%-- get the image from the content as image bean --%>
  <c:set var="imageBean" value="${value.Image.toImage}"/>

  <%-- add (links to) scaled versions of the image to the bean's source set
       Note: We provide 250px and 350px, and double the sizes for retina displays --%>
  <c:set target="${imageBean}" property="srcSets" value="${imageBean.scaleWidth[250]}" />
  <c:set target="${imageBean}" property="srcSets" value="${imageBean.scaleWidth[350]}" />
  <c:set target="${imageBean}" property="srcSets" value="${imageBean.scaleWidth[500]}" />
  <c:set target="${imageBean}" property="srcSets" value="${imageBean.scaleWidth[700]}" />

  <div class="clearfix">
    <%-- use image bean with the img tag: Provide a default 400px image for browsers not supporting
         the srcset attibute, and provide our srcset as well.
	     The sizes are needed to tell the browser when to use which resolution. --%>
    <img class="demo-float-on-big-screen"
         src="${imageBean.scaleWidth[400]}"
	     srcset="${imageBean.srcSet}"
	     sizes="(min-width: 768px) 350px, 250px">

    ${value.Text}
  </div>
</cms:formatter>
