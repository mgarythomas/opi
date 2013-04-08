<%@ include file="/WEB-INF/jsp/includes.jsp" %>

<B>Email:</B>
<spring:bind path="email">
  <FONT color="red">
    <B><c:out value="${status.errorMessage}"/></B>
  </FONT>
  <BR><INPUT type="text" maxlength="50" size="50" name="email" value="<c:out value="${status.value}"/>" >
</spring:bind>
<P>
