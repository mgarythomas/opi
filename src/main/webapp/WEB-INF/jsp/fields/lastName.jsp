<%@ include file="/WEB-INF/jsp/includes.jsp" %>

<spring:bind path="lastname">
   <label for="applicantMiddle">Surname<span class="mandatoryField">#&nbsp;<c:out value="${status.errorMessage}"/></span></label>
   <input class="medium" name="lastname" value="<c:out value="${status.value}"/>" >
</spring:bind>
<br/>

