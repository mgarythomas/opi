<%@ include file="/WEB-INF/jsp/includes.jsp" %>

<spring:bind path="middlename">
   <label for="applicantMiddle">Middle Name<span class="mandatoryField">&nbsp;<c:out value="${status.errorMessage}"/></span></label>
   <input class="medium" name="middlename" value="<c:out value="${status.value}"/>" >
</spring:bind>
<br/>
