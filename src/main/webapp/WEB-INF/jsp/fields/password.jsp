<%@ include file="/WEB-INF/jsp/includes.jsp" %>

<TD class="">Password:</TD>
<spring:bind path="password">
  <FONT color="red">
    <B><c:out value="${status.errorMessage}"/></B>
  </FONT>
  <TD><INPUT class="short" name="password" value="<c:out value="${status.value}"/>" ></TD>
</spring:bind>
