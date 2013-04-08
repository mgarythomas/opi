<%@ include file="/WEB-INF/jsp/includes.jsp"%>

<c:if test="${superuser.advisorapplications}">

  <h2>Application Status</h2>
  
  <table cellspacing="0" class="data">
    <thead>
      <tr>
        <th>Account Designation</th>
        <th>Product Name</th>
        <th>Application Type</th>
        <th>Application Amount</th>
        <th>Application Status</th>
        <th>Payment Status</th>
        <th style="width: 100px; text-align: center;">Options</th>
      </tr>
    </thead>
    <tbody>
      <c:forEach var="opt" items="${superuser.transadvisor.applications}" varStatus="s">
        <tr style="${s.index % 2 == 1 ? 'background: #f9f9ff;' : ''}">
          <td class="${s.last ? 'last-row' : ''}"><c:out value="${opt.accountdesignation}" /></td>
          <td class="${s.last ? 'last-row' : ''}"><c:out value="${opt.product.name}" /></td>
          <td class="${s.last ? 'last-row' : ''}"><c:out value="${opt.displaypaymentmethod}" /></td>
          <td class="${s.last ? 'last-row' : ''}"><fmt1:formatNumber value="${opt.totalamount}" type="currency" currencySymbol="$" maxFractionDigits="0" /></td>
          <td class="${s.last ? 'last-row' : ''}">
            <c:out value="${opt.displaystatus}" />
          </td>
          <td class="${s.last ? 'last-row' : ''}"><c:out value="${opt.displaypaymentstatus}" /></td>
          <td class="${s.last ? 'last-row' : ''}" style="text-align: center;">
            <c:choose>
              <c:when test="${superuser.transadvisor.applicationsarray[s.count-1].status > 0}">
                <a href="#" title="Show PDF" onclick="showPdf('${opt.id}')">View PDF</a>
              </c:when>
              <c:otherwise>
                <a title="Edit Application" href="/opi/addAdvisorapplication.htm?advisorId=${superuser.transadvisor.id}&applicationId=${opt.id}&productId=${opt.product.id}&edit=true">Edit</a>
                |
                <a title="Remove Application" href="#" onclick="removeApplication('${opt.id}','${opt.accountdesignation}')">Delete</a>
              </c:otherwise>
            </c:choose>
          </td>
        </tr>
      </c:forEach>
    </tbody>
  </table>
</c:if>
