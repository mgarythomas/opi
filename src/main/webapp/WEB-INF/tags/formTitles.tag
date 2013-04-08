<%@ tag body-content="scriptless" %>
<%@ attribute name="name" required="true" %>
<%@ attribute name="path" required="true" %>
<%@ attribute name="mand" required="false" %>
<%@ attribute name="list" required="true" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<spring:bind path="${path}">
  <label for="">${name}<span class="mandatoryField"><c:if test="${!empty mand}">#</c:if>&nbsp;<c:out value="${status.errorMessage}"/></span></label>  
  <select class="verySmall" name="<c:out value="${status.expression}"/>">
      <c:forEach items="${titles}" var="opt" >
          <option value="<c:out value="${opt}"/>"
              <c:if test="${opt == status.value}">selected</c:if>/>
              <c:out value="${opt}"/></option>
      </c:forEach>
  </select>
</spring:bind>

<br class="clear"/>