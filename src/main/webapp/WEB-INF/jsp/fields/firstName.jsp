<%@ include file="/WEB-INF/jsp/includes.jsp" %>

<spring:bind path="firstname">
   <label for="applicantMiddle">First Name<span class="mandatoryField">#&nbsp;<c:out value="${status.errorMessage}"/></span></label>
   <input class="medium" name="firstname" value="<c:out value="${status.value}"/>" >
</spring:bind>
<br/>

  