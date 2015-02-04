<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" taglibs="c,cms,fn" import="org.opencms.main.OpenCms"%>
<div class="tag-box tag-box-v4">
  <h5>Search the documentation</h5>
  <form class="form" role="form" action='<cms:link>%(link.weak:/opencms-documentation/search/)</cms:link>'>
    <div class="form-group">
      <label class="sr-only" for="q">Search in the documentation</label>
      <input type="text" class="form-control" id="q" name="q" placeholder="Enter query">
    </div>
    <button type="submit" class="btn btn-block btn-primary">Search</button>
  </form>
</div>