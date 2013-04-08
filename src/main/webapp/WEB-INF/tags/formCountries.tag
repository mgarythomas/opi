<%@ tag body-content="scriptless" %>
<%@ attribute name="name" required="true" %>
<%@ attribute name="path" required="true" %>
<%@ attribute name="mand" required="false" %>
<%@ attribute name="map" required="true" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<spring:bind path="${path}">
  <label style="${!empty status.errorMessage ? 'color: red; font-weight: bold;' : ''}">
    ${name}
    <span class="mandatoryField">
      <c:if test="${!empty mand}">#</c:if>
    </span>
  </label>
  <select class="medium" name="<c:out value="${status.expression}"/>">
    <c:forEach items="${countries}" var="opt" >
      <option value="<c:out value="${opt.key}"/>"
        <c:if test="${opt.key == status.value}">selected</c:if>/>
        <c:out value="${opt.value}"/>
      </option>
    </c:forEach>
  </select>
</spring:bind>

<br class="clear"/>
