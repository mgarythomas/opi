<%@ include file="/WEB-INF/jsp/includes.jsp" %>

<B>Date of Birth:</B>
<spring:bind path="dateOfBirth">
  <FONT color="red">
    <B><c:out value="${status.errorMessage}"/></B>
  </FONT>
  <BR><INPUT type="text" maxlength="10" size="10" name="dateOfBirth" value="<c:out value="${status.value}"/>" >
</spring:bind>
<P>
