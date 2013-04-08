<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt1" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
  <head>
    <title>OPI - Additional Guarantors</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
  
    <jsp:include flush="true" page="/WEB-INF/jsp/includes/scripts_and_styles.jsp"/>
    
    <script type="text/javascript">
      <!-- //
        
        function onLoad() {
          // select checkboxes, radio buttons, etc.
          <c:choose>
            <c:when test="${additionalGuarantor.id != -1}">
              document.getElementById("investorIndividualId${additionalGuarantor.id}").checked = true;
              <c:if test="${additionalGuarantor.role eq 'Guarantor'}">
                onSelectExternalGuarantor();
              </c:if>
              <c:if test="${additionalGuarantor.role ne 'Guarantor'}">
                onSelectInternalGuarantor();
              </c:if>
            </c:when>
            <c:otherwise>
              document.getElementById("investorIndividualIdNew").checked = true;
            </c:otherwise>
          </c:choose>
        }
        
        function cancel() {
          if (confirm("Abandon changes made on this page?")) {
            document.location.href = '${startpage}';
          }
        }
        
        /**
         * If the "Net assets" amount and the "Net income available" amount are
         * 0 then we need to show a confirmation message.
         * 
         * @return true If one of the amounts has a value, or if the user decides
         *         to proceed anyway.
         */
        function validate() {
          var netAssets = document.getElementById("netAssets").value;
          var netIncomeAvailable = document.getElementById("incomeAvailable").value;
      
          var okToProceed;    
          if (netAssets == "0" && netIncomeAvailable == "0") {
            okToProceed = confirm("Has all financial information (income, expenses, assets and liabilities) been provided?");
          } else {
            okToProceed = true;
          }
          
          return okToProceed;
        }
        
        /**
         * Gets called when an internal guarantor is chosen.  Populates 
         * personal details of the chosen individual and disables fields
         * from being updated.
         */
        function onSelectInternalGuarantor() {
          document.getElementById("externalGuarantorPrivateDetails").style.display = "none";
          document.getElementById("enterDetailsMessage").style.visibility = "hidden";
          
        }
        
        function onSelectExternalGuarantor() {
          document.getElementById("externalGuarantorPrivateDetails").style.display = "block";
          document.getElementById("enterDetailsMessage").style.visibility = "visible";
          
        }
        
        function totalAssets() {
          totalFields (document.getElementById('assetsTotal'), 
                       document.getElementById('cash'), 
                       document.getElementById('shares'),
                       document.getElementById('otherLiquid'),
                       document.getElementById('residentialProperty'),
                       document.getElementById('investmentProperty'),
                       document.getElementById('otherassets'));
        }
        
        function totalNetAssets() {
          totalFields (document.getElementById('netAssets'), 
                       document.getElementById('assetsTotal'), 
                       '-',
                       document.getElementById('liabilitiesTotal'));
        }
        
        function totalLiabilities() {
          totalFields (document.getElementById('liabilitiesTotal'), 
                       document.getElementById('otherLoansSecured'), 
                       document.getElementById('loansResProperty'),
                       document.getElementById('loansInvProperty'),
                       document.getElementById('loansPersonalUnse'),
                       document.getElementById('guaranteesGranted'),
                       document.getElementById('otherLiabilities'));
        }
        
        function totalGrossIncome() {
          totalFields (document.getElementById('incomeTotal'), 
                       document.getElementById('salary'), 
                       document.getElementById('rentalAndDividend'),
                       document.getElementById('otherIncome'));
        }
        
        function totalAfterTaxIncome() {
          totalFields (document.getElementById('afterTaxTotal'), 
                       document.getElementById('incomeTotal'), 
                       '-',
                       document.getElementById('taxPayable'));
        }
        
  
        function totalExpenditure() {
          totalFields (document.getElementById('expenditureTotal'), 
                       document.getElementById('intSecuredLoans'), 
                       document.getElementById('intUnsecuredLoans'), 
                       document.getElementById('livingExpenses'), 
                       document.getElementById('otherExpenses'));
        }
        
        function totalNetIncomeAvailable() {
          totalFields (document.getElementById('incomeAvailable'), 
                       document.getElementById('afterTaxTotal'), 
                       '-', 
                       document.getElementById('expenditureTotal'));
        }
      
      // -->
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
        
        <h1>Additional Guarantors</h1>
        
        <jsp:include flush="true" page="/WEB-INF/jsp/includes/errors_and_messages.jsp"/>
        <%-- enable this sometime with new section inside formField2Col.tag too..
        <spring:hasBindErrors name="additionalGuarantor">
          <div class="errors" style="padding: 5px 10px; margin-bottom: 15px; border: 1px solid #C30B0B; background: #EBEBEB; line-height: 17px;">
            <p style="color: #E92121; font-weight: bold;">
              Please complete the following :
            </p>
            <ul style="margin-left: 20px; padding-bottom: 10px;">
              <c:if test="${not empty errors.fieldErrors}"> 
                <c:forEach var="globalError" items="${errors.globalErrors}">
                  <li style="color: #E92121; font-weight: bold;">
                    <spring:message arguments="${globalError.arguments}" code="${globalError.code}" text="${globalError.defaultMessage}" />
                  </li>
                </c:forEach>
              </c:if>
              <c:if test="${not empty errors.fieldErrors}"> 
                <li style="color: #E92121; font-weight: bold;">
                  Please correct all field errors below highlighted in red.
                </li>
              </c:if>
            </ul>
          </div>
        </spring:hasBindErrors>
        --%>
        
        <form:form id="guarantorsForm" name="guarantorsForm">
          <h2>Guarantor's Information</h2>
          
          <spring:nestedPath path="additionalGuarantor">
            <div class="form-group">
              <h3>Select Additional Guarantor</h3>
                  
              <c:forEach var="investorIndividual" items="${elegibleInvestorIndividuals}" varStatus="investorIndividualStatus">
                <div class="form-row">
                  <spring:bind path="id">
                    <input type="radio" name="${status.expression}" 
                                        value="${investorIndividual.id}" 
                                        class="auto" 
                                        id="investorIndividualId${investorIndividual.id}" 
                                        onclick="onSelectInternalGuarantor();"/>
                    <label class="auto">${investorIndividual.individual.fullname} (${investorIndividual.role})</label>
                    
                    <br class="clear"/>
                  </spring:bind>
                </div>
              </c:forEach>
              
              <c:choose>
              <c:when test="${!hasExternalGuarantor}">
                <div class="form-row last-row">
                  <spring:bind path="id">
                    <input type="radio" name="${status.expression}" 
                                        value="-1" 
                                        class="auto" 
                                        id="investorIndividualIdNew"
                                        onclick="onSelectExternalGuarantor();"/>
                    <label class="auto">New External Guarantor <span id="enterDetailsMessage">(Enter details below)</span></label>
                    
                    <br class="clear"/>
                  </spring:bind>
                </div>
              </c:when>
              <c:otherwise>
                <div class="form-row last-row">
                  <spring:bind path="id">
                    <input type="radio" name="${status.expression}" 
                                        value="${additionalGuarantor.id}" 
                                        class="auto" 
                                        id="investorIndividualId${additionalGuarantor.id}"
                                        onclick="onSelectExternalGuarantor();"/>
                    <label class="auto">${additionalGuarantor.individual.fullname} <span id="enterDetailsMessage">(External Guarantor)</span></label>
                    
                    <br class="clear"/>
                  </spring:bind>
                </div>
              </c:otherwise>
              </c:choose>
            </div>
          </spring:nestedPath>
          
          <div id="externalGuarantorPrivateDetails">

            <spring:nestedPath path="additionalGuarantor">
              <tag:individual 
                title="External Guarantor's Details"
                formid="guarantorsForm" 
                role="testRole"
                director="false"
                trust="false"
                apptype="0"
                formname="guarantorsForm"
                index="0"/>
            </spring:nestedPath>
            
            <p class="foot-note"><span style="color: red;">#</span> Denotes a Mandatory Field</p>
          </div>

          <spring:nestedPath path="additionalGuarantor.financialInformation">
            <h2>Guarantor - Assets and Liabilities</h2>
            
            <div class="form-group">
              <div class="two-columns">
                <div class="first-column">
                  <h3>Assets</h3>
                  
                  <div class="form-row">
                    <tag:formTextBox name="Cash" path="cash" dimension="medium" dollar="true" 
                      onblur="onchange ()"
                      onchange="totalAssets();" />
                  </div>
                  <div class="form-row">
                    <tag:formTextBox name="Shares" path="shares" dimension="medium" dollar="true"
                      onblur="onchange ()"
                      onchange="totalAssets();" />
                  </div>
                  <div class="form-row">
                    <tag:formTextBox name="Managed funds and other liquid investments" path="otherLiquid"
                      dimension="medium" dollar="true" onblur="onchange ()"
                      onchange="totalAssets();" />
                  </div>
                  <div class="form-row">
                    <tag:formTextBox name="Residential property" path="residentialProperty" dimension="medium"
                      dollar="true" onblur="onchange ()"
                      onchange="totalAssets();" />
                  </div>
                  <div class="form-row">
                    <tag:formTextBox name="Investment property" path="investmentProperty" dimension="medium"
                      dollar="true" onblur="onchange ()"
                      onchange="totalAssets();" />
                  </div>
                  <div class="form-row">
                    <tag:formTextBox name="Other assets" path="otherassets" dimension="medium" dollar="true"
                      onblur="onchange ()"
                      onchange="totalAssets();" />
                  </div>
                  <div class="form-row">
                    <tag:formTextBox name="Please specify" path="otherassetsDetails" space="true"
                      dimension="medium" maxlength="50" />
                  </div>
                  <div class="form-row last-row">
                    <tag:formField2ColValText name="Total assets" path="assetsTotal" dimension="short"
                      dollar="true" disabled="true" onblur="onchange ()"
                      onchange="totalNetAssets();" bold="true" />
                  </div>
                </div>
                <div class="second-column">
                  <h3>Liabilities</h3>
                  
                  <div class="form-row">
                    <tag:formTextBox name="Loans secured against shares and managed funds"
                      path="otherLoansSecured" dimension="medium" dollar="true" onblur="onchange ()"
                      onchange="totalLiabilities();" />
                  </div>
                  <div class="form-row">
                    <tag:formTextBox name="Loans secured against residential property"
                      path="loansResProperty" dimension="medium" dollar="true" onblur="onchange ()"
                      onchange="totalLiabilities();" />
                  </div>
                  <div class="form-row">
                    <tag:formTextBox name="Loans secured against investment property"
                      path="loansInvProperty" dimension="medium" dollar="true" onblur="onchange ()"
                      onchange="totalLiabilities();" />
                  </div>
                  <div class="form-row">
                    <tag:formTextBox name="Personal unsecured loans (e.g. leases, credit cards)"
                      path="loansPersonalUnse" dimension="medium" dollar="true" onblur="onchange ()"
                      onchange="totalLiabilities();" />
                  </div>
                  <div class="form-row">
                    <tag:formTextBox name="Guarantees granted" path="guaranteesGranted" dimension="medium"
                      dollar="true" onblur="onchange ()"
                      onchange="totalLiabilities();" />
                  </div>
                  <div class="form-row">
                    <tag:formTextBox name="Other liabilities" path="otherLiabilities" dimension="medium"
                      dollar="true" onblur="onchange ()"
                      onchange="totalLiabilities();" />
                  </div>
                  <div class="form-row">
                    <tag:formTextBox name="Please specify" path="otherLiabilitiesDetails" space="true"
                      dimension="medium" maxlength="50" />
                  </div>
                  <div class="form-row">
                    <tag:formField2ColValText name="Total liabilities" path="liabilitiesTotal" dimension="short"
                      dollar="true" disabled="true" onblur="onchange ()"
                      onchange="totalNetAssets();" bold="true" />
                  </div>
                  <div class="form-row last-row">
                    <tag:formField2ColValText name="Net assets" path="netAssets" dimension="short" dollar="true"
                      disabled="true" bold="true" />
                  </div>
                </div>
              </div>
            </div>
            
            <hr class="clear"/>
            
            <h2>Guarantor - Income and Expenditure</h2>
            
            <div class="form-group">
              <div class="two-columns">
                <div class="first-column">
                  <h3>Annual Income</h3>
                  
                  <div class="form-row">
                    <tag:formTextBox name="Gross salary" path="salary" dimension="medium" dollar="true"
                      onblur="onchange ()"
                      onchange="totalGrossIncome();" />
                  </div>
                  <div class="form-row">
                    <tag:formTextBox name="Rental and dividend income" path="rentalAndDividend"
                      dimension="medium" dollar="true" onblur="onchange ()"
                      onchange="totalGrossIncome();" />
                  </div>
                  <div class="form-row">
                    <tag:formTextBox name="Other income" path="otherIncome" dimension="medium" dollar="true"
                      onblur="onchange ()"
                      onchange="totalGrossIncome();" />
                  </div>
                  <div class="form-row">
                    <tag:formTextBox name="Please specify" path="otherIncomeDetails" space="true"
                      dimension="medium" maxlength="50" />
                  </div>
                  <div class="form-row">
                    <tag:formField2ColValText name="Total gross income" path="incomeTotal" dimension="short"
                      dollar="true" disabled="true" onblur="onchange ()"
                      onchange="totalAfterTaxIncome();" bold="true" />
                  </div>
                  <div class="form-row">
                    <tag:formTextBox name="Tax payable" path="taxPayable" dimension="medium" dollar="true"
                      onblur="onchange ()" onchange="totalAfterTaxIncome();" />
                  </div>
                  <div class="form-row">
                    <tag:formTextBox name="Tax payable date" path="taxPayableDate" space="true" formname="guarantorsForm"
                      dimension="short" isdate="true" bold="true" />
                  </div>
                  <div class="form-row last-row">
                    <tag:formField2ColValText name="Total after-tax income" path="afterTaxTotal"
                      dimension="short" dollar="true" disabled="true" onblur="onchange ()"
                      onchange="totalNetIncomeAvailable();" bold="true" />
                  </div>
                </div>
                <div class="second-column">
                  <h3>Expenditure</h3>
                  
                  <div class="form-row">
                    <tag:formTextBox name="Mortgage and interest payments on secured loans"
                      path="intSecuredLoans" dimension="medium" dollar="true" onblur="onchange ()"
                      onchange="totalExpenditure();" />
                  </div>
                  <div class="form-row">
                    <tag:formTextBox name="Interest payments on unsecured loans"
                      path="intUnsecuredLoans" dimension="medium" dollar="true" onblur="onchange ()"
                      onchange="totalExpenditure();" />
                  </div>
                  <div class="form-row">
                    <tag:formTextBox name="Living expenses and school fees" path="livingExpenses"
                      dimension="medium" dollar="true" onblur="onchange ()"
                      onchange="totalExpenditure();" />
                  </div>
                  <div class="form-row">
                    <tag:formTextBox name="Other expenses" path="otherExpenses" dimension="medium"
                      dollar="true" onblur="onchange ()"
                      onchange="totalExpenditure();" />
                  </div>
                  <div class="form-row">
                    <tag:formTextBox name="Please specify" path="otherExpensesDetails" space="true"
                      dimension="medium" maxlength="50" />
                  </div>
                  <div class="form-row">
                    <tag:formField2ColValText name="Total expenditure" path="expenditureTotal" dimension="short"
                      dollar="true" disabled="true" onblur="onchange ()"
                      onchange="totalNetIncomeAvailable();" bold="true" />
                  </div>
                  <div class="form-row last-row">
                    <tag:formField2ColValText name="Net income available" path="incomeAvailable"
                      dimension="short" dollar="true" disabled="true" bold="true" />
                  </div>
                </div>
              </div>
            </div>
          </spring:nestedPath>

          
          <div class="button-row">
            <input type="submit" name="proceed" class="button" onclick="return validate();" value="Proceed"/>
            <input type="submit" name="save" class="button attached" value="Save and Return"/>
            <button type="button" class="button attached" onclick="cancel();">Cancel</button>

            <br class="clear"/>
          </div>
        </form:form>
        
      </div>
      
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
      
      <%@ include file="/WEB-INF/jsp/includes/footer.jsp" %>

    </div>
  </body>
</html>
