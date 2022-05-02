<%@page
    pageEncoding="UTF-8"
    trimDirectiveWhitespaces="true"
    buffer="none"
    session="false" %>

<script>
mercury.ready(function() {
    hljs.configure({
           languages: ['jsp', 'java', 'html', 'javascript', 'css', 'bash']
        });
    hljs.initHighlightingOnLoad();
});
</script>