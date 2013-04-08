<%@ tag body-content="scriptless" %>
<%@ attribute name="name" required="true" %>
<%@ attribute name="path" required="true" %>
<%@ attribute name="mand" required="false" %>
<%@ attribute name="msg" required="false" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<spring:bind path="${path}">
  <input type="hidden" value="true" name="_<c:out value="${status.expression}"/>">

  <input type="checkbox" class="checkbox" style="width: auto; padding-left: 10px;" name="${status.expression}" id="${status.expression}" value="true"

  <c:if test="${status.value}">checked="checked"</c:if>/>
  <label class="auto" for="${status.expression}">
    <spring:bind path="${name}">
       ${status.value}
     </spring:bind>
     ${msg}
   </label>
  <span class="mandatoryField">&nbsp;<c:out value="${status.errorMessage}"/></span>
</spring:bind>

<br class="clear"/>
