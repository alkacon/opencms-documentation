<%@page
    pageEncoding="UTF-8"
    buffer="none"
    session="false"
    trimDirectiveWhitespaces="true"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="mercury" tagdir="/WEB-INF/tags/mercury" %>


<cms:secureparams />
<mercury:init-messages>

<cms:formatter var="content" val="value">

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="alkacon.mercury.template.messages">

<mercury:setting-defaults>

<c:set var="pieceLayout"        value="${setting.pieceLayout.toInteger}" />
<c:set var="sizeDesktop"        value="${setting.visualOption.toInteger}" />
<c:set var="sizeMobile"         value="${setting.sizeMobile.isSetNotNone ? setting.sizeMobile.toInteger : null}" />
<c:set var="hsize"              value="${setting.hsize.toInteger}" />
<c:set var="imageRatio"         value="${setting.imageRatio.toString}" />
<c:set var="linkOption"         value="${setting.linkOption.toString}" />
<c:set var="showImageCopyright" value="${setting.showImageCopyright.toBoolean}" />
<c:set var="showImageSubtitle"  value="${setting.showImageSubtitle.toBoolean}" />
<c:set var="showImageZoom"      value="${setting.showImageZoom.toBoolean}" />
<c:set var="showImageLink"      value="${setting.showImageLink.toBoolean}" />
<c:set var="textAlignment"      value="${setting.textAlignment.toString}" />

<c:set var="headingOption"      value="${setting.headingOption.toString}" />
<c:set var="textOption"         value="${setting.textOption.toString}" />

<div class="element type-datasheet"><%----%>
<mercury:nl />

<c:forEach var="paragraph" items="${content.valueList.Paragraph}">
    <mercury:section-piece
        cssWrapper="subelement type-section${setCssWrapperAll}"
        pieceLayout="${pieceLayout < 11 ? pieceLayout : 4}"
        sizeDesktop="${sizeDesktop}"
        sizeMobile="${sizeMobile}"
        heading="${paragraph.value.Caption}"
        image="${paragraph.value.Image}"
        text="${paragraph.value.Text}"
        link="${paragraph.value.Link}"
        hsize="${hsize}"
        imageRatio="${imageRatio}"
        textOption="${textOption}"
        textAlignment="${textAlignment}"
        linkOption="${linkOption}"
        showImageCopyright="${showImageCopyright}"
        showImageSubtitle="${showImageSubtitle}"
        showImageZoom="${showImageZoom}"
        showImageLink="${showImageLink}"
        ade="${cms.isEditMode}"
        emptyWarning="${true}"
    />
</c:forEach>

</div><%----%>
<mercury:nl />

</mercury:setting-defaults>

</cms:bundle>
</cms:formatter>

</mercury:init-messages>