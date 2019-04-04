DocumentationJS = function(jQ) {
    function replaceFootnotes() {
        $('span.footnote').each(function() {
           var footnote = $(this).html();
           var newTag = $("<span data-toggle='tooltip' title='" + footnote + "' class='fa fa-question-circle footnote-hover'></span>");
           $(newTag).tooltip({
     		   'selector': '',
        		'placement': 'top',
        		'container':'body'
      		});
           $(this).wrap("<sup></sup>");
           $(this).replaceWith(newTag);
        });

    }

    function addPageNavHandler() {
        $('.page-nav').click(function (e) {
            e.stopPropagation();
         });
    	$('.page-nav-btn').click(function(e) {
    		$('.page-nav').show();
    		e.stopPropagation();
    		$('body').one('click', function() {
    		    $('.page-nav').hide();
    		});
    	});
    	$('.page-nav .close').click(function() {
    		$('.page-nav').hide();
    	});
    	$("#documentation-github-links-hide").toggle();
    	$('.github-links-switcher').click(function(e) {
    		$(".github-link").toggle();
    		$(".github-links-switcher").toggle();
    		e.stopPropagation();
    	});
    }

    var $ = jQ;
    addPageNavHandler();
    replaceFootnotes();
    $(".documentation-source-link").prepend("Source-URL: ");
    $(".github-link").hide();
}

mercury.ready(DocumentationJS);
