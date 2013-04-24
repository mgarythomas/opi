<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt1" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
  <head>
    <title>OPI - Password Finder</title>
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
          <a title="Show help page" href="javascript:ShowWinContact();%20void(0);">&gt;Help</a>
        </div>
        
        <br class="clear"/>
        
        <h1>Password Finder</h1>
      
        <spring:hasBindErrors name="keyvaluepair">
          <div class="errors" style="padding: 5px 10px; margin-bottom: 15px; border: 1px solid #C30B0B; background: #EBEBEB; line-height: 17px;">
            <ul style="margin-left: 20px; padding-bottom: 10px;">
              <c:forEach var="errMsgObj" items="${errors.allErrors}">
                <li style="color: #E92121; font-weight: bold;">
                  <spring:message code="${errMsgObj.code}" text="${errMsgObj.defaultMessage}" />
                </li>
              </c:forEach>
            </ul>
          </div>
        </spring:hasBindErrors>
        
        <div class="messages">
          <p>Select either your username or email address and enter it in the textbox below to retrieve your password.</p>
        </div>
        
        <form:form method="post" id="forgotpasswordForm" commandName="keyvaluepair">
          <div class="form-group">
            <div class="form-row last-row">
                <spring:bind path="key">
                  <input type="radio" name="key" value="0" class="auto" checked="checked" onclick="document.getElementById('theValue').value = 'Enter your username here ...'" />
                  <label class="attached" style="width: 75px;">Username</label>
                  <input type="radio" name="key" value="1" class="auto" onclick="document.getElementById('theValue').value = 'Enter your email address here ...'" />
                  <label class="attached" style="width: 75px;">Email</label>
                </spring:bind>
                <spring:bind path="value">
                  <input type="text" class="short" name="value" value="Enter your username here ..." style="width: 200px;" id="theValue"/>
                </spring:bind>
              <br class="clear"/>
            </div>
            <br class="clear"/>
          </div>

          <hr class="clear"/>
          
          <div class="button-row">
            <button type="submit" name="buttonForgotpassword">Find Password</button>

            <br class="clear"/>
          </div>          
              

        </form:form>
      </div>
      
      <jsp:include flush="true" page="/WEB-INF/jsp/includes/footer.jsp"/>

    </div>
  </body>
</html>