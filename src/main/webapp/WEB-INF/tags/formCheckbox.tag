<%@ tag body-content="scriptless"%>
<%@ attribute name="name" required="true"%>
<%@ attribute name="path" required="true"%>
<%@ attribute name="mand" required="false"%>
<%@ attribute name="id" required="false"%>
<%@ attribute name="onclick" required="false"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<spring:bind path="${path}">
  <input type="hidden" value="true" name="_<c:out value="${status.expression}"/>">
  <label for="<c:out value="${status.expression}"/>" style="float: left; ${!empty status.errorMessage ? 'color: red; font-weight: bold;' : ''}">
    ${name}
    <span class="mandatoryField"> <c:if test="${!empty mand}">#</c:if> </span>
  </label>
  <input type="checkbox" 
         id="${id}" 
         class="leftAlignedCheckBox" 
         style="float: left; width: auto;"
         name="<c:out value="${status.expression}"/>"
         value="true"
         <c:if test="${status.value}">checked="checked"</c:if>
         <c:if test="${!empty onclick}">onclick="${onclick}"</c:if> />
  <!-- 
  <span class=mandatoryField>&nbsp;<c:out value="${status.errorMessage}"/></span>
   -->
</spring:bind>

<br class="clear"/>

