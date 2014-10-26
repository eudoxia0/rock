$(document).ready(function() {
    $('main pre code').each(function(idx, elem) {
        $(elem).addClass('lisp');
    });
    HighlightLisp.highlight_auto();
});
