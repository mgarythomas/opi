<%@ include file="/WEB-INF/jsp/includes.jsp" %>
<%@ include file="/WEB-INF/jsp/header.jsp" %>

<P>
<H2><c:if test="${empty advisorfirm.id}">New </c:if>Adviser Firm</H2>
<spring:bind path="advisorfirm">
  <FONT color="red">
    <B><c:out value="${status.errorMessage}"/></B>
  </FONT>
</spring:bind>
<P>
<B>Dealergroup:</B> <c:out value="${advisorfirm.dealergroup.company.name}"/>
<P>
<FORM method="POST">
  <B>Name:</B>
  <spring:bind path="advisorfirm.company.name">
    <FONT color="red">
      <B><c:out value="${status.errorMessage}"/></B>
    </FONT>
    <BR><INPUT type="text" maxlength="30" size="30" name="<c:out value="${status.expression}"/>" value="<c:out value="${status.value}"/>" >
  </spring:bind>
  <P>
  <B>abn:</B>
  <spring:bind path="advisorfirm.company.abn">
    <FONT color="red">
      <B><c:out value="${status.errorMessage}"/></B>
    </FONT>
    <BR><INPUT type="text" maxlength="10" size="10" name="<c:out value="${status.expression}"/>" value="<c:out value="${status.value}"/>" />
  </spring:bind>
<P>
  <c:if test="${empty advisorfirm.id}">
    <INPUT type = "submit" value="Add Adviser Firm"/>
  </c:if>
  <c:if test="${!empty advisorfirm.id}">
    <INPUT type = "submit" value="Update Adviser Firm"/>
  </c:if>
</FORM>
<P>
<BR>

<%@ include file="/WEB-INF/jsp/footer.jsp" %>
