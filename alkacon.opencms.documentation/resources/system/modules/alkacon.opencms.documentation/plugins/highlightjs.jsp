<%@page
    pageEncoding="UTF-8"
    trimDirectiveWhitespaces="true"
    buffer="none"
    session="false" %>

<script>
mercury.ready(function(jQ, DEBUG) {
    function sleep(ms) {
        return new Promise(resolve => setTimeout(resolve, ms));
    }

    async function waitForHljs() {
        while(typeof hljs === "undefined") {
            await sleep(50);
        }
        hljs.highlightAll();
    }

    waitForHljs();
});
</script>