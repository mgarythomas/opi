<%@ include file="/WEB-INF/jsp/includes.jsp" %>
<%@ include file="/WEB-INF/jsp/header.jsp" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tag" %>

<P>
<H2><c:if test="${empty dealergroup.id}">New </c:if>Dealergroup:</H2>
<spring:bind path="dealergroup">
  <FONT color="red">
    <B><c:out value="${status.errorMessage}"/></B>
  </FONT>
</spring:bind>
<P>
<FORM method="POST">
  <spring:nestedPath path="dealergroup">
  	  <jsp:include page="/WEB-INF/jsp/fields/afsl.jsp"/>
	  <spring:nestedPath path="company">
		<!-- tag:formField name="name" path="name" / ??? REVISIT -->
	    <jsp:include page="/WEB-INF/jsp/fields/name.jsp"/>
	  </spring:nestedPath>
  </spring:nestedPath>
  <c:if test="${empty dealergroup.id}">
    <INPUT type = "submit" value="Add Dealergroup"  />
  </c:if>
  <c:if test="${!empty dealergroup.id}">
    <INPUT type = "submit" value="Update Dealergroup"  />
  </c:if>
</FORM>
<P>
<BR>

<%@ include file="/WEB-INF/jsp/footer.jsp" %>
