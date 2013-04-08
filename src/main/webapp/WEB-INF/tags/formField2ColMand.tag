<%@ tag body-content="scriptless" %>
<%@ attribute name="name" required="true" %>
<%@ attribute name="path" required="true" %>
<%@ attribute name="dimension" required="true" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<spring:bind path="${path}">
   <label for="applicantMiddle">${name}
   <span class="mandatoryField">#&nbsp;<c:out value="${status.errorMessage}"/></span>
   </label>
   <!-- input class="${dimension}" name="${path}" value="<c:out value="${status.value}"/>"  -->
   <input class="${dimension}" name="${status.expression}" value="${status.value}" >
</spring:bind>
<br/>
