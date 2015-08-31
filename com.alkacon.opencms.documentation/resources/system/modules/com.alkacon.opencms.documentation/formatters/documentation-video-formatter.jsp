<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="autoplay">${cms.element.settings.autoplay ? 1 : 0}</c:set>
<c:set var="loop">${cms.element.settings.loop ? 1 : 0}</c:set>
<c:set var="fs">${cms.element.settings.fs ? 1 : 0}</c:set>
<c:set var="showinfo">${cms.element.settings.showinfo ? 1 : 0}</c:set>
<c:set var="width">${cms.element.settings.width}</c:set>
<c:set var="height">${cms.element.settings.height}</c:set>

<cms:formatter var="content">
	${cms.enableReload}
	<div>
		<c:if test="${content.value.VideoID.isSet}">
			<c:if test="${cms.isEditMode}">
				<div id="ytplayer"></div>
	
				<script>
				  // Load the IFrame Player API code asynchronously.
				  var tag = document.createElement('script');
				  tag.src = "https://www.youtube.com/player_api";
				  var firstScriptTag = document.getElementsByTagName('script')[0];
				  firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
				
				  // Replace the 'ytplayer' element with an <iframe> and
				  // YouTube player after the API code downloads.
				  var player;
				  function onYouTubePlayerAPIReady() {
					player = new YT.Player('ytplayer', {
					  height: '${height}',
					  width: '${width}',
					  videoId: '${content.value.VideoID}',
        			  playerVars: { 'autoplay':${autoplay},'loop':${loop},'fs':${fs},'showinfo':${showinfo},'rel':0,'modestbranding':1 }
					});
				  }
				</script>
			</c:if>
			
			<c:if test="${not cms.isEditMode}">
				<iframe id="${content.value.Identifier}" type="text/html" width="${width}" height="${height}" 
					src="http://www.youtube.com/embed/${content.value.VideoID}?autoplay=${autoplay}&loop=${loop}&fs=${fs}&showinfo=${showinfo}&rel=0&modestbranding=1" frameborder="0" />
			</c:if>
		</c:if>
		
		<c:if test="${not content.value.VideoID.isSet}">
			<div class="alert alert-danger" style="width: ${width}px; height: ${height}px;">
				<h2>
					Please enter the VideoID for the video you want to show here.
				</h2>
			</div>
		</c:if>
	</div>
</cms:formatter>