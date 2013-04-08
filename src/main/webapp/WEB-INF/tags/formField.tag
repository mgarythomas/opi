<%@ tag body-content="scriptless" %>
<%@ attribute name="name" required="true" %>
<%@ attribute name="path" required="true" %>
<%@ attribute name="dimension" required="true" %>
<%@ attribute name="type" required="false" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<spring:bind path="${path}">
  <label class="${!empty status.errorMessage ? 'red' : ''}">
    ${name}
    <c:if test="${!empty isdate}">(dd-mm-yyyy)</c:if>
    
    <c:if test="${!empty mand}"><span class="mandatoryField">#</span></c:if>
  </label>
  <c:choose>
    <c:when test="${!empty type}">
      <input class="${dimension}" type="${type}" name="${status.expression}" value="${status.value}" />
    </c:when>
    <c:otherwise>
      <input class="${dimension}" type="text" name="${status.expression}" value="${status.value}" />
    </c:otherwise>
  </c:choose>
</spring:bind>

<br class="clear"/>