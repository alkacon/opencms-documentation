function hideEditPoints() {
    $(".org-opencms-gwt-client-ui-css-I_CmsDirectEditCss-optionBar").hide();
    $(".documentation-demo-content .org-opencms-gwt-client-ui-css-I_CmsDirectEditCss-optionBar").show();
}

function placeHintsForDemoContentWrappers() {
    $(".documentation-demo-content").each(function() {
       if($.trim($(this).html())=='') {
           $(this).before("<h3>Please add the results of the demo or remove the frame if not needed.</h3>");
       } 
    });
}

function addClickHandlers() {
	var docButton = $('a.documentation-change-view')
    docButton.click(function(){
        $.get(docButton.data('documentation-change-view-url'), function() {
            location.reload();
        });
    });
}

$('document').ready(function() {
    if($("body").data("documentation-editor") != true) {
        $(window).bind("load", hideEditPoints);
    }
    $(".scroll-left").scrollLeft();
    $(".documentation-source-link").prepend("Source-URL: ");
    placeHintsForDemoContentWrappers();
    addClickHandlers();
});
