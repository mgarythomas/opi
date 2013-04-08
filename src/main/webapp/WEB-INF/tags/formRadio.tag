<%@ tag body-content="scriptless" %>
<%@ attribute name="name" required="true" %>
<%@ attribute name="path" required="true" %>
<%@ attribute name="mand" required="false" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<label for="">${name}
<span class="mandatoryField"><c:if test="${!empty mand}">#</c:if></span></label>
<spring:bind path="${path}">
   <input type="radio" name="${path}" value="true" <c:if test="${path}.${name} == 'true'}">checked="checked"</c:if> />Yes
   <input type="radio" name="${path}" value="false" <c:if test="${path}.${name} == 'false'}">checked="checked"</c:if> />No
</spring:bind>
<br/>