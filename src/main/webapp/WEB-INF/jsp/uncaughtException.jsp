<%@ page import="com.ubs.opi.domain.ServletHelper"%>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt1" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
  <head>
    <title>OPI - Applications Summary</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
  
    <jsp:include flush="true" page="/WEB-INF/jsp/includes/scripts_and_styles.jsp"/>
    
    <% ServletHelper.logException(request); %>
  </head>
  
  <body>
    <div id="wrapper">
      <jsp:include flush="true" page="/WEB-INF/jsp/includes/header.jsp"/>

      <!-- content -->
      <div id="content">
        <div class="breadcrumb-left">&#160;</div>
        <div class="breadcrumb-right">
          <a title="Logout of OPI" href="<c:url value="/j_spring_security_logout"/>">&gt;Logout</a>
          <a title="Show help page" href="javascript:ShowWinContact();%20void(0);">&gt;Help</a>
        </div>
        
        <br class="clear"/>
        
        <h1>Internal Error</h1>
        
        <div class="info-box">
          <p>We Apologise that a fatal error has occurred. Notification has been sent to our system administrators.</p>
          <p>Please close your browser and try again.</p>
        </div>
        
        <hr class="clear"/>
        
        <form method="get" action='<c:url value="/j_acegi_logout"/>' name="formLogin">
          <div class="button-row">
            <input name="return" type="submit" class="button" value="Log Out" />

            <br class="clear"/>
          </div>
        </form>
      </div>
      
      <jsp:include flush="true" page="/WEB-INF/jsp/includes/footer.jsp"/>

    </div>
  </body>
</html>