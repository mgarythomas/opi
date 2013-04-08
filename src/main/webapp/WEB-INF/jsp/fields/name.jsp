<%@ include file="/WEB-INF/jsp/includes.jsp" %>

<B>Name:</B>
<spring:bind path="name">
  <FONT color="red">
    <B><c:out value="${status.errorMessage}"/></B>
  </FONT>
  <BR><INPUT type="text" maxlength="5" size="5" name="company.name" value="<c:out value="${status.value}"/>" >
</spring:bind>
<P>
