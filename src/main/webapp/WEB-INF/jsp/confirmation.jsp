<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt1" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
  <head>
    <title>OPI - Confirmation</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
  
    <jsp:include flush="true" page="/WEB-INF/jsp/includes/scripts_and_styles.jsp"/>

    <script type="text/javascript">
      function showPdf(id)
      {
        width = 400;
        height = 600;
        left = 390;
        if (screen)
        {
          width = screen.width / 2;
          left = screen.width / 2 - 10;
          height = screen.height * 0.95;
        }
        mywindow = window.open ("/opi/pixml.pdf?applicationId="+id, id, "toolbar=no,location=no,resizable=yes,menubar=no,status=no,scrollbars=yes,width=800,height=800,left=0,top=0");
      }
      
      function pausecomp(millis) 
      {
        var date = new Date();
        var curDate = null;
      
        do { curDate = new Date(); } 
        while(curDate-date < millis);
      }
      
      function cancel() {
        if (confirm("Abandon changes made on this page?")) {
          document.location.href = '${startpage}';
        }
      }
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
        
        <h1>Application Confirmation</h1>
        
        <jsp:include flush="true" page="/WEB-INF/jsp/includes/errors_and_messages.jsp"/>

        <form:form id="ConfirmationForm" method="post"> 
          <spring:nestedPath path="application">
            <c:set var="isBorrowingFromUBS" value="${application.isborrowingfromubs == 'true'}"/>
            <c:set var="isPurchasingPutFromUBS" value="${application.ispurchasingputfromubs == 'true'}"/>
            <c:set var="isIAL" value="${application.isial == 'true'}"/>
            <c:set var="isDAApproved" value="${isdaapproved}"/>

            <c:set var="applicationType" value="${application.type}"/>
            <!-- Type of application is enumerated: -->
            <!--   Individual = 0                   -->
            <!--   Joint = 1                        -->
            <!--   Corporate = 2                    -->
            <!--   Private Trust = 3                -->
            <!--   Corporate Trust = 4              -->
            <c:set var="individualApplication" value="${applicationType == 0}"/>
            <c:set var="jointApplication" value="${applicationType == 1}"/>
            <c:set var="corporateTrust" value="${applicationType == 4}"/>
            <c:set var="trustApplication" value="${(applicationType == 3) || (applicationType == 4)}"/>
            <c:set var="privateApplication" value="${(applicationType == 0) || (applicationType == 1) || (applicationType == 3)}"/>
            <c:set var="corporateApplication" value="${(applicationType == 2) || (applicationType == 4)}"/>
            
            <h2>Checklist</h2>
            
            <div class="form-group">
              <div class="form-row last-row">
                <p><strong>Please ensure the following has been completed or provided when you submit your Application Form:</strong></p>
                
                <ul class="square">
                  <li>
                    Please add Adviser Stamp (including AFSL number) to page 1 of the application form.
                  </li>
                  <li>
                    Please review the
                    <a href="#" onclick="showPdf('${application.id}')"> draft</a> 
                    application form.
                  </li>
                  <c:if test="${isBorrowingFromUBS}">
                    <c:choose>
                      <c:when test="${jointApplication}">
                        <li>
                          Each individual must provide most recent payslip or tax return (if applicable guarantor's payslip or tax return).
                        </li>
                      </c:when>
                      <c:otherwise>
                        <li>
                          Provide most recent payslip or tax return (if applicable guarantor's payslip or tax return).
                        </li>
                      </c:otherwise>
                    </c:choose>
                  </c:if>
                  <c:if test="${application.product.code == 'hfa' and (isBorrowingFromUBS || isPurchasingPutFromUBS)}">
                    <li>
                      Complete and sign the UBS direct debit authorisation in Section 6 (please do not send a cheque).
                    </li>
                  </c:if>
  
                  <c:if test="${application.product.code == 'hfa' and (! isBorrowingFromUBS)}">
                    <li>
                      Complete and sign the HFA direct debit authorisation in Appendix C (please do not send a cheque).
                    </li>
                  </c:if>
  
                  <c:choose>
                    <c:when test="${individualApplication}">
                      <li>
                        Sign the application form${application.product.code == 'hfa' ? ' (Section 9).' : '.'}
                      </li>
                      <c:choose>
                        <c:when test="${isDAApproved}">
                          <li>
                            Copy of the Power of Attorney required if any other person is acting on the investor's behalf.
                          </li>
                        </c:when>
                        <c:otherwise>
                          <c:if test="${isBorrowingFromUBS || isPurchasingPutFromUBS}">
                            <li>
                              Certified copy of valid passport or driver's licence (with clear image and expiry date).
                            </li>
                            <li>
                              Original or certified copy of utility bill or bank statement, no more than 3 months
                              old (address on utility bill or bank statement must match residential address stated
                              in application form).
                            </li>
                          </c:if>
                          <li>
                            Certified copy of the Power of Attorney required if any other person is acting on the
                            investor's behalf. Please also provide certified copy of passport or driver's license
                            for each attorney (if any).
                          </li>
                        </c:otherwise>
                      </c:choose>
                    </c:when>
  
                    <c:when test="${jointApplication}">
                      <li>
                        Each individual must sign the application form${application.product.code == 'hfa' ? ' (Section 9).' : '.'}
                      </li>
                      <c:choose>
                        <c:when test="${isDAApproved}">
                          <li>
                            Copy of the Power of Attorney required if any other person(s) is/are acting on the investors' behalf.
                          </li>
                        </c:when>
                        <c:otherwise>
                          <c:if test="${isBorrowingFromUBS || isPurchasingPutFromUBS}">
                            <li>
                              Each individual must provide a certified copy of valid passport or driver's licence
                              (with clear image and expiry date).
                            </li>
                            <li>
                              Each individual must provide an original or certified copy of utility bill or bank
                              statement, no more than 3 months old (address on utility bill or bank statement must
                              match residential address stated in application form).
                            </li>
                          </c:if>
                          <li>
                            Certified copy of the Power of Attorney required if any other person(s) is/are acting on the
                            investors' behalf. Please also provide certified copy of passport or driver's license
                            for each attorney (if any).
                          </li>
                        </c:otherwise>
                      </c:choose>
                    </c:when>
  
                    <c:when test="${trustApplication}">
                      <c:if test="${privateApplication}">
                        <li>
                          All individual trustees must sign the application form${application.product.code == 'hfa' ? ' (Section 9).' : '.'}
                        </li>
                      </c:if>
                      <c:if test="${isBorrowingFromUBS}">
                        <li>
                          Completed and signed declaration from your solicitor (Appendix A) OR tick the box for
                          trust deed review in Section 3C and provide a copy of your current trust deed.
                        </li>
                      </c:if>
                      <c:if test="${(isBorrowingFromUBS || isPurchasingPutFromUBS) && ! isDAApproved}">
                        <c:choose>
                          <c:when test="${corporateTrust}">
                            <li>
                              Certified copies of passports or drivers' licences for all beneficial owners of
                              corporate trustee (i.e. persons holding 25% or more of shares in the company).
                            </li>
                          </c:when>
                          <c:otherwise>
                            <li>
                              Certified copy of passport or driver's licence for all individual trustees
                              (with clear image and expiry date).
                            </li>
                            <li>
                              Certified copy of utility bill or bank statement for all individual trustees (no
                              more than 3 months old - address on utility bill or bank statement must match
                              residential address in application form).
                            </li>
                          </c:otherwise>
                        </c:choose>
                      </c:if>
                    </c:when>
  
                    <c:when test="${corporateApplication}">
                      <li>
                        Sign the application form by 2 directors, or a director and a company secretary. Can only
                        be signed by one director if that signatory is the sole director and company secretary
                        (Section 9).
                      </li>
                      <c:if test="${(isBorrowingFromUBS || isPurchasingPutFromUBS) && ! isDAApproved}">
                        <li>
                          Certified copies of passports or drivers' licences for 2 directors (or director and
                          company secretary or sole director) and all beneficial owners of the company
                          (i.e. persons holding 25% or more of shares in the company).
                        </li>
                      </c:if>
                    </c:when>
                  </c:choose>
                </ul>
                
                <p>
                  Please note that Dealer Groups that have completed a Distribution Agreement with UBS AG
                  Australia Branch are not required to provide certified photo IDs or certified utility bills
                  for their applicants. 
                  <c:choose>
                    <c:when test="${application.product.code == 'hfa'}">
                      If unsure of the current status of your Dealer Group, please contact UBS on (02) 8121-5720
                    </c:when>
                    <c:when test="${application.product.code == 'citibank1' || application.product.code == 'citibank2'}">
                      If unsure of the current status of your Dealer Group, please contact UBS on 1800 633 100.
                    </c:when>
                  </c:choose>
                </p>
                
                <br class="clear"/>
              </div>
            </div>
          
            <h2>Document Certification</h2>
            
            <div class="form-group">
              <div class="form-row last-row">
                <p><strong>Copies of documentation can be certified as true copies of the original by:</strong></p>
                
                <ul class="square">
                  <li>
                    an Attorney, Lawyer, Accountant, Justice of Peace or Notary Public; or
                  </li>
                  <li>
                    your financial advisor.
                  </li>
                </ul>
                <p>
                  Please note that the above individuals cannot certify their own documents
                  (e.g. they cannot certify their own driver's licence, passport or utility bill).
                </p>
                <p>
                  The certification should state: &ldquo;
                  <i>This is a true copy of the seen original</i>&rdquo;. It should be dated and signed by the
                  certifying person (signature cannot be photocopied), and include the following details
                  about the certifying person:
                </p>
                <ul class="square">
                  <li>
                    name,
                  </li>
                  <li>
                    firm (if applicable),
                  </li>
                  <li>
                    position of person at the firm,
                  </li>
                  <li>
                    representative number (in case of a financial advisor),
                  </li>
                  <li>
                    contact phone number of certifying person.
                  </li>
                </ul>
                
                <br class="clear"/>
              </div>
            </div>
            
            <h2>Where to send mail</h2>
            
            <div class="form-group">
              <div class="form-row last-row">
                <p><strong>Please ensure completed application forms are mailed to the following address:</strong></p>
                
                <ul class="square">
                  <li>
                    <c:choose>
                      <c:when test="${application.product.code == 'hfa'}">
                        <strong>c/- Link Market Services, HFA Octane Global Fund, Reply Paid 1516, Sydney South, NSW, 1234</strong>
                      </c:when>
                      <c:when test="${application.product.code == 'citibank1' || application.product.code == 'citibank2'}">
                        <strong>UBS AG, Australian Branch, Risk Management Product, Level 16, Chifley Tower, 2 Chifley Square, Sydney, NSW, 2000</strong>
                      </c:when>
                    </c:choose>
                  </li>
                </ul>
                
                <br class="clear"/>
              </div>
            </div>
            
            <h2>Declaration</h2>
            
            <div class="form-group">
              <p><strong>Please Read and Confirm the following declarations:</strong></p>

              <h3>Declaration:</h3>
              
              <spring:bind path="declarationunderstood">
                <p>
                  As the applicants' advisor I have to the best of my ability informed them of the potential
                  risks involved in entering into this transaction. I have made them aware of their
                  obligations and responsabilities.
                </p>
                
                <div class="form-row last-row">
                  <input type="hidden" name="_<c:out value="${status.expression}"/>"/>
                  <input type="checkbox" class="checkbox" name="<c:out value="${status.expression}"/>" value="true" <c:if test="${status.value}">checked</c:if>/>
                  <label class="auto">I understand the above and wish to submit the application for approval. <span class="red">#</span></label>
                  
                  <br class="clear"/>
                </div>
                <br class="clear"/>
              </spring:bind>
                
              <h3>Identity and Financials:</h3>
              
              <spring:bind path="applicantidentified">
                <p>
                  I have identified the applicant(s) to be who they say they are. I have validated the clients'
                  financials to be correct as submitted in this application.
                </p>
                
                <div class="form-row last-row">
                  <input type="hidden" name="_<c:out value="${status.expression}"/>"/>
                  <input type="checkbox" name="<c:out value="${status.expression}"/>" class="checkbox" value="true" <c:if test="${status.value}">checked</c:if>/>
                  <label class="auto">I have fully identified the applicant(s) as to whether their Identification and financial details are correct. <span class="red">#</span></label>
                  
                  <br class="clear"/>
                </div>
                <br class="clear"/>
              </spring:bind>
                
              <h3>Submit or Save:</h3>
              
              <ul class="square">
                <li>
                  &ldquo;Finish and Submit&ldquo; if you have completed the application form and wish to forward the
                  electronic copy for processing. A PDF of the application form will automatically open after
                  you submit - please print the final application form and complete all checklist items before
                  posting the application and all supporting documents to the provided address.
                </li>
                <li>
                  &ldquo;Save and Return&ldquo; if you wish to retain the current application in draft format. This
                  application will be available for editing from the summary screen.
                </li>
              </ul>
              
              <br class="clear"/>
            </div>
          </spring:nestedPath>
          
          <p class="foot-note"><span style="color: red;">#</span> Denotes a Mandatory Field</p>
          
          <hr class="clear"/>
          
          <div class="button-row">
            <input type="submit" name="finish" class="button" value="Finish and Submit"/>
            <input type="submit" name="save" class="button attached" value="Save and Return"/>
            <button type="button" class="button attached" onclick="cancel();">Cancel</button>

            <br class="clear"/>
          </div>
        </form:form>
      </div>
      
      <%@ include file="/WEB-INF/jsp/includes/footer.jsp" %>

    </div>
  </body>
</html>