<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt1" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
  <head>
    <title>OPI - Investment Details</title>
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
        
        <h1>Investment Details</h1>

        <c:choose>
          <c:when test="${application.product.code == 'hfa'}">
            <div class="messages">
              <p>
                Investors can choose to invest in one, two or all three funds. The minimum direct investment in each fund is
                $5,000 and $1,000 increments thereafter. The minimum loan amount is $50,000 with $10,000 increments thereafter
                (this loan amount can be invested across the three funds but in minimum investments of $10,000 in each fund and
                increments of $10,000 thereafter).
              </p>
            </div>
          </c:when>
          <c:when test="${application.product.code == 'citibank1' || application.product.code == 'citibank2'}">
            <div class="messages">
              <p>
                The minimum investment in each fund is $10,000 and $1,000 increments thereafter.
              </p>
            </div>
          </c:when>
        </c:choose>

        <jsp:include flush="true" page="/WEB-INF/jsp/includes/errors_and_messages.jsp"/>

        <form:form method="post" id="applicationForm" name="applicationForm">
          <h2>Investment Amount</h2>

          <input type="hidden" name="submitAction" id="submitAction" value="" />
          <input type="hidden" name="appType" id="appType" value="1" />
      
          <spring:nestedPath path="application">
            <p>Please enter the amounts you wish to invest for each fund</p>
                        
            <div class="form-group">
              <c:if test="${application.product.code == 'hfa'}">
                <div class="form-row">
                  <tag:formField2ColValText name="Octane Global Fund Asia" path="applicationamount01"
                    dimension="short" mand="true" dollar="true" onblur="onchange ()"
                    onchange="totalFields (applicationamounttotal, applicationamount01, applicationamount02, applicationamount03)" />
                </div>
                <div class="form-row">
                  <tag:formField2ColValText name="Octane Global Fund Europe" path="applicationamount02"
                    dimension="short" mand="true" dollar="true" onblur="onchange ()"
                    onchange="totalFields (applicationamounttotal, applicationamount01, applicationamount02, applicationamount03)" />
                </div>
                <div class="form-row">
                  <tag:formField2ColValText name="Octane Global Fund USA" path="applicationamount03"
                    dimension="short" mand="true" dollar="true" onblur="onchange ()"
                    onchange="totalFields (applicationamounttotal, applicationamount01, applicationamount02, applicationamount03)" />
                </div>
              </c:if>
              <c:if test="${application.product.code == 'citibank1'}">
                <div class="form-row">
                  <tag:formField2ColValText name="UBS Call Ups - Series 6 AUD" path="applicationamount01"
                    dimension="short" mand="true" dollar="true" onblur="onchange ()"
                    onchange="totalFields (applicationamounttotal, applicationamount01)" />
                </div>
              </c:if>
              <c:if test="${application.product.code == 'citibank2'}">
                <div class="form-row">
                  <tag:formField2ColValText name="UBS Call Ups - Series 6 USD" path="applicationamount01"
                    dimension="short" mand="true" dollar="true" onblur="onchange ()"
                    onchange="totalFields (applicationamounttotal, applicationamount01)" />
                </div>
              </c:if>
              <div class="form-row last-row">
                <tag:formField2ColValText name="Total investment" path="applicationamounttotal"
                  dimension="short" mand="true" dollar="true" disabled="true" />
              </div>
            </div>
            
            <c:if test="${application.product.code == 'hfa'}">
              <h2>Payment Option</h2>

              <p>Select how you intend to pay for your investment</p>
              
              <c:if test="${!empty status.errorMessage}">
                <div class="messages">
                  <p># <c:out value="${status.errorMessage}" /></p>
                </div>
              </c:if>
              
              <spring:bind path="paymentmethod">
                <div class="form-group">
                  <div class="form-row">
                    <input type="radio" name="paymentmethod" value="0" style="width: auto; margin-left: 10px;"
                      <c:if test="${application.paymentmethod == '0'}">checked="checked"</c:if>
                      <c:if test="${(application.trust != null && application.trust.issuperfund == 'true')}">disabled="true"</c:if> />
                    <label class="auto">Buy Units with UBS Loan</label>
                    
                    <br class="clear"/>
                  </div>
                  <div class="form-row">
                    <input type="radio" name="paymentmethod" value="1" style="width: auto; margin-left: 10px;"
                      <c:if test="${application.paymentmethod == '1'}">checked="checked"</c:if>
                      <c:if test="${(application.trust != null && application.trust.issuperfund == 'true')}">disabled="true"</c:if> />
                    <label class="auto">Buy Units with UBS Loan and Interest Assistance Loan</label>
                    
                    <br class="clear"/>
                  </div>
                  <div class="form-row">
                    <input type="radio" name="paymentmethod" value="2" style="width: auto; margin-left: 10px;"
                      <c:if test="${application.paymentmethod == '2'}">checked="checked"</c:if> />
                    <label class="auto">Buy Units and Put Option using investor's own funds</label>
                    
                    <br class="clear"/>
                  </div>
                  <div class="form-row last-row">
                    <input type="radio" name="paymentmethod" value="3" style="width: auto; margin-left: 10px;"
                      <c:if test="${application.paymentmethod == '3'}">checked="checked"</c:if> />
                    <label class="auto">Buy Units without Put Option using investor's own funds</label>
                    
                    <br class="clear"/>
                  </div>
                </div>
                
                <hr class="clear"/>
      
                <div class="messages">
                  <c:if test="${(application.trust != null && application.trust.issuperfund == 'true')}">
                    <p>Please note that superannuation funds cannnot apply for a loan.</p>
                  </c:if>
                  
                  <p>
                    Applicants paying out of their own funds may choose to purchase a Put Option
                    from UBS. Borrowers from UBS are required to purchase a Put Option (if you have
                    selected a loan application you will automatically receive a Put Option because
                    it is mandatory for borrowers).
                    <br/>
                    Interest on the Loan and Protection Fee on the Put Option are paid annually in
                    advance.
                  </p>
                  <p>
                    <strong>Interest Assistance Loan:</strong>
                    <br/>
                    Interest on the Interest Assistance Loan is paid annually in advance and
                    investors are required to contribute from their own funds. The Interest
                    Assistance Loan principal is repayable in equal annual installments over five
                    years.
                  </p>
                </div>

              </spring:bind>
            </c:if>
            <c:if test="${application.product.code == 'citibank1' || application.product.code == 'citibank2'}">
              <spring:bind path="paymentmethod">
                <input type="hidden" name="paymentmethod" value="2"/>
              </spring:bind>
            </c:if>
            
            <c:if test="${application.product.code == 'hfa'}">
              <h2>Adviser Service Fee</h2>
              
              <div class="form-group">
                <div class="form-row last-row">
                  <tag:formField2Col name="Adviser Commission" path="commission" dimension="veryShort"
                    percentage="true" />
                </div>
              </div>
              
              <p class="foot-note">
                Advisers and applicants can agree upon an Adviser Service Fee of up to 3.0%.
                To enter a lower fee, please type over the default Adviser Service Fee of
                3.0%.
              </p>
            </c:if>
          </spring:nestedPath>

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
