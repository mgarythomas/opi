<%@ page import="org.acegisecurity.ui.webapp.AuthenticationProcessingFilter"%>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tag"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>Lost Password</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    
    <jsp:include flush="true" page="/WEB-INF/jsp/includes/scripts_and_styles.jsp"/>
    
    <script type="text/javascript">
    </script>
  </head>

  <body>
    <div id="wrapper" style="width: 900px;"><!-- header -->
      <div id="header" style="margin: 5px 5px; text-align: center;">
        <!-- Logo Image and Text -->
        <img align="middle" src="<spring:theme code="banner.img"/>"/>
      </div>
    
      <!-- content -->
      <div id="content">
        <div class="breadcrumb-left">&#160;</div>
        <div class="breadcrumb-right">
          <a title="Show help page" href="javascript:ShowWinContact();%20void(0);">&gt;Help</a>
        </div>
        
        <br class="clear"/>
        
        <h1>Online Applications</h1>
        
        <p class="normal"><strong>Welcome to the online application service.</strong></p>
        
        <c:if test="${!empty param.login_error}">
          <p class="error">You were not located in the database, try again.</p>
        </c:if>
      
        <form action="<c:url value="j_spring_security_check"/>" method="post" id="login">

          <input type="hidden" id="finder" name="finder" value="true" />
          <input type="hidden" id="j_username" name="j_username" value="dealer" />
          <input type="hidden" id="j_password" name="j_password" value="dealer" />

          <div class="form-group">
            <div class="form-row last-row">


              <label class="auto">Login:</label>

              <input type="radio" name="key" value="0" />Username&nbsp;&nbsp;
              <input type="radio" name="key" value="1" />Email&nbsp;&nbsp;
              <input type="text" class="short" name="value">

              <p class="normal"><a href="/opi/j_spring_security_password.jsp">Lost your password?</a></p>
              <button type="submit" value="Find Password" name="login"/>
              
              <br class="clear"/>
            </div>
            <br class="clear"/>
          </div>
        </form>

      </div>
      <!-- end content -->

      <jsp:include flush="true" page="/WEB-INF/jsp/includes/footer.jsp"/>
    </div>
  </body>
</html>
