<%@page
    pageEncoding="UTF-8"
    buffer="none"
    session="false"
    trimDirectiveWhitespaces="true"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>

<cms:formatter var="content" val="value">
<c:set var="imageBean" value="${value.Image.toImage}"/>

<div class="clearfix">

<div>
The original image is ${imageBean.width} x  ${imageBean.height} pixel in size.
</div>

<div>
The image src URL is: ${imageBean.srcUrl} x  ${imageBean.height}.
</div>



<c:set target="${imageBean}" property="srcSets" value="${imageBean.scaleWidth[200]}" />
<c:set target="${imageBean}" property="srcSets" value="${imageBean.scaleWidth[350]}" />
<c:set target="${imageBean}" property="srcSets" value="${imageBean.scaleWidth[650]}" />

<div>
I scale the image shown beside multiple times. This is the set of images I created:<br>
${imageBean.srcSet.replace(" /","<br>/")}
</div>

<div>
<c:set var="scaledImage" value="${imageBean.scaleWidth[250].scaler}" />
The scaled image is ${scaledImage.width} x ${scaledImage.height} pixel in size.

The ratio is: ${imageBean.ratio}.

</div>
   
  <div style="float:left; margin: 10px 20px 10px 0;">
    
<img src="${imageBean.srcUrl}" srcset="${imageBean.srcSet}" sizes="(min-width: 350px) 350px, 250px">
  </div>
  
  <div>
  ${value.Text}
  
  </div>
  

</div>

</cms:formatter>
