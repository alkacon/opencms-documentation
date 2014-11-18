function replaceFootnotes() {
    $('span.footnote').each(function() {
       var footnote = $(this).html();
       var newTag = $("<span data-toggle='tooltip' title='" + footnote + "' class='glyphicon glyphicon-question-sign footnote-hover'></span>");
       $(newTag).tooltip({
 		   'selector': '',
    		'placement': 'top',
    		'container':'body'
  		});
       $(this).wrap("<sup></sup>");
       $(this).replaceWith(newTag);
    });
    
}

function expand(e) {
    $(this).removeClass('glyphicon-expand');
    $(this).addClass('glyphicon-collapse-down');
    $(this).parent().parent().next().show();
    $(this).unbind("click",expand);
    $(this).bind("click",collapse);    
    e.preventDefault();
}

function collapse(e) {
    $(this).removeClass('glyphicon-collapse-down');
    $(this).addClass('glyphicon-expand');
    $(this).parent().parent().next().hide();
    $(this).unbind("click",collapse);
    $(this).bind("click",expand);
    e.preventDefault();
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
	})
}

$('document').ready(function() {
	addPageNavHandler();
    replaceFootnotes();
    $("span.nav-side-toggle-sublevel.data-nav-collapse").bind("click",collapse);
    $("span.nav-side-toggle-sublevel.data-nav-expand").bind("click",expand);
    $("span.nav-side-toggle-sublevel").mouseenter( 
            function() {
                $(this).parent().mouseleave();
    });
    $("span.nav-side-toggle-sublevel").mouseleave( 
            function() {
                $(this).parent().mouseenter();
    });
	$(".documentation-source-link").prepend("Source-URL: ");
});
