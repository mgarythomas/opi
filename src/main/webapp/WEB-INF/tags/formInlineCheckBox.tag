<%@ tag body-content="scriptless" %>
<%@ attribute name="name" required="true" %>
<%@ attribute name="path" required="true" %>
<%@ attribute name="onclick" required="false" %>
<%@ attribute name="id" required="false" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<spring:bind path="${path}">
  <div class="checkboxfield">
    <input type="hidden" value="true" name="_<c:out value="${status.expression}"/>">
    <label for="${status.expression}">${name}</label>
    <input type="checkbox" class="checkbox"
           style="width: auto; margin-right: 20px; margin-left: 10px;"
           name="<c:out value="${status.expression}"/>" 
           value="true"
           <c:if test="${status.value}">checked="checked"</c:if>
           <c:if test="${!empty id}">id="${id}"</c:if>
           <c:if test="${!empty onclick}">onclick="${onclick}"</c:if>/>
  </div>
</spring:bind>
