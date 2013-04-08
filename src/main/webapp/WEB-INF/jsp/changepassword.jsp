<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt1" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
  <head>
    <title>OPI - New Adviser</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
  
    <jsp:include flush="true" page="/WEB-INF/jsp/includes/scripts_and_styles.jsp"/>
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
        
        <h1>Password Change</h1>
      
        <jsp:include flush="true" page="/WEB-INF/jsp/includes/errors_and_messages.jsp"/>
        
        <div class="info-box">
          <p>Please create a new password (between 6 and 10 characters)</p>
        </div>
        
        <c:if test="${!empty param.login_error}">
          <p class="error">Your login attempt was unsuccessful, try again.</p>
        </c:if>

        <form:form>
          <spring:nestedPath path="advisor.individual.users">
            <div class="form-group">
              <div class="form-row">
                <tag:formField name="New Password" path="password" dimension="short" type="password"/>
              </div>
              <div class="form-row last-row">
                <tag:formField name="Retype New Password" path="checkpassword" dimension="short" type="password"/>
              </div>
              
              <br class="clear"/>
            </div>
            
            <p class="foot-note"><span style="color: red;">#</span> Denotes a Mandatory Field</p>
            
            <hr class="clear"/>
            
            <div class="button-row">
              <input class="button" id="next" type="submit" value="Change Password" name="update">
        
              <br class="clear"/>
            </div>
          </spring:nestedPath>
        </form:form>
       </div>
       
       <jsp:include flush="true" page="/WEB-INF/jsp/includes/footer.jsp"/>
    </div>
  </body>
</html>
        