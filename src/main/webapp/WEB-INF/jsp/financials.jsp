<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt1" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
  <head>
    <title>OPI - Financial Details</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
  
    <jsp:include flush="true" page="/WEB-INF/jsp/includes/scripts_and_styles.jsp"/>
    
    <script type="text/javascript">
      <!-- //
        /**
         * If the "Net assets" amount and the "Net income available" amount are
         * 0 then we need to show a confirmation message.
         * 
         * @return true If one of the amounts has a value, or if the user decides
         *         to proceed anyway.
         */
        function validate() {
          var netAssets = document.getElementById("inettassets").value;
          var netIncomeAvailable = document.getElementById("iincomeavailable").value;
      
          var okToProceed;    
          if (netAssets == "0" && netIncomeAvailable == "0") {
            okToProceed = confirm("Has all financial information (income, expenses, assets and liabilities) been provided?");
          } else {
            okToProceed = true;
          }
          
          return okToProceed;
        }
        
        /**
         * If the user deselects additional guarantor and one exists.
         *
         */
        function confirmDisable() {
          <c:if test="${application.hasAdditionalGuarantor}">
            var okToDeselect;
            if (!document.getElementById("additionalGuarantors").checked) {
              okToDeselect = confirm("Additional guarantors already exist for this application.  Deselecting this checkbox will delete them.  Are you sure?");
              if (!okToDeselect) {
                document.getElementById("additionalGuarantors").checked = true;
              }
            }
            
            
          </c:if>
        }
        
        function onLoad() {
          <c:if test="${application.hasAdditionalGuarantor}">
            document.getElementById("additionalGuarantors").checked = true;
          </c:if>
        }
        
        function cancel() {
          if (confirm("Abandon changes made on this page?")) {
            document.location.href = '${startpage}';
          }
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
        
        <h1>Financial Details</h1>
        
        <jsp:include flush="true" page="/WEB-INF/jsp/includes/errors_and_messages.jsp"/>

        <div class="messages">
          <p>
            To enable UBS Australia to make an assessment of your client's Loan application, please provide:
            <br/>
            a) a copy of the most recent payslip or tax return for the applicant and the guarantor (if applicable); and
            <br/>
            b) the following information in respect of the applicant and the guarantor (if applicable).
          </p>
          <p>
            Financial data should be provided by reference to the applicant's current status, without including the Loan
            and/or Put Option being applied for in this application.
          </p>
          <c:if test="${application.type == 0}">
            <p>
              Applicant's asset and income details. In the case of joint applicants, please provide aggregate asset and income
              information. In the case of a company or trust application, please provide asset and income information for the
              company or the trust respectively
            </p>
          </c:if>
        </div>
        
        <form:form id="financialsForm">
          <spring:nestedPath path="application">
            <h2>Applicants - Assets and Liabilities</h2>
            
            <div class="form-group">
              <div class="two-columns">
                <div class="first-column">
                  <h3>Assets</h3>
                  
                  <div class="form-row">
                    <tag:formField2Col name="Cash" path="icash" dimension="medium" dollar="true"
                      onblur="onchange ()"
                      onchange="totalFields (iassetstotal, icash, ishares, iotherliquid, iresidentialproperty, iinvestmentproperty, iotherassets)" />
                  </div>
                  <div class="form-row">
                    <tag:formField2Col name="Shares" path="ishares" dimension="medium" dollar="true"
                      onblur="onchange ()"
                      onchange="totalFields (iassetstotal, icash, ishares, iotherliquid, iresidentialproperty, iinvestmentproperty, iotherassets)" />
                  </div>
                  <div class="form-row">
                    <tag:formField2Col name="Managed funds and other liquid investments" path="iotherliquid"
                      dimension="medium" dollar="true" onblur="onchange ()"
                      onchange="totalFields (iassetstotal, icash, ishares, iotherliquid, iresidentialproperty, iinvestmentproperty, iotherassets)" />
                  </div>
                  <div class="form-row">
                    <tag:formField2Col name="Residential property" path="iresidentialproperty" dimension="medium"
                      dollar="true" onblur="onchange ()"
                      onchange="totalFields (iassetstotal, icash, ishares, iotherliquid, iresidentialproperty, iinvestmentproperty, iotherassets)" />
                  </div>
                  <div class="form-row">
                    <tag:formField2Col name="Investment property" path="iinvestmentproperty" dimension="medium"
                      dollar="true" onblur="onchange ()"
                      onchange="totalFields (iassetstotal, icash, ishares, iotherliquid, iresidentialproperty, iinvestmentproperty, iotherassets)" />
                  </div>
                  <div class="form-row">
                    <tag:formField2Col name="Other assets" path="iotherassets" dimension="medium" dollar="true"
                      onblur="onchange ()"
                      onchange="totalFields (iassetstotal, icash, ishares, iotherliquid, iresidentialproperty, iinvestmentproperty, iotherassets)" />
                  </div>
                  <div class="form-row">
                    <tag:formField2Col name="Please specify" path="iotherassetsdetails" space="true"
                      dimension="medium" maxlength="50" />
                  </div>
                  <div class="form-row last-row">
                    <tag:formField2ColValText name="Total assets" path="iassetstotal" dimension="short"
                      dollar="true" disabled="true" onblur="onchange ()"
                      onchange="totalFields (inettassets, iassetstotal, '-', iliabilitiestotal)" bold="true"/>
                  </div>
                </div>
                <div class="second-column">
                  <h3>Liabilities</h3>
                    
                  <div class="form-row">
                    <tag:formField2Col name="Loans secured against shares and managed funds"
                      path="iotherloanssecured" dimension="medium" dollar="true" onblur="onchange ()"
                      onchange="totalFields (iliabilitiestotal, iotherloanssecured, iloansresidentialproperty, iloansinvestmentproperty, iloanspersonalunsecured, iguaranteesgranted, iotherliabilities)" />
                  </div>
                  <div class="form-row">
                    <tag:formField2Col name="Loans secured against residential property"
                      path="iloansresidentialproperty" dimension="medium" dollar="true" onblur="onchange ()"
                      onchange="totalFields (iliabilitiestotal, iotherloanssecured, iloansresidentialproperty, iloansinvestmentproperty, iloanspersonalunsecured, iguaranteesgranted, iotherliabilities)" />
                  </div>
                  <div class="form-row">
                    <tag:formField2Col name="Loans secured against investment property"
                      path="iloansinvestmentproperty" dimension="medium" dollar="true" onblur="onchange ()"
                      onchange="totalFields (iliabilitiestotal, iotherloanssecured, iloansresidentialproperty, iloansinvestmentproperty, iloanspersonalunsecured, iguaranteesgranted, iotherliabilities)" />
                  </div>
                  <div class="form-row">
                    <tag:formField2Col name="Personal unsecured loans (e.g. leases, credit cards)"
                      path="iloanspersonalunsecured" dimension="medium" dollar="true" onblur="onchange ()"
                      onchange="totalFields (iliabilitiestotal, iotherloanssecured, iloansresidentialproperty, iloansinvestmentproperty, iloanspersonalunsecured, iguaranteesgranted, iotherliabilities)" />
                  </div>
                  <div class="form-row">
                    <tag:formField2Col name="Guarantees granted" path="iguaranteesgranted" dimension="medium"
                      dollar="true" onblur="onchange ()"
                      onchange="totalFields (iliabilitiestotal, iotherloanssecured, iloansresidentialproperty, iloansinvestmentproperty, iloanspersonalunsecured, iguaranteesgranted, iotherliabilities)" />
                  </div>
                  <div class="form-row">
                    <tag:formField2Col name="Other liabilities" path="iotherliabilities" dimension="medium"
                      dollar="true" onblur="onchange ()"
                      onchange="totalFields (iliabilitiestotal, iotherloanssecured, iloansresidentialproperty, iloansinvestmentproperty, iloanspersonalunsecured, iguaranteesgranted, iotherliabilities)" />
                  </div>
                  <div class="form-row">
                    <tag:formField2Col name="Please specify" path="iotherliabilitiesdetails" space="true"
                      dimension="medium" maxlength="50" />
                  </div>
                  <div class="form-row">
                    <tag:formField2ColValText name="Total liabilities" path="iliabilitiestotal" dimension="short"
                      dollar="true" disabled="true" onblur="onchange ()"
                      onchange="totalFields (inettassets, iassetstotal, '-', iliabilitiestotal)"  bold="true"/>
                  </div>
                  <div class="form-row last-row">
                    <tag:formField2ColValText name="Net assets" path="inettassets" dimension="short" dollar="true"
                      disabled="true" id="inettassets"  bold="true"/>
                  </div>
                </div>
              </div>
            </div>
            
            <hr class="clear"/>
            
            <h2>Applicants - Income and Expenditure</h2>
            
            <div class="form-group">
              <div class="two-columns">
                <div class="first-column">
                  <h3>Annual Income</h3>
                  
                  <div class="form-row">
                    <tag:formField2Col name="Gross salary" path="isalary" dimension="medium" dollar="true"
                      onblur="onchange ()"
                      onchange="totalFields (iincometotal, isalary, irentalanddividend, iotherincome)" />
                  </div>
                  <div class="form-row">
                    <tag:formField2Col name="Rental and dividend income" path="irentalanddividend"
                      dimension="medium" dollar="true" onblur="onchange ()"
                      onchange="totalFields (iincometotal, isalary, irentalanddividend, iotherincome)" />
                  </div>
                  <div class="form-row">
                    <tag:formField2Col name="Other income" path="iotherincome" dimension="medium" dollar="true"
                      onblur="onchange ()"
                      onchange="totalFields (iincometotal, isalary, irentalanddividend, iotherincome)" />
                  </div>
                  <div class="form-row">
                    <tag:formField2Col name="Please specify" path="iotherincomedetails" space="true"
                      dimension="medium" maxlength="50" />
                  </div>
                  <div class="form-row">
                    <tag:formField2ColValText name="Total gross income" path="iincometotal" dimension="short"
                      dollar="true" disabled="true" onblur="onchange ()"
                      onchange="totalFields (iaftertaxtotal, iincometotal, '-', itaxpayable)" bold="true"/>
                  </div>
                  <div class="form-row">
                    <tag:formField2Col name="Tax payable" path="itaxpayable" dimension="medium" dollar="true"
                      onblur="onchange ()" onchange="totalFields (iaftertaxtotal, iincometotal, '-', itaxpayable)" />
                  </div>
                  <div class="form-row">
                    <tag:formField2Col name="Tax payable date" path="itaxpayabledate" space="true"
                      dimension="medium" isdate="true" bold="true" />
                  </div>
                  <div class="form-row last-row">
                    <tag:formField2ColValText name="Total after-tax income" path="iaftertaxtotal" dimension="short"
                      dollar="true" disabled="true" onblur="onchange ()"
                      onchange="totalFields (iincomeavailable, iaftertaxtotal, '-', iexpendituretotal)" bold="true" />
                  </div>
                </div>
                <div class="second-column">
                  <h3>Annual Expenditure</h3>
                  
                  <div class="form-row">
                    <tag:formField2Col name="Mortgage and interest payments on secured loans"
                      path="iinterestonsecuredloans" dimension="medium" dollar="true" onblur="onchange ()"
                      onchange="totalFields (iexpendituretotal, iinterestonsecuredloans, iinterestonunsecuredloans, ilivingexpenses, iotherexpenses)" />
                  </div>
                  <div class="form-row">
                    <tag:formField2Col name="Interest payments on unsecured loans" path="iinterestonunsecuredloans"
                      dimension="medium" dollar="true" onblur="onchange ()"
                      onchange="totalFields (iexpendituretotal, iinterestonsecuredloans, iinterestonunsecuredloans, ilivingexpenses, iotherexpenses)" />
                  </div>
                  <div class="form-row">
                    <tag:formField2Col name="Living expenses and school fees" path="ilivingexpenses"
                      dimension="medium" dollar="true" onblur="onchange ()"
                      onchange="totalFields (iexpendituretotal, iinterestonsecuredloans, iinterestonunsecuredloans, ilivingexpenses, iotherexpenses)" />
                  </div>
                  <div class="form-row">
                    <tag:formField2Col name="Other expenses" path="iotherexpenses" dimension="medium" dollar="true"
                      onblur="onchange ()"
                      onchange="totalFields (iexpendituretotal, iinterestonsecuredloans, iinterestonunsecuredloans, ilivingexpenses, iotherexpenses)" />
                  </div>
                  <div class="form-row">
                    <tag:formField2Col name="Please specify" path="iotherexpensesdetails" space="true"
                      dimension="medium" maxlength="50" />
                  </div>
                  <div class="form-row">
                    <tag:formField2ColValText name="Total expenditure" path="iexpendituretotal" dimension="short"
                      dollar="true" disabled="true" onblur="onchange ()"
                      onchange="totalFields (iincomeavailable, iaftertaxtotal, '-', iexpendituretotal)" bold="true" />
                  </div>
                  <div class="form-row last-row">
                    <tag:formField2ColValText name="Net income available" path="iincomeavailable" dimension="short"
                      dollar="true" disabled="true" id="iincomeavailable" bold="true"/>
                  </div>
                </div>
              </div>
            </div>
            
            <c:if test="${!empty application.company}">
              <hr class="clear"/>
            
              <h2>Guarantors - Assets and Liabilities</h2>
              
              <div class="form-group">
                <div class="two-columns">
                  <div class="first-column">
                    <h3>Assets</h3>
                    
                    <div class="form-row">
                      <tag:formField2Col name="Cash" path="gcash" dimension="medium" dollar="true"
                        onblur="onchange ()"
                        onchange="totalFields (gassetstotal, gcash, gshares, gotherliquid, gresidentialproperty, ginvestmentproperty, gotherassets)" />
                    </div>
                    <div class="form-row">
                      <tag:formField2Col name="Shares" path="gshares" dimension="medium" dollar="true"
                        onblur="onchange ()"
                        onchange="totalFields (gassetstotal, gcash, gshares, gotherliquid, gresidentialproperty, ginvestmentproperty, gotherassets)" />
                    </div>
                    <div class="form-row">
                      <tag:formField2Col name="Managed funds and other liquid investments" path="gotherliquid"
                        dimension="medium" dollar="true" onblur="onchange ()"
                        onchange="totalFields (gassetstotal, gcash, gshares, gotherliquid, gresidentialproperty, ginvestmentproperty, gotherassets)" />
                    </div>
                    <div class="form-row">
                      <tag:formField2Col name="Residential property" path="gresidentialproperty" dimension="medium"
                        dollar="true" onblur="onchange ()"
                        onchange="totalFields (gassetstotal, gcash, gshares, gotherliquid, gresidentialproperty, ginvestmentproperty, gotherassets)" />
                    </div>
                    <div class="form-row">
                      <tag:formField2Col name="Investment property" path="ginvestmentproperty" dimension="medium"
                        dollar="true" onblur="onchange ()"
                        onchange="totalFields (gassetstotal, gcash, gshares, gotherliquid, gresidentialproperty, ginvestmentproperty, gotherassets)" />
                    </div>
                    <div class="form-row">
                      <tag:formField2Col name="Other assets" path="gotherassets" dimension="medium" dollar="true"
                        onblur="onchange ()"
                        onchange="totalFields (gassetstotal, gcash, gshares, gotherliquid, gresidentialproperty, ginvestmentproperty, gotherassets)" />
                    </div>
                    <div class="form-row">
                      <tag:formField2Col name="Please specify" path="gotherassetsdetails" space="true"
                        dimension="medium" maxlength="50" />
                    </div>
                    <div class="form-row last-row">
                      <tag:formField2ColValText name="Total assets" path="gassetstotal" dimension="short"
                        dollar="true" disabled="true" onblur="onchange ()"
                        onchange="totalFields (gnettassets, gassetstotal, '-', gliabilitiestotal)" bold="true" />
                    </div>
                  </div>
                  <div class="second-column">
                    <h3>Liabilities</h3>
                    
                    <div class="form-row">
                      <tag:formField2Col name="Loans secured against shares and managed funds"
                        path="gotherloanssecured" dimension="medium" dollar="true" onblur="onchange ()"
                        onchange="totalFields (gliabilitiestotal, gotherloanssecured, gloansresidentialproperty, gloansinvestmentproperty, gloanspersonalunsecured, gguaranteesgranted, gotherliabilities)" />
                    </div>
                    <div class="form-row">
                      <tag:formField2Col name="Loans secured against residential property"
                        path="gloansresidentialproperty" dimension="medium" dollar="true" onblur="onchange ()"
                        onchange="totalFields (gliabilitiestotal, gotherloanssecured, gloansresidentialproperty, gloansinvestmentproperty, gloanspersonalunsecured, gguaranteesgranted, gotherliabilities)" />
                    </div>
                    <div class="form-row">
                      <tag:formField2Col name="Loans secured against investment property"
                        path="gloansinvestmentproperty" dimension="medium" dollar="true" onblur="onchange ()"
                        onchange="totalFields (gliabilitiestotal, gotherloanssecured, gloansresidentialproperty, gloansinvestmentproperty, gloanspersonalunsecured, gguaranteesgranted, gotherliabilities)" />
                    </div>
                    <div class="form-row">
                      <tag:formField2Col name="Personal unsecured loans (e.g. leases, credit cards)"
                        path="gloanspersonalunsecured" dimension="medium" dollar="true" onblur="onchange ()"
                        onchange="totalFields (gliabilitiestotal, gotherloanssecured, gloansresidentialproperty, gloansinvestmentproperty, gloanspersonalunsecured, gguaranteesgranted, gotherliabilities)" />
                    </div>
                    <div class="form-row">
                      <tag:formField2Col name="Guarantees granted" path="gguaranteesgranted" dimension="medium"
                        dollar="true" onblur="onchange ()"
                        onchange="totalFields (gliabilitiestotal, gotherloanssecured, gloansresidentialproperty, gloansinvestmentproperty, gloanspersonalunsecured, gguaranteesgranted, gotherliabilities)" />
                    </div>
                    <div class="form-row">
                      <tag:formField2Col name="Other liabilities" path="gotherliabilities" dimension="medium"
                        dollar="true" onblur="onchange ()"
                        onchange="totalFields (gliabilitiestotal, gotherloanssecured, gloansresidentialproperty, gloansinvestmentproperty, gloanspersonalunsecured, gguaranteesgranted, gotherliabilities)" />
                    </div>
                    <div class="form-row">
                      <tag:formField2Col name="Please specify" path="gotherliabilitiesdetails" space="true"
                        dimension="medium" maxlength="50" />
                    </div>
                    <div class="form-row">
                      <tag:formField2ColValText name="Total liabilities" path="gliabilitiestotal" dimension="short"
                        dollar="true" disabled="true" onblur="onchange ()"
                        onchange="totalFields (gnettassets, gassetstotal, '-', gliabilitiestotal)" bold="true" />
                    </div>
                    <div class="form-row last-row">
                      <tag:formField2ColValText name="Net assets" path="gnettassets" dimension="short" dollar="true"
                        disabled="true" bold="true" />
                    </div>
                  </div>
                </div>
              </div>
              
              <hr class="clear"/>
              
              <h2>Guarantors - Income and Expenditure</h2>
              
              <div class="form-group">
                <div class="two-columns">
                  <div class="first-column">
                    <h3>Annual Income</h3>
                    
                    <div class="form-row">
                      <tag:formField2Col name="Gross salary" path="gsalary" dimension="medium" dollar="true"
                        onblur="onchange ()"
                        onchange="totalFields (gincometotal, gsalary, grentalanddividend, gotherincome)" />
                    </div>
                    <div class="form-row">
                      <tag:formField2Col name="Rental and dividend income" path="grentalanddividend"
                        dimension="medium" dollar="true" onblur="onchange ()"
                        onchange="totalFields (gincometotal, gsalary, grentalanddividend, gotherincome)" />
                    </div>
                    <div class="form-row">
                      <tag:formField2Col name="Other income" path="gotherincome" dimension="medium" dollar="true"
                        onblur="onchange ()"
                        onchange="totalFields (gincometotal, gsalary, grentalanddividend, gotherincome)" />
                    </div>
                    <div class="form-row">
                      <tag:formField2Col name="Please specify" path="gotherincomedetails" space="true"
                        dimension="medium" maxlength="50" />
                    </div>
                    <div class="form-row">
                      <tag:formField2ColValText name="Total gross income" path="gincometotal" dimension="short"
                        dollar="true" disabled="true" onblur="onchange ()"
                        onchange="totalFields (gaftertaxtotal, gincometotal, '-', gtaxpayable)" bold="true" />
                    </div>
                    <div class="form-row">
                      <tag:formField2Col id="taxpayable" name="Tax payable" path="gtaxpayable" dimension="medium" dollar="true"
                        onblur="onchange ()" onchange="totalFields (gaftertaxtotal, gincometotal, '-', gtaxpayable)" />
                    </div>
                    <div class="form-row">
                      <tag:formField2Col name="Tax payable date" path="gtaxpayabledate" space="true" formname="financialsForm"
                        dimension="short" isdate="true" bold="true" />
                    </div>
                    <div class="form-row last-row">
                      <tag:formField2ColValText name="Total after-tax income" path="gaftertaxtotal"
                        dimension="short" dollar="true" disabled="true" onblur="onchange ()"
                        onchange="totalFields (gincomeavailable, gaftertaxtotal, '-', gexpendituretotal)" bold="true" />
                    </div>
                  </div>
                  <div class="second-column">
                    <div class="form-row">
                      <tag:formField2Col name="Mortgage and interest payments on secured loans"
                        path="ginterestonsecuredloans" dimension="medium" dollar="true" onblur="onchange ()"
                        onchange="totalFields (gexpendituretotal, ginterestonsecuredloans, ginterestonunsecuredloans, glivingexpenses, gotherexpenses)" />
                    </div>
                    <div class="form-row">
                      <tag:formField2Col name="Interest payments on unsecured loans"
                        path="ginterestonunsecuredloans" dimension="medium" dollar="true" onblur="onchange ()"
                        onchange="totalFields (gexpendituretotal, ginterestonsecuredloans, ginterestonunsecuredloans, glivingexpenses, gotherexpenses)" />
                    </div>
                    <div class="form-row">
                      <tag:formField2Col name="Living expenses and school fees" path="glivingexpenses"
                        dimension="medium" dollar="true" onblur="onchange ()"
                        onchange="totalFields (gexpendituretotal, ginterestonsecuredloans, ginterestonunsecuredloans, glivingexpenses, gotherexpenses)" />
                    </div>
                    <div class="form-row">
                      <tag:formField2Col name="Other expenses" path="gotherexpenses" dimension="medium"
                        dollar="true" onblur="onchange ()"
                        onchange="totalFields (gexpendituretotal, ginterestonsecuredloans, ginterestonunsecuredloans, glivingexpenses, gotherexpenses)" />
                    </div>
                    <div class="form-row">
                      <tag:formField2Col name="Please specify" path="gotherexpensesdetails" space="true"
                        dimension="medium" maxlength="50" />
                    </div>
                    <div class="form-row">
                      <tag:formField2ColValText name="Total expenditure" path="gexpendituretotal" dimension="short"
                        dollar="true" disabled="true" onblur="onchange ()"
                        onchange="totalFields (gincomeavailable, gaftertaxtotal, '-', gexpendituretotal)" bold="true" />
                    </div>
                    <div class="form-row last-row">
                      <tag:formField2ColValText name="Net income available" path="gincomeavailable"
                        dimension="short" dollar="true" disabled="true" bold="true" />
                    </div>
                  </div>
                </div>
              </div>
            </c:if>
          </spring:nestedPath>
          
          <hr class="clear"/>
          
          <h2>Guarantors - Income and Expenditure</h2>
          
          <div class="form-group">
            <div class="form-row last-row">
              <input type="checkbox" class="checkbox" name="additionalGuarantors" id="additionalGuarantors" value="true" onclick="confirmDisable();"/>
              <label for="additionalGuarantors" class="attached">Add additional guarantors?</label>
              
              <br class="clear"/>
            </div>
            <br class="clear"/>
          </div>
          
          <hr class="clear"/>
          
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
