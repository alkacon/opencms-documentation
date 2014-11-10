<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" taglibs="c,cms,fn" import="org.opencms.main.OpenCms"%>
<div class="tag-box tag-box-v4">
  <h5>Search the documentation</h5>
  <form class="form" role="form" action="http://www.google.com/search" target="_blank">
    <div class="form-group">
      <label class="sr-only" for="q">Search in the documentation</label>
      <input type="text" class="form-control" id="q" name="q" placeholder="Enter query">
    </div>
    <input type="hidden" name="sitesearch" value='<%= OpenCms.getModuleManager().getModule("com.alkacon.opencms.documentation").getParameter("sitesearch","") %>'>
    <button type="submit" class="btn btn-block btn-primary">Search via Google</button>
  </form>
</div>