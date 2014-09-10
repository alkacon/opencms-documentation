function replaceFootnotes() {
    $('span.footnote').each(function() {
       var footnote = $(this).html();
       var newTag = $("<span href='#' data-toggle='tooltip' title='" + footnote + "' class='glyphicon glyphicon-question-sign footnote-hover'></span>");
       $(newTag).tooltip();
       $(this).wrap("<sup></sup>");
       $(this).replaceWith(newTag);
    });
    
}

function expand(e) {
    $(this).removeClass('icon-expand');
    $(this).addClass('icon-collapse');
    $(this).parent().parent().next().show();
    $(this).unbind("click",expand);
    $(this).bind("click",collapse);    
    e.preventDefault();
}

function collapse(e) {
    $(this).removeClass('icon-collapse');
    $(this).addClass('icon-expand');
    $(this).parent().parent().next().hide();
    $(this).unbind("click",collapse);
    $(this).bind("click",expand);
    e.preventDefault();
}

$('document').ready(function() {
    replaceFootnotes();
    $("span.nav-side-toggle-sublevel.icon-collapse").bind("click",collapse);
    $("span.nav-side-toggle-sublevel.icon-expand").bind("click",expand);
    $("span.nav-side-toggle-sublevel").mouseenter( 
            function() {
                $(this).parent().mouseleave();
    });
    $("span.nav-side-toggle-sublevel").mouseleave( 
            function() {
                $(this).parent().mouseenter();
    });
});
