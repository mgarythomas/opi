<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
  <!--
  var cwin = null;
  
  function ShowWinContact() {
    if (cwin != null) {
      if (cwin.closed == false) {
        cwin.focus();
        return;
      }
    }
    
    var sTmp = './html/Contact.html'
    
    cwin = window.open(sTmp,'Contact','width=550,height=380,scrollbars=yes,resizable=no,status=no');
  }
  //-->
</script>

<div class="breadcrumb">
  <a onclick="return confirm('Any unsaved changes will be lost.  Are you sure?');" 
     title="Go Back" 
     href="<c:url value="/mainpage_redirect.htm"/> ">&gt;Back To Main Page</a>
  <a title="Logout of OPI" href="<c:url value="/j_spring_security_logout"/>">&gt;Logout</a>
  <a title="Show help page" href="javascript:ShowWinContact(); void(0);">&gt;Help</a>
</div>
