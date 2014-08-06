function replaceFootnotes() {
    $('span.footnote').each(function() {
       var footnote = $(this).html();
       var newTag = $("<span href='#' data-toggle='tooltip' title='" + footnote + "' class='glyphicon glyphicon-question-sign footnote-hover'></span>");
       $(newTag).tooltip();
       $(this).wrap("<sup></sup>");
       $(this).replaceWith(newTag);
    });
    
}

function indexSections() {
    var currentIndex = new Array(0,0,0,0);
    var indexString;
    var level;
    $(".section").each(function(index) {
       if($(this).hasClass("section-level-1")) {
           level = 1;
       } else if ($(this).hasClass("section-level-2")) {
           level = 2;
       } else if ($(this).hasClass("section-level-3")) {
           level = 3;
       } else if ($(this).hasClass("section-level-4")) {
           level = 4;
       }
       currentIndex = increaseIndex(currentIndex, level);
       indexString = buildIndexString(currentIndex, level);
       $(this).prepend("<a name='" + indexString + "'></a>" + indexString + " ");
       console.log( index + ": " + $(this).text());
    });
}

function buildIndexString(currentIndex, level) {
    var indexString = currentIndex[0];
    for (var i = 1; i < level; i++) {
        indexString += "." + currentIndex[i];
    }
    return indexString;
}

function increaseIndex(currentIndex, level) {
    var levelIndex = level - 1;
    currentIndex[levelIndex] = currentIndex[levelIndex] + 1;
    for (var i = level; i <= 4; i++) {
        currentIndex[i] = 0;
    }
    return currentIndex;
}

$('document').ready(function() {
        replaceFootnotes();
        indexSections();
});