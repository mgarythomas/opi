<%@ include file="/WEB-INF/jsp/includes.jsp"%>
<%@ include file="/WEB-INF/jsp/header.jsp"%>
<!-- content -->
<div id="content">
<table width="100%">
  <tr>
    <td width="15px">&nbsp;</td>
    <td>
    <table width="100%">
      <tr>
        <td width="5px">&nbsp;</td>
        <td>
        <div class="groupHeader">&nbsp;&nbsp;&nbsp;&nbsp;Investor Details</div>
        <div class="groupBox">
        <table width="100%">
          <tr>
            <td><!-- START FORM --> <c:if test="${!empty application.company}">
              <!-- START COMPANY READ-ONLY  SECTION -->
              <div id="company">
              <fieldset class="twoCol"><legend class="groupLabel"><a name="0">Investor Company
              Details</a></legend> <!-- START TABLE COMPANY READ-ONLY -->
              <table class="dataTable" width="100%" cellpadding="1" cellspacing="0">
                <!-- START ROW1 -->
                <tr class="tableIn">
                  <td valign="top"><label for="Company Name">Company Name</label></td>
                  <td valign="top"><label for=""><b><c:out value="${application.company.name}" /></b></label></td>
                  <td valign="top"><label for="ABN">ABN</label></td>
                  <td valign="top"><label for="">&nbsp;<b><c:out value="${application.company.abn}" /></b></label>
                  </td>
                  <td valign="top"><label for="Company Name">Date of Incorporation</label></td>
                  <td valign="top"><label for=""><b><c:out
                    value="${application.company.incorporationdate}" /></b></label></td>
                </tr>
                <!-- END ROW1 -->
              </table>
              <form method="GET" action='<c:url value="/editCompany.htm"/>' name="formEditCompany"><input
                type="hidden" name="individualId"
                value='<c:out value="${application.investorindividual1.individual.id}"/>' /> <input type="hidden"
                name="advisorId" value='<c:out value="${application.advisor.id}"/>' /> <input type="hidden"
                name="productName" value='<c:out value="${application.product.name}"/>' /> <input type="hidden"
                name="investorType" value='<c:out value="${application.type}"/>' />
              <div id="buttons"><input name="editcompany1" type="submit" class="left" value="Edit" /></div>
              </form>
              <!-- END TABLE COMPANY READ-ONLY --></fieldset>
              </div>
              <!-- END COMPANY READ-ONLY  SECTION -->
            </c:if> <c:if test="${!empty application.trust}">
              <!-- START TRUST READ-ONLY  SECTION -->
              <div id="trust">
              <fieldset class="twoCol"><legend class="groupLabel"><a name="0">Investor Trust
              Details</a></legend> <!-- START TABLE TRUST READ-ONLY -->
              <table class="dataTable" width="100%" cellpadding="1" cellspacing="0">
                <tr class="tableIn">
                  <td><label for="application.trust.companyByCompanyid.name">Trust Name</label></td>
                  <td><label for=""><b><c:out value="${application.trust.companyByCompanyid.name}" /></b></label></td>
                  <td><label for="application.trust.companyByCompanyid.abn">ABN</label></td>
                  <td><label for=""><b><c:out value="${application.trust.companyByCompanyid.abn}" /></b>&nbsp;</label></td>
                  <td><label for="application.trust.companyByCompanyid.arbn">ARBN</label></td>
                  <td><label for=""><b><c:out value="${application.trust.companyByCompanyid.arbn}" /></b>&nbsp;</label></td>
                </tr>
                <tr class="tableIn">
                  <td><label for="application.trust.companyByCompanyid.tfn">TFN</label></td>
                  <td><label for=""><b><c:out value="${application.trust.companyByCompanyid.tfn}" /></b>&nbsp;</label></td>
                  <td><label for="">&nbsp;</label></td>
                  <td><label for="">&nbsp;</label></td>
                  <td><label for="">&nbsp;</label></td>
                  <td><label for="">&nbsp;</label></td>
                </tr>
                <!-- END ROW1 -->
              </table>
              <form method="GET" action='<c:url value="/editTrust.htm"/>' name="formEditCompany"><input
                type="hidden" name="trustId" value='<c:out value="${application.trust.id}"/>' /> <input type="hidden"
                name="advisorId" value='<c:out value="${application.advisor.id}"/>' /> <input type="hidden"
                name="productName" value='<c:out value="${application.product.name}"/>' /> <input type="hidden"
                name="investorType" value='<c:out value="${application.type}"/>' />
              <div id="buttons"><input name="edittrust1" type="submit" class="left" value="Edit" /></div>
              </form>
              </fieldset>
              </div>
              <!-- END TRUST READ-ONLY  SECTION -->
            </c:if> <!-- START INDIVIDUAL SECTION -->
            <div id="individual">
            <fieldset class="twoCol"><!-- spring:nestedPath path="application.investorindividual1" --> <legend
              class="groupLabel"><a name="0">Individidual Details</a></legend> <c:forEach var="investor"
              items="${application.investorindividuals}">
              <!-- START TABLE INDIVIDUAL -->
              <table class="dataTable" width="100%" cellpadding="1" cellspacing="0">
                <tr class="tableIn">
                  <td><label for="individual.firstname">First Name</label></td>
                  <td><label for=""><b><c:out value="${investor.individual.firstname}" /></b>&nbsp;</label></td>
                  <td><label for="individual.middlename">Middle Name</label></td>
                  <td><label for=""><b><c:out value="${investor.individual.firstname}" /></b>&nbsp;</label></td>
                  <td><label for="individual.lastname">Last Name</label></td>
                  <td><label for=""><b><c:out value="${investor.individual.lastname}" /></b>&nbsp;</label></td>
                </tr>
                <tr class="tableIn">
                  <td><label for="individual.tfn">TFN</label></td>
                  <td><label for=""><b><c:out value="${investor.individual.tfn}" /></b>&nbsp;</label></td>
                  <td><label for="individual.address1">Address Line 1</label></td>
                  <td><label for=""><b><c:out value="${investor.individual.address1}" /></b>&nbsp;</label></td>
                  <td><label for="individual.suburb">Suburb</label></td>
                  <td><label for=""><b><c:out value="${investor.individual.suburb}" /></b>&nbsp;</label></td>
                </tr>
                <tr class="tableIn">
                  <td><label for="individual.state">State</label></td>
                  <td><label for=""><b><c:out value="${investor.individual.state}" /></b>&nbsp;</label></td>
                  <td><label for="individual.postcode">Postcode</label></td>
                  <td><label for=""><b><c:out value="${investor.individual.postcode}" /></b>&nbsp;</label></td>
                  <td><label for="individual.country">Country</label></td>
                  <td><label for=""><b><c:out value="${investor.individual.country}" /></b>&nbsp;</label></td>
                </tr>
                <tr class="tableIn">
                  <td><label for="individual.townofbirth">Date of Birth</label></td>
                  <td><label for=""><b><c:out value="${investor.individual.townofbirth}" /></b>&nbsp;</label></td>
                  <td><label for="individual.state">Place of Birth</label></td>
                  <td><label for=""><b><c:out value="${investor.individual.state}" /></b>&nbsp;</label></td>
                  <td><label for="individual.passportno">Passport No.</label></td>
                  <td><label for=""><b><c:out value="${investor.individual.passportno}" /></b>&nbsp;</label></td>
                </tr>
                <tr class="tableIn">
                  <td><label for="individual.nationality">Nationality</label></td>
                  <td><label for=""><b><c:out value="${investor.individual.nationality}" /></b>&nbsp;</label></td>
                  <td><label for="individual.driverslicenceno">Driver's licence</label></td>
                  <td><label for=""><b><c:out value="${investor.individual.driverslicenceno}" /></b>&nbsp;</label></td>
                  <td><label for="individual.occupation">Occupation</label></td>
                  <td><label for=""><b><c:out value="${investor.individual.occupation}" /></b>&nbsp;</label></td>
                </tr>
                <tr class="tableIn">
                  <td><label for="individual.employer">Employer</label></td>
                  <td><label for=""><c:out value="${investor.individual.employer}" />&nbsp;</label></td>
                  <td><label for="">&nbsp;</label></td>
                  <td><label for="">&nbsp;</label></td>
                  <td><label for="">&nbsp;</label></td>
                  <td><label for="">&nbsp;</label></td>
                </tr>
                <!-- END ROW1 -->
              </table>
              <div id="buttons">
              <c:if test="${application.type > 0}">
              <form method="GET" action='<c:url value="/removeIndividual.htm"/>' name="formRemoveIndividual"><input
                type="hidden" name="individualId" value='<c:out value="${investor.individual.id}"/>' /> <input
                type="hidden" name="applicationId" value='<c:out value="${application.id}"/>' /> <input type="hidden"
                name="advisorId" value='<c:out value="${application.advisor.id}"/>' /> <input type="hidden"
                name="productName" value='<c:out value="${application.product.name}"/>' /> <input type="hidden"
                name="investorType" value='<c:out value="${application.name}"/>' /> <input name="removeinvestor"
                type="submit" class="left" value="Remove" /></form>
              </c:if>              
              <form method="GET" action='<c:url value="/editIndividual.htm"/>' name="formEditIndividual"><input
                type="hidden" name="individualId" value='<c:out value="${investor.individual.id}"/>' /> <input
                type="hidden" name="applicationId" value='<c:out value="${application.id}"/>' /> <input type="hidden"
                name="advisorId" value='<c:out value="${application.advisor.id}"/>' /> <input type="hidden"
                name="productName" value='<c:out value="${application.product.name}"/>' /> <input type="hidden"
                name="investorType" value='<c:out value="${application.name}"/>' /> <input name="editinvestor1"
                type="submit" class="left" value="Edit" /></form>
              </div>
            </c:forEach> <!-- /spring:nestedPath --> <c:if test="${application.unbounded}">
              <div id="buttons">
              <form method="GET" action='<c:url value="/addIndividual.htm"/>' name="formAddIndividual"><input
                type="hidden" name="advisorId" value='<c:out value="${application.advisor.id}"/>' /> <input
                type="hidden" name="applicationId" value='<c:out value="${application.id}"/>' /> <input type="hidden"
                name="productName" value='<c:out value="${application.product.name}"/>' /> <input type="hidden"
                name="type" value='<c:out value="${application.type}"/>' /> <input type="hidden" name="investorType"
                value='<c:out value="${application.name}"/>' /> <input name="addinvestor" type="submit" class="right"
                value="Create New" /></form>
              </div>
            </c:if> <!-- END TABLE MAIN --></fieldset>
            </div>
            <!-- END INDIVIDUAL SECTION --></td>
          </tr>
        </table>
        </div>
        </td>
      </tr>
      <tr>
        <td />
        <td><br />
        <form method="POST" name="Application" action="">
        <div id="buttons"><input type="hidden" name="advisorId" value='<c:out value="${application.advisor.id}"/>' />
        <input type="hidden" name="applicationId" value='<c:out value="${application.id}"/>' /> <input name="previous"
          type="button" class="left" value="Previous" onclick="javascript:doAction('trustDetailFrm','previous');" /> <input
          name="next" type="submit" class="right" value="Next" /></div>
        </form>
        </td>
      </tr>
    </table>
    </td>
  </tr>
</table>
</div>
<!-- end content -->
<%@ include file="/WEB-INF/jsp/footer.jsp"%>
