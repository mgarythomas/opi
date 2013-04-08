<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt1" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
  <head>
    <title>OPI - Beneficiaries</title>
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
        
        <h1>Beneficial Ownership Details</h1>
        
        <jsp:include flush="true" page="/WEB-INF/jsp/includes/errors_and_messages.jsp"/>

        <form:form id="beneficiaryForm" name="beneficiaryForm" method="post">
          <div class="messages">
            <p>
              Beneficial owners are persons who control 25% or more of the shares in the company or corporate trustee. This
              section must be completed by the beneficial owners of company and corporate trustee applicants.
            </p>
          </div>
          
          <h2>Beneficial Owner Details</h2>

          <p>The beneficial owner(s) of the account are detailed below:</p>
          
          <div class="form-group">
            <c:forEach var="investor" items="${application.investorindividualsarray}" varStatus="s">
              <c:if test="${investor.isapplicant == 'true' and investor.role != 'Guarantor'}">
                <div class="form-row last-row">
                  <tag:formCheckbox2 name="application.investorindividualsarray[${s.count -1}].individual.fullname"
                  msg=" is also a Beneficial Owner?"
                  path="application.investorindividualsarray[${s.count -1}].isbeneficiary" />
                </div>
              </c:if>
            </c:forEach>
            
            <hr class="clear"/>
            
            <div class="button-row">
              <input type="submit" name="addbeneficiary" class="button" value="Add Beneficial Owner"/>
              
              <br class="clear"/>
            </div>
          </div>
          
          <br class="clear"/>

          <c:forEach var="investor" items="${application.investorindividualsarray}" varStatus="s">
            <spring:nestedPath path="application.investorindividualsarray[${s.count -1}]">
              <c:if test="${investor.isapplicant == 'false'}">
                <tag:individual title="Beneficial Owner" formid="beneficiaryForm"
                  role="${application.investorindividualsarray[s.count -1].role}" formname="beneficiaryForm" 
                  displayindex="${application.beneficiaryindex}" index="${s.count-1}" />
              </c:if>
            </spring:nestedPath>
          </c:forEach>
          
          <p class="foot-note"><span style="color: red;">#</span> Denotes a Mandatory Field</p>
          
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