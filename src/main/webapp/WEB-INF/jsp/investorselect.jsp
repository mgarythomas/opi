<%@ include file="/WEB-INF/jsp/includes.jsp"%>
<%--
<label for="applicantTitle">
  Select Investor
</label>
  <select onchange="setinvestorindex(this.selectedIndex);enableCreate()" name='<c:out value="${status.expression}"/>'>
    <c:forEach items="${investors}" var="opt">
      <option value='<c:out value="${opt.key}"/>'
	<c:if test="${opt.value == status.value}">selected</c:if> />
	<c:out value="${opt.value}" />
      </option>
    </c:forEach>
  </select>
--%>

<label for="<c:out value="${status.expression}"/>" class="attached">Select Investor</label>

<select id="transadvisor.transinvestortype" onchange="setinvestorindex(this.selectedIndex); enableCreate()" name="<c:out value="${status.expression}"/>" class="attached">
  <option value="-1">Select Investor</option>
  <option value="0">New Individual</option>
  <option value="1">New Joint Individual</option>
  <option value="2">New Corporate</option>
  <option value="3">New Individual Trust</option>
  <option value="4">New Corporate Trust</option>
  <c:forEach items="${filteredApplicationsUnique}" var="application">
    <option value="<c:out value="${application.id}"/>">
      <c:out value="${application.accountdesignation}" />
    </option>
  </c:forEach>
</select>
