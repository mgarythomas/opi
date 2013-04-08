<%@ tag body-content="scriptless"%>
<%@ attribute name="name" required="true"%>
<%@ attribute name="path" required="true"%>
<%@ attribute name="mand" required="false"%>
<%@ attribute name="list" required="false"%>
<%@ attribute name="id" required="false" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<spring:bind path="${path}">

  <label for="${status.expression}" style="${!empty status.errorMessage ? 'color: red; font-weight: bold;' : ''}">
    ${name}
    <c:if test="${!empty mand}"><span class="red">#</span></c:if>
  </label>

  <select <c:if test="${!empty id}">id="${id}"</c:if> class="short" name="<c:out value="${status.expression}"/>">
    <c:choose>
      <c:when test="${empty mand}">
        <option value=""></option>
      </c:when>
      <c:otherwise>
        <option value="">Select State</option>
      </c:otherwise>
    </c:choose>
    <c:forEach items="${states}" var="opt">
      <option value="<c:out value="${opt}"/>" <c:if test="${opt == status.value}">selected</c:if> />
        <c:out value="${opt}" />
      </option>
    </c:forEach>
  </select>
</spring:bind>

<br class="clear"/>
