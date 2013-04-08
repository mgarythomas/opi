<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt1" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
  <head>
    <title>OPI - Investor Details</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
  
    <jsp:include flush="true" page="/WEB-INF/jsp/includes/scripts_and_styles.jsp"/>
    
    <script type="text/javascript">
      <!--//
      
      function populateAddress(i) {
         var address1 = dwr.util.getValue("investorindividuals[0].individual.address1");
         var suburb = dwr.util.getValue("investorindividuals[0].individual.suburb");
         var state = dwr.util.getValue("investorindividuals[0].individual.state");
         var postcode = dwr.util.getValue("investorindividuals[0].individual.postcode");
         var country = dwr.util.getValue("investorindividuals[0].individual.country");
         document.getElementById('investorindividuals['+i+'].individual.address1').value=address1;
         document.getElementById('investorindividuals['+i+'].individual.suburb').value=suburb;
         document.getElementById('investorindividuals['+i+'].individual.state').value=state;
         document.getElementById('investorindividuals['+i+'].individual.postcode').value=postcode;
         document.getElementById('investorindividuals['+i+'].individual.country').value=country;
      }
      
      function setFormElements() {
        <c:forEach var="investor" items="${application.investorindividuals}" varStatus="s">
          if (document.getElementById("checkOther${s.count - 1}").checked) {
            document.getElementById("textOther${s.count - 1}").disabled = false;
          } else {
            document.getElementById("textOther${s.count - 1}").disabled = true;
          }
        </c:forEach>
      }
      
      function cancel() {
        if (confirm("Abandon changes made on this page?")) {
          document.location.href = '${startpage}';
        }
      }
      //-->
    </script>

  </head>
  
  <body onload="setFormElements();">
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
        
        <h1>Investor Details</h1>
        
        <jsp:include flush="true" page="/WEB-INF/jsp/includes/errors_and_messages.jsp"/>

        <form:form method="post">
          <spring:nestedPath path="application">
            <h2>Account Designation</h2>
            
            <div class="form-group">
              <div class="form-row">
                <tag:formField2Col name="Account Name [1]" path="accountdesignation" dimension="veryLong" mand="true" maxlength="38"/>
              </div>
              
              <br/>
              
              <div class="two-columns">
                <div class="first-column">
                  <div class="form-row">
                    <tag:formField2Col name="Contact Person First Name" path="firstname" dimension="medium" mand="true" maxlength="24" />
                  </div>
                  <div class="form-row">
                    <tag:formField2Col name="Contact Person Surname" path="lastname" dimension="medium" mand="true" maxlength="24" />
                  </div>
                  <div class="form-row">
                    <tag:formField2Col name="Contact Telephone" path="homephone" dimension="small" mand="true" maxlength="20"/>
                  </div>
                  <div class="form-row">
                    <tag:formField2Col name="Contact Fax" path="fax" dimension="small" maxlength="20" />
                  </div>
                  <div class="form-row last-row">
                    <tag:formField2Col name="Contact Email" path="email" dimension="medium" maxlength="50" />
                  </div>
                </div>
                <div class="second-column">
                  <div class="form-row">
                    <tag:formField2Col name="Postal Address" path="address1" dimension="medium" mand="true" maxlength="32" />
                  </div>
                  <div class="form-row">
                    <tag:formField2Col name="Suburb" path="suburb" dimension="medium" mand="true" maxlength="25" />
                  </div>
                  <div class="form-row">
                    <tag:formStates name="State" mand="true" path="state" list="states"  />
                  </div>
                  <div class="form-row">
                    <tag:formField2Col name="Postcode" mand="true" path="postcode" dimension="veryShort" maxlength="4" />
                  </div>
                  <div class="form-row last-row">
                    <tag:formDefaultCountries name="Country" mand="true" path="country" map="defaultcountries" />
                  </div>
                </div>
                
                <br/>
                
              </div>
            </div>
          </spring:nestedPath>
          
          <br class="clear"/>
          
          <p class="foot-note">
            <strong>[1]</strong> This is the name in which Units will be registered. This 
            should correspond to and contain the name of the Applicant. 
            Maximum 38 characters.
          </p>
          
          <c:if test="${application.product.code == 'hfa'}">
            <div class="messages">
              <p>
                The collection of TFNs and ABNs is authorized by law. Your client can provide their ABN if they have
                made this investment in the course or furtherance of an enterprise that they carry on in Australia. It
                is not an offence if they choose not to quote their TFN or ABN. If they do not supply their TFN or a
                valid exemption (or in certain circumstances an ABN), tax will be deducted by HFA from any distributions
                paid to your client at the highest marginal tax rate (plus Medicare Levy) and forwarded to the
                Australian Tax Office.
              </p>
            </div>
          </c:if>
          
          <c:if test="${!empty application.company}">
            <spring:nestedPath path="application.company">
              <tag:company trust="${application.istrust}" formname="applicationForm"/>
            </spring:nestedPath>
          </c:if>
          
          <c:if test="${!empty application.trust}">
            <spring:nestedPath path="application.trust">
              <jsp:include page="/WEB-INF/jsp/trust.jsp" flush="true" />
            </spring:nestedPath>
          </c:if>
          
          <c:forEach var="investor" items="${application.investorindividuals}" varStatus="s">
            <spring:nestedPath path="application.investorindividuals[${s.count -1}]">
              <c:if test="${investor.isapplicant == 'true' and investor.role != 'Guarantor'}">
                <tag:individual 
                  title="${application.investorindividualsarray[s.count -1].role}"
                  formid="applicationForm" role="${application.investorindividualsarray[s.count -1].role}"
                  director="${application.investorindividualsarray[s.count -1].isdirector}"
                  trust="${application.istrust}"
                  apptype="${application.type}"
                  formname="applicationForm"
                  displayindex="${application.applicantindex}"
                  index="${s.count -1}" />
              </c:if>
            </spring:nestedPath>
          </c:forEach>
          
          <hr class="clear"/>
      
          <div class="button-row">
            <input type="submit" class="button" name="proceed" value="Proceed"/>
            <c:if test="${(application.type == 1) || (application.type == 3) || (!application.hasSufficientDirectors)}">
              <input type="submit" name="addinvestor" class="button attached" value="Add Applicant"/>
            </c:if>
            <input type="submit" name="save" class="button attached" value="Save and Return"/>
            <button type="button" class="button attached" onclick="cancel();">Cancel</button>
            
            <br class="clear"/>
          </div>
          
          <input type="hidden" name="action" id="action"/>
        </form:form>
        <script type="text/javascript">
            function catcalc(cal) {
                var date = cal.date;
                var time = date.getTime()
                // use the _other_ field
                var field = document.getElementById("f_calcdate");
                if (field == cal.params.inputField) {
                    field = document.getElementById("f_date_a");
                    time -= Date.WEEK; // substract one week
                } else {
                    time += Date.WEEK; // add one week
                }
                var date2 = new Date(time);
                field.value = date2.print("%Y-%m-%d %H:%M");
            }
        </script>
      </div>
      
      <jsp:include flush="true" page="/WEB-INF/jsp/includes/footer.jsp"/>

    </div>
  </body>
</html>
