function hideEditPoints() {
    $(".org-opencms-gwt-client-ui-css-I_CmsDirectEditCss-optionBar").hide();
    $(".documentation-demo-content .org-opencms-gwt-client-ui-css-I_CmsDirectEditCss-optionBar").show();
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
    addClickHandlers();
});
