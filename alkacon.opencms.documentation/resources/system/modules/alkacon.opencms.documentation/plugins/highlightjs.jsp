<%@page
    pageEncoding="UTF-8"
    trimDirectiveWhitespaces="true"
    buffer="none"
    session="false" %>

<script>
mercury.ready(function() {
    try {
        hljs.highlightAll();
    } catch (e) {
        // highlight JS was not completely loaded, try again
        setTimeout(function(){ hljs.highlightAll(); }, 500);
    }
});
</script>