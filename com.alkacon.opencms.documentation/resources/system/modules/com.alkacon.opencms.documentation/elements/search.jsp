<%@page
    pageEncoding="UTF-8"
    buffer="none"
    session="false"
    trimDirectiveWhitespaces="true"%>

<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>

<div class="tag-box tag-box-v4">
  <h5>Search the documentation</h5>
  <form class="styled-form no-border compact" role="form" action='<cms:link>%(link.weak:/sites/default/opencms-documentation/search/:ee7e543b-ac5d-11e4-b42e-0242ac11002b)</cms:link>'>
    <section>
      <div class="input">
      	<input type="text" class="form-control" id="q" name="q" placeholder="Enter query">
      </div>
    </section>
    <button type="submit" class="btn btn-block btn-primary">Search</button>
  </form>
</div>