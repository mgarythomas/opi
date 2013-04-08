<%@ include file="/WEB-INF/jsp/includes.jsp" %>

<B>Telephone:</B>
<spring:bind path="homephone">
  <FONT color="red">
    <B><c:out value="${status.errorMessage}"/></B>
  </FONT>
  <BR><INPUT type="text" maxlength="10" size="10" name="telephone" value="<c:out value="${status.value}"/>" >
</spring:bind>
<P>
