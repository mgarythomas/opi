<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt1" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
  <head>
    <title>OPI - Direct Debit</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
  
    <jsp:include flush="true" page="/WEB-INF/jsp/includes/scripts_and_styles.jsp"/>
    
    <script type="text/javascript">
      function fillAddress(id) {
        var idval = id;
        var bsb = dwr.util.getValue("bsb");
        
        Opi.fillAddress(bsb,idval, function(address) {
      		alert("address="+document.getElementById("address1").value);
      	    dwr.util.setValues(address);
      		alert("address="+document.getElementById("address1").value);
          
          if (document.getElementById("name").value != "") {
    //    		document.getElementById("name").disabled = true;
    //        document.getElementById("address1").disabled = true;
    //        document.getElementById("suburb").disabled = true;
    //        document.getElementById("postcode").disabled = true;
    //        document.getElementById("state").disabled = true;
          } else {
        		document.getElementById("name").disabled = false;
            document.getElementById("address1").disabled = false;
            document.getElementById("suburb").disabled = false;
            document.getElementById("postcode").disabled = false;
            document.getElementById("state").disabled = false;
          }
        }
        );
      }
      
      function fillDirectCreditInstitution(applicationId) {
        var bsb = document.getElementById("directCreditDetails.bsb").value;
        
        Opi.findDirectCreditInstitution(bsb, applicationId, function(bank) {
      		document.getElementById("directCreditDetails.institution").value = clean(bank.name);
          document.getElementById("directCreditDetails.institutionAddress").value = clean(bank.address1);
          document.getElementById("directCreditDetails.institutionSuburb").value = clean(bank.suburb);
          document.getElementById("directCreditDetails.institutionPostcode").value = clean(bank.postcode);
          document.getElementById("directCreditDetails.institutionState").value = clean(bank.state);
          if (document.getElementById("directCreditDetails.institution").value != "") {
            // institution found.  disable fields.
        		document.getElementById("directCreditDetails.institution").disabled = true;
            document.getElementById("directCreditDetails.institutionAddress").disabled = true;
            document.getElementById("directCreditDetails.institutionSuburb").disabled = true;
            document.getElementById("directCreditDetails.institutionPostcode").disabled = true;
            document.getElementById("directCreditDetails.institutionState").disabled = true;
          } else {
        		document.getElementById("directCreditDetails.institution").disabled = false;
            document.getElementById("directCreditDetails.institutionAddress").disabled = false;
            document.getElementById("directCreditDetails.institutionSuburb").disabled = false;
            document.getElementById("directCreditDetails.institutionPostcode").disabled = false;
            document.getElementById("directCreditDetails.institutionState").disabled = false;
          }
      	});
      }
      
      function clean(theValue) {
        return theValue != null ? theValue : "";
      }
      
      
      function cancel() {
        if (confirm("Abandon changes made on this page?")) {
          document.location.href = '${startpage}';
        }
      }
      
      function onLoad() {
        <c:if test="${application.product.directDebitRequired}">
          fillAddress('${application.id}');
        </c:if>
        
        <c:if test="${application.product.directCreditRequired}">
          fillDirectCreditInstitution('${application.id}');
        </c:if>
      }
    </script>

  </head>
  
  <body onload="onLoad();">
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

        <jsp:include flush="true" page="/WEB-INF/jsp/includes/errors_and_messages.jsp"/>

        <form:form>
          <spring:nestedPath path="application">
            <c:set var="applicationid" value="${application.id}"/>
            <c:if test="${application.product.directDebitRequired}">
              <h1>Direct Debit Authorisation</h1>
              
              <div class="messages">
                <p>
                  UBS Australia will direct debit interest and any protection fee for loan or put applications from the bank account
                  specified below. Interest rates will be set by UBS Australia on or around 13th June 2007, and will be posted on
                  the HFA website at
                  <a href="http://www.hfainvestments.com.au" target="_blank">www.hfainvestments.com.au</a>.
                  <br/>
                  If an investor funds their own investment, HFA will direct debit the investment amount from the bank account
                  specified below when the application is accepted.
                </p>
              </div>
            
              <p class="foot-note">
                An amount sufficient to cover the total payment obligations must be in the specified account by no later than
                <strong>15th June 2007</strong>.
              </p>
              <p class="foot-note">
                Please note that you cannot supply a third party bank account. The bank account below must be in the name of the
                investor(s) making this application.
              </p>
        
              <h2 class="main">Client Account Details</h2>
              
              <div class="form-group">
                <div class="two-columns">
                  <div class="first-column">
                    <div class="form-row">
                      <tag:formField2Col id="bsb" name="BSB Number" path="ddbsb" dimension="short" mand="true" onblur="fillAddress('${applicationid}')"/>
                    </div>
                    <div class="form-row last-row">
                      <tag:formField2Col name="Name of Account" path="ddaccountname" dimension="medium" mand="true" maxlength="80" />
                    </div>
                  </div>
                  <div class="second-column">
                    <div class="form-row">
                      <tag:formField2Col id="ddAccountType" name="Account Type" path="ddAccountType" dimension="short" mand="true"/>
                    </div>
                    <div class="form-row last-row">
                      <tag:formField2Col id="accountno" name="A/C Number" path="ddaccountno" dimension="short" mand="true" maxlength="10" />
                    </div>
                  </div>
                </div>
              </div>
            
              <hr class="clear"/>
              
              <h2>Financial Institution Details</h2>
                
              <div class="form-group">
                <div class="two-columns">
                  <div class="first-column">
                    <div class="form-row">
                      <tag:formField2Col id="name" name="Financial institution name" path="ddinstitution" dimension="medium"
                        mand="true" maxlength="25" />
                    </div>
                    <div class="form-row">
                      <tag:formField2Col id="address1" name="Branch Address" path="ddinstitutionaddress" dimension="medium"
                        mand="true" maxlength="48" />
                    </div>
                    <div class="form-row last-row">
                      <tag:formField2Col id="suburb" name="Branch Suburb" path="ddinstitutionsuburb" dimension="medium"
                        mand="true" maxlength="25" />
                    </div>
                  </div>
                  <div class="second-column">
                    <div class="form-row">
                      <tag:formField2Col id="postcode" name="Branch Postcode" path="ddinstitutionpostcode" dimension="veryShort"
                        mand="true" maxlength="4" />
                    </div>
                    <div class="form-row last-row">
                      <tag:formStates id="state" name="Branch State" path="ddinstitutionstate" list="states" />
                    </div>
                  </div>
                </div>
              </div>
            
              <hr class="clear"/>
              
              <h2>Distributions</h2>
  
              <p>
                In the event that a cash distribution becomes payable by the Fund, please select what
                your client would like to happen to the cash distribution :
              </p>
              
              <div class="form-group">
                <div class="two-columns">
                  <div class="first-column">
                    <div class="form-row last-row">
                      <tag:formInlineCheckBox name="Reinvest distributions with HFA Octane Global Fund"
                            path="reinvestdistribution" />
                    </div>
                  </div>
                  <div class="second-column">
                    <div class="form-row last-row">
                      <tag:formInlineCheckBox name="Direct credit distributions to the account listed above"
                            path="directcreditdistribution" />
                    </div>
                  </div>
                </div>
              </div>
            </c:if>
            
            <hr class="clear"/>
            
            <c:if test="${application.product.directCreditRequired}">
              <h1>Direct Credit Details</h1>
              
              <div class="messages">
                <p>
                  The following bank account details are to be used for all future payments due to the paid to the investor.
                </p>
              </div>
            
              <p class="foot-note">
                An amount sufficient to cover the total payment obligations must be in the specified account by no later than
                <strong>15th June 2007</strong>.
              </p>
              <p class="foot-note">
                Please note that you cannot supply a third party bank account. The bank account below must be in the name of the
                investor(s) making this application.
              </p>
        
              <h2>Client Account Details</h2>
              
              <div class="form-group">
                <div class="two-columns">
                  <div class="first-column">
                    <div class="form-row">
                      <tag:formField2Col id="directCreditDetails.bsb" name="BSB Number" path="directCreditDetails.bsb" dimension="short" mand="true" onblur="fillDirectCreditInstitution('${applicationid}')"/>
                    </div>
                    <div class="form-row last-row">
                      <tag:formField2Col id="directCreditDetails.accountName" name="Name of Account" path="directCreditDetails.accountName" dimension="medium" mand="true" maxlength="80" />
                    </div>
                  </div>
                  <div class="second-column">
                    <div class="form-row">
                      <tag:formField2Col id="directCreditDetails.accountType" name="Account Type" path="directCreditDetails.accountType" dimension="short" mand="true"/>
                    </div>
                    <div class="form-row last-row">
                      <tag:formField2Col id="directCreditDetails.accountNumber" name="A/C Number" path="directCreditDetails.accountNumber" dimension="short" mand="true" maxlength="10" />
                    </div>
                  </div>
                </div>
              </div>
            
              <hr class="clear"/>
              
              <h2>Financial Institution Details</h2>

<%--  
"ddinstitution", "Financial Institution Name");
"ddinstitutionaddress", "Branch Address");
"ddinstitutionsuburb", "Branch Suburb");
"ddinstitutionpostcode", "Branch Postcode");
"ddinstitutionpostcode", application
"ddinstitutionsuburb", "Branch State");
"ddaccountname", "Name of Account");
"ddbsb", "BSB");
"ddaccountno", "A/C Number");
 --%>                
              <div class="form-group">
                <div class="two-columns">
                  <div class="first-column">
                    <div class="form-row">
                      <tag:formField2Col id="directCreditDetails.institution" name="Financial institution name" path="directCreditDetails.institution" dimension="medium"
                        mand="true" maxlength="25" />
                    </div>
                    <div class="form-row">
                      <tag:formField2Col id="directCreditDetails.institutionAddress" name="Branch Address" path="directCreditDetails.institutionAddress" dimension="medium"
                        mand="true" maxlength="48" />
                    </div>
                    <div class="form-row last-row">
                      <tag:formField2Col id="directCreditDetails.institutionSuburb" name="Branch Suburb" path="directCreditDetails.institutionSuburb" dimension="medium"
                        mand="true" maxlength="25" />
                    </div>
                  </div>
                  <div class="second-column">
                    <div class="form-row">
                      <tag:formField2Col id="directCreditDetails.institutionPostcode" name="Branch Postcode" path="directCreditDetails.institutionPostcode" dimension="veryShort"
                        mand="true" maxlength="4" />
                    </div>
                    <div class="form-row last-row">
                      <tag:formStates id="directCreditDetails.institutionState" name="Branch State" path="directCreditDetails.institutionState" list="states" />
                    </div>
                  </div>
                </div>
              </div>
            </c:if>        

            <p class="foot-note"><span style="color: red;">#</span> Denotes a Mandatory Field</p>
            
            <hr class="clear"/>
            
            <div class="button-row">
              <input type="submit" name="proceed" class="button" value="Proceed"/>
              <input type="submit" name="save" class="button attached" value="Save and Return"/>
              <button type="button" class="button attached" onclick="cancel();">Cancel</button>
  
              <br class="clear"/>
            </div>
          </spring:nestedPath>
        </form:form>
        
      </div>
      
      <jsp:include flush="true" page="/WEB-INF/jsp/includes/footer.jsp"/>

    </div>
  </body>
</html>
