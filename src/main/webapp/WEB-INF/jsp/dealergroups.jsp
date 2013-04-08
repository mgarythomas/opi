<%@ include file="/WEB-INF/jsp/includes.jsp"%>
<%@ include file="/WEB-INF/jsp/header1.jsp"%>
<tag:header title="OPI Applications Summary"/>
<script type="text/javascript" src="scripts/help.js"></script>
<!-- content -->
<div id="content">
  <table width="100%">
    <tr>
      <td>
        <span id="creditCalc"><a title="Open Credit Calculator Spreadsheet" href="/opi/images/Octane Global Credit Calculator Ver 1.0.xls"
          target="_creditCalc">> Credit Calculator</a> </span> &nbsp;&nbsp;&nbsp;
        <span id="cashflowCalc"><a title="Open Cash Flow Calculator Spreadsheet" href="/opi/images/Octane Global cash flow calculator v3.xls"
          target="_cashflowCalc">> Cashflow Calculator</a> </span> &nbsp;&nbsp;&nbsp;
      </td>
      <td align="right">
        <span id="remove2"><a title="Logout of OPI" href="<c:url value="/j_spring_security_logout"/> "> >Logout</a> </span> &nbsp;&nbsp;&nbsp;
        <span id="remove2"><a title="Show help page" href="javascript:ShowWinContact();%20void(0);"> >Help</a> </span>
      </td>
    </tr>
  </table>
  <br>
  <div class="groupHeader">
    Summary
  </div>
  <br>
  <form:form id="dealergroupsForm">
    <!-- START FORM SECTION -->
    <input type="hidden" id="index" name="removeId" value="null" />
    <input type="hidden" id="dealergroupId" name="dealergroupId" value="null" />
    <input type="hidden" id="edit" name="edit" value="null" />
      <table width="100%">
        <tr>
          <td>
            <!-- START DEALERGROUPS SECTION -->
            <div id="company">
              <fieldset class="dealergroupStatus">
                <legend class="groupLabel">
                  <a name="0">Dealergroup Status</a>
                </legend>
                <!-- START TABLE MAIN -->
                <table class="dataTableCustom" width="100%" bordercolor="#000088" border="0" cellpadding="1" cellspacing="0">
                  <tr bgcolor="#e0e0e0" class="tableIn">
                    <th>Name</th>
                    <th>Afsl</th>
                    <th>Approved</th>
                    <th>ABN</th>
                  </tr>
                  <c:forEach var="opt" items="${guruusers.dealergroups}" varStatus="s">
                    <tr class="tableIn" <c:if test="${s.index % 2 == 1}">bgcolor="#f9f9ff"</c:if>>
                      <td><c:out value="${opt.displayname}"/></td>
                      <td><c:out value="${opt.afsl}"/></td>
                      <td><c:out value="${opt.isdaapproved}" /></td>
                      <td><c:out value="${opt.displayabn}"/></td>
                    </tr>
                  </c:forEach>
                </table>
                <!-- END TABLE MAIN -->
              </fieldset>
            </div>
            <!-- END DEALERGROUPS SECTION -->
          </td>
        </tr>
      </table>
  </form:form>
  <!-- END FORM SECTION -->
</div>
<!-- end content -->
<!-- footer -->
<%@ include file="/WEB-INF/jsp/footer.jsp"%>
