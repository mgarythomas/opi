<%@ include file="/WEB-INF/jsp/includes.jsp" %>

<TD class="" align="left">AFSL&nbsp;
<spring:bind path="afsl">
  <FONT color="red">
    <B><c:out value="${status.errorMessage}"/></B>
  </FONT>
  <INPUT align="left" class="medium" name="afsl" value="<c:out value="${status.value}"/>" ></TD>
</spring:bind>
