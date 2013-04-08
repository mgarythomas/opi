<%@ include file="/WEB-INF/jsp/includes.jsp"%>
<%@ include file="/WEB-INF/jsp/header.jsp"%>
<!-- content -->
<div id="content">
  <spring:nestedPath path="application">
    <table width="100%">
      <tr>
        <td>
          &nbsp;
        </td>
        <td align="right">
          <span id="remove2"><a href="./new_adv_02.html" target="_new"
            onclick="javascript:document.getElementById('applicant2Content').style.display = 'none';"> > Logout</a> </span>
          &nbsp;&nbsp;&nbsp;
          <span id="remove2"><a href="./new_adv_02.html"
            onclick="javascript:document.getElementById('applicant2Content').style.display = 'none';"> > Help</a> </span>
        </td>
      </tr>
    </table>
    <br>
    <div class="groupHeader">
      Checklist
    </div>
    <br>
    <div class="infoBox">
      <b>Please ensure the following has been completed or provided when you submit your Application Form:</b>
      <!-- All Loan Applications -->
      <c:choose>
        <c:when test="${!empty param.isborrowingfromubs}">
          <p>
          <li>
            Review the printed application form and check accuracy.
          </li>
          <li>
            Provide most recent payslip or tax return (if applicable guarantors payslip or tax return)
          </li>
          <li>
            Complete and sign the UBS direct debit authorisation in Section 6 (please do not send a cheque)
          </li>
          </p>
        </c:when>
        <c:otherwise>
          <!-- All applicants subscribing with their own funds -->
          <p>
          <li>
            Complete and sign the HFA direct debit authorisation in Appendix C (please do not send a cheque)
          </li>
          </p>
        </c:otherwise>
      </c:choose>
      <!-- All Put Applicants -->
      <c:if test="${!empty param.ispurchasingputfromubs}">
        <p>
        <li>
          Complete and sign the direct debit authorisation in Section 6 (please do not send a cheque)
        </li>
        </p>
      </c:if>
      <!-- If you are applying as an Individual  -->
      <c:if test="${param.type == 0}">
        <p>
        <li>
          Sign the application form (Section 9)
        </li>
        <c:if test="${!empty param.isdaapproved}">
          <li>
            Certified copy of valid passport or drivers licence (with clear image and expiry date)
          </li>
          <li>
            Original or certified copy of utility bill or bank statement, no more than 3 months old
          </li>
        </c:if>
        <li>
          Certified copy of the Power of Attorney required if any other person is acting on the investors behalf
        </li>
        </p>
      </c:if>
      <!-- If you are applying as a Joint Account -->
      <c:if test="${param.type == 1}">
        <p>
        <li>
          Each individual must sign the application form (Section 9)
        </li>
        <c:if test="${!empty param.isdaapproved}">
          <li>
            Certified copy of valid passport or drivers licence (with clear image and expiry date) for each individual
          </li>
          <li>
            Original of certified copy of utility bill or bank statement, no more than 3 months old, for each individual
          </li>
        </c:if>
        <li>
          Certified copy of the Power of Attorney required if any other person(s) is/are acting on your behalf's
        </li>
        </p>
      </c:if>
      <!-- If you are applying as trustee for a Trust -->
      <c:if test="${(param.type == 3) || (param.type == 4)}">
        <p>
        <li>
          Sign the application form as trustee. If a corporate trustee, this must be signed by 2 directors or a director
          and company secretary. Can only be signed by one director if that signatory is the sole director and company
          secretary (Section 9).
        </li>
        <li>
          Completed and signed declaration from your solicitor (Appendix A) OR tick the box for trust deed review in
          Section 3C and provide a copy of your current trust deed (not required for superannuation funds or trust
          applicants who are only buying Units or Units and a Put Option).
        </li>
        <c:if test="${!empty param.isdaapproved}">
          <li>
            Certified copy of passport or drivers licence for all trustees (and certified utility bill for all
            individual trustees)
          </li>
          <li>
            Certified copies of passports or drivers licence for all beneficial owners of corporate trustee (i.e.
            persons holding 25% or more of shares in the company).
          </li>
        </c:if>
        </p>
      </c:if>
      <!-- If you are applying in the name of a Company  -->
      <c:if test="${(param.type == 2) || (param.type == 4)}">
        <p>
        <li>
          Sign the application form by 2 directors, or a director and a company secretary. Can only be signed by one
          director if that signatory is the sole director and company secretary (Section 9).
        </li>
        <c:if test="${!empty param.isdaapproved}">
          <li>
            Certified copies of passports or drivers licence for 2 directors (or director and company secretary or sole
            director) and all beneficial owners of corporate trustee (i.e. persons holding 25% or more of shares in the
            company).
          </li>
        </c:if>
        </p>
      </c:if>
      <!-- Completed Application forms mailing address  -->
      <p>
        <b>Completed Application forms mailing address</b>
        <br>
        c/- Link Market Services, HFA Octane Global Fund, Reply Paid 1516, Sydney South, NSW, 1234
      </p>
      <p>
        Copies of documentation can be certified as true copies of the original by:
      <li>
        an Attorney, Lawyer, Accountant,Justice of Peace or Notary Public; or
      </li>
      <li>
        your financial advisor.
      </li>
      </p>
      <p>
        Please note that the above individuals can not certify their own documents (e.g. they cannot certify their own
        drivers licence, passport or utility bill).
        <br>
        The certification should state: &ldquo;This is a true copy of the seen original&rdquo;.
        <br>
        It should be dated and signed by the certifying person, and include the following details about the certifying
        person:
      <li>
        name
      </li>
      <li>
        firm (if applicable)
      </li>
      <li>
        position of person at the firm
      </li>
      <li>
        representative number (in case of a financial advisor)
      </li>
      <li>
        contact phone number of certifying person
      </li>
      </p>
    </div>
    <br />
    <form method="get" action="<c:url value="/advisorapplications.htm"/>">
      <input type="hidden" name="advisorId" value='<c:out value="${param.advisorId}"/>' />
      <div id="buttons">
        <input name="submit" type="submit" class="right" value="Continue" />
      </div>
    </form>
  </spring:nestedPath>
</div>
<br>
<!-- end content -->
<!-- footer -->
<%@ include file="/WEB-INF/jsp/footer.jsp"%>
