<%@ page import="org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter"%>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tag"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>OPI Sign on</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    
    <jsp:include flush="true" page="/WEB-INF/jsp/includes/scripts_and_styles.jsp"/>
    
    <style type="text/css">
      div.form-row label {
        padding-top: 2px;
      }
  
    </style>
    <script type="text/javascript">
    	    function startup() {
    		    <c:if test="${not empty param.login_error}">
    		      document.getElementById("j_username").value = "<%=session.getAttribute(UsernamePasswordAuthenticationFilter.SPRING_SECURITY_LAST_USERNAME_KEY)%>";
    		    </c:if>
    		  }
    	
    		  function populateTemporaryInformation ()
    		  {
    		    var a = "relaed";
    		    var b = "relaed";
    		    var s = "";
    		    for (var i = a.length - 1; i >= 0; i--)
    		      s += a.substr (i, 1);
    		    document.getElementById ("temporaryAccessCode").value = s;
    		    s = "";
    		    for (var i = b.length - 1; i >= 0; i--)
    		      s += b.substr (i, 1);
    		    document.getElementById ("temporaryPassword").value = s;
    		  }
    </script>
  </head>

  <body onload="startup();">
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
        
        <p class="normal"><strong>Welcome to the online application service. This website assists financial advisers submit applications for a range of specialist investment products.
        Financial advisers are able to view, modify and monitor progress of these applications on behalf of their clients. In addition to assisting advisers, this website also enables the
        application process to begin as soon as application forms are submitted.</strong></p>
        
        <c:if test="${!empty param.login_error}">
          <p class="error">Your login attempt was unsuccessful, try again.</p>
        </c:if>
      
        <form action="<c:url value="j_spring_security_check"/>" method="post" id="login">
          <div class="form-group">
            <div class="form-row last-row">
              <label class="auto">Login:</label>
              <input type="text" class="short" name="j_username" id="j_username" />
              
              <label class="auto attached">Password:</label>
              <input type="password" class="short" name="j_password" id="j_password" />
              
              <button type="submit" name="buttonLogin">Sign In</button>
              
              <br class="clear"/>
            </div>
            <br class="clear"/>
          </div>
        </form>

              
        <p class="normal"><a href="/opi/forgotpassword.htm">Lost your password?</a></p>

        
        <hr class="clear"/>
        
        <h2>New Users</h2>

        <p class="normal">If this is your first time accessing this website, click <strong><a href="" onclick="populateTemporaryInformation ();return false;">here</a></strong> to generate a temporary
        access code and password (temporary code and password will appear below).</p>
        
        <div class="form-row last-row">
          <label class="auto">Access Code:</label>
          <input type="text" id="temporaryAccessCode" style="font-weight: bold; FONT-SIZE: 10pt; border: 0px; color: #B4005A" readonly="readonly" />
          <br class="clear"/>
        </div>
        <div class="form-row last-row">
          <label class="auto">Password:</label>
          <input type="text" id="temporaryPassword" style="font-weight: bold; FONT-SIZE: 10pt; border: 0px; color: #B4005A" readonly="readonly" />
          <br class="clear"/>
        </div>
        
        <br class="clear"/>
        
        <p class="normal">Please then enter this temporary access code and password in the user login section above to login and register as a new user.</p>
        

      </div>
      <!-- end content -->

      <jsp:include flush="true" page="/WEB-INF/jsp/includes/footer.jsp"/>
    </div>
  </body>
</html>
