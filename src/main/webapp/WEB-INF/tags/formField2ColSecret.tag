<%@ tag body-content="scriptless" %>
<%@ attribute name="name" required="true" %>
<%@ attribute name="path" required="true" %>
<%@ attribute name="dimension" required="true" %>
<%@ attribute name="mand" required="false" %>
<%@ attribute name="maxlength" required="false" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<spring:bind path="${path}">

   <label>${name} <span class="mandatoryField"># <c:out value="${status.errorMessage}"/></span></label>
   
  <input class="${dimension}" type="password" name="${status.expression}" value="${status.value}"
         <c:if test="${!empty maxlength}">maxlength="${maxlength}"</c:if>
  />
</spring:bind>
<br/>
