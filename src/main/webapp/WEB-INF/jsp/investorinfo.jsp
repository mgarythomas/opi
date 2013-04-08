
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt1" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
  <head>
    <title>OPI - Investor Information</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
  
    <jsp:include flush="true" page="/WEB-INF/jsp/includes/scripts_and_styles.jsp"/>
    
    <script type="text/javascript">
      <!-- //
        
      function cancel() {
        if (confirm("Abandon changes made on this page?")) {
          document.location.href = '${startpage}';
        }
      }
      
      // -->
    </script>
    
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
        
        <h1>Other Investor Information</h1>
        
        <jsp:include flush="true" page="/WEB-INF/jsp/includes/errors_and_messages.jsp"/>
        
        <form:form method="post">
          <spring:nestedPath path="application">
            <h2>Annual Reports</h2>
            
            <div class="form-group">
              <p>
                Would the investor like to receive a paper copy of the annual report for the HFA
                Octane Global Fund each year? An electronic copy will be made available on HFA website
                at
                <a href="http://www.HFAinvestments.com.au" target="_blank">www.hfainvestments.com.au</a>
              </p>
              
              <div class="form-row last-row">
                <tag:formInlineCheckBox
                  name="<b>Yes, please provide a paper copy of the annual financial report</b>"
                  path="ispapercopywanted" />
              </div>
            </div>
            
            <h2>Other HFA Investments</h2>
            
            <div class="form-group">
              <p>
                Please indicate below if the applicant is currently an Investor in any fund managed by
                HFA (leave blank if they are not):
              </p>
              <div class="two-columns">
                <div class="first-column">
                  <div class="form-row">
                    <tag:formCheckbox name="Yes" path="isprovidercustomer" />
                  </div>
                  <div class="form-row">
                    <tag:formField2Col name="Unit Holder Number" path="providerunitholdernumber"
                      dimension="veryLong" maxlength="25" />
                  </div>
                  <div class="form-row last-row">
                    <tag:formField2Col name="Fund Name" path="providerfundname" dimension="veryLong" maxlength="25" />
                  </div>
                </div>
                <div class="second-column">&#160;</div>
              </div>
            </div>
            
            <hr class="clear"/>
            
            <div class="form-group">
              <p>
                Please indicate below if the applicant has previously obtained a loan or put option
                from UBS Australia in relation to any fund managed by HFA (leave blank if they have
                not):
              </p>
              <div class="two-columns">
                <div class="first-column">
                  <div class="form-row">
                    <tag:formCheckbox name="Yes" path="isubscustomer" />
                  </div>
                  <div class="form-row">
                    <tag:formField2Col name="Unit Holder Number" path="ubsunitholdernumber" dimension="veryLong"
                      maxlength="25" />
                  </div>
                  <div class="form-row last-row">
                    <tag:formField2Col name="Fund Name" path="ubsfundname" dimension="veryLong" maxlength="25" />
                  </div>
                </div>
                <div class="second-column">&#160;</div>
              </div>
            </div>
            
            <hr class="clear"/>

            <c:if test="${application.type == 1 || application.type == 2 || application.type == 4 }">
            
              <h2>Account Operating Instructions</h2>
              
              <div class="form-group">
                <c:if test="${application.type == 1}">
                  <p class="hrIefix">
                    If you do not tick the box below we will assume operating instructions require
                    &ldquo;Both to sign together&rdquo;.
                  </p>
                  
                  <div class="form-row">
                    <tag:formInlineCheckBox name="<b>Either to sign</b>" path="iseithertosign" />
                  </div>
                </c:if>
                <c:if test="${application.type == 2 || application.type == 4}">
                  <p class="hrIefix">
                    If the box below is not ticked, all future written instructions regarding your
                    investment must be executed by two directors or by a director and company
                    secretary.
                  </p>
                  <div class="form-row last-row">
                    <tag:formInlineCheckBox name="<b>Any one officer to sign</b>"
                      path="iseithertosign" />
                  </div>
                </c:if>
              </div>
            </c:if>
          </spring:nestedPath>
          
          <hr class="clear"/>
      
          <div class="button-row">
            <input type="submit" name="proceed" class="button" value="Proceed"/>
            <input type="submit" name="save" class="button attached" value="Save and Return"/>
            <button type="button" class="button attached" onclick="cancel();">Cancel</button>
  
            <br class="clear"/>
          </div>
        </form:form>
      </div>
      
      <jsp:include flush="true" page="/WEB-INF/jsp/includes/footer.jsp"/>

    </div>
  </body>
</html>
