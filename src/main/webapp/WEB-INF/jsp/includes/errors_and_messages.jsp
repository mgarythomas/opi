<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<c:if test="${!empty messages}">
  <div class="messages">
    <c:forEach items="${messages}" var="message">
      <p><c:out value="${message}"/></p>
    </c:forEach>
  </div>
</c:if>

<spring:hasBindErrors name="application">
  <div class="errors" style="padding: 5px 10px; margin-bottom: 15px; border: 1px solid #C30B0B; background: #EBEBEB; line-height: 17px;">
    <p style="color: #E92121; font-weight: bold;">
      Please complete the following fields :
    </p>
    <ul style="margin-left: 20px; padding-bottom: 10px;">
      <c:forEach var="errMsgObj" items="${errors.allErrors}">
        <li style="color: #E92121; font-weight: bold;">
          <spring:message arguments="${errMsgObj.arguments}" code="${errMsgObj.code}" text="${errMsgObj.defaultMessage}" />
        </li>
      </c:forEach>
    </ul>
  </div>
</spring:hasBindErrors>

<spring:hasBindErrors name="additionalGuarantor">
  <div class="errors" style="padding: 5px 10px; margin-bottom: 15px; border: 1px solid #C30B0B; background: #EBEBEB; line-height: 17px;">
    <p style="color: #E92121; font-weight: bold;">
      Please complete the following fields :
    </p>
    <ul style="margin-left: 20px; padding-bottom: 10px;">
      <c:forEach var="errMsgObj" items="${errors.allErrors}">
        <li style="color: #E92121; font-weight: bold;">
          <spring:message arguments="${errMsgObj.arguments}" code="${errMsgObj.code}" text="${errMsgObj.defaultMessage}" />
        </li>
      </c:forEach>
    </ul>
  </div>
</spring:hasBindErrors>

<spring:hasBindErrors name="superuser">
  <div class="errors" style="padding: 5px 10px; margin-bottom: 15px; border: 1px solid #C30B0B; background: #EBEBEB; line-height: 17px;">
    <p style="color: #E92121; font-weight: bold;">
      Please complete the following fields :
    </p>
    <ul style="margin-left: 20px; padding-bottom: 10px;">
      <c:forEach var="errMsgObj" items="${errors.allErrors}">
        <li style="color: #E92121; font-weight: bold;">
          <spring:message code="${errMsgObj.code}" text="${errMsgObj.defaultMessage}" />
        </li>
      </c:forEach>
    </ul>
  </div>
</spring:hasBindErrors>

<spring:hasBindErrors name="company">
  <div class="errors" style="padding: 5px 10px; margin-bottom: 15px; border: 1px solid #C30B0B; background: #EBEBEB; line-height: 17px;">
    <p style="color: #E92121; font-weight: bold;">
      Please complete the following fields :
    </p>
    <ul style="margin-left: 20px; padding-bottom: 10px;">
      <c:forEach var="errMsgObj" items="${errors.allErrors}">
        <li style="color: #E92121; font-weight: bold;">
          <spring:message code="${errMsgObj.code}" text="${errMsgObj.defaultMessage}" />
        </li>
      </c:forEach>
    </ul>
  </div>
</spring:hasBindErrors>

<spring:hasBindErrors name="individual">
  <div class="errors" style="padding: 5px 10px; margin-bottom: 15px; border: 1px solid #C30B0B; background: #EBEBEB; line-height: 17px;">
    <p style="color: #E92121; font-weight: bold;">
      Please complete the following fields :
    </p>
    <ul style="margin-left: 20px; padding-bottom: 10px;">
      <c:forEach var="errMsgObj" items="${errors.allErrors}">
        <li style="color: #E92121; font-weight: bold;">
          <spring:message code="${errMsgObj.code}" text="${errMsgObj.defaultMessage}" />
        </li>
      </c:forEach>
    </ul>
  </div>
</spring:hasBindErrors>

<spring:hasBindErrors name="dealergroup">
  <div class="errors" style="padding: 5px 10px; margin-bottom: 15px; border: 1px solid #C30B0B; background: #EBEBEB; line-height: 17px;">
    <p style="color: #E92121; font-weight: bold;">
      Please complete the following fields :
    </p>
    <ul style="margin-left: 20px; padding-bottom: 10px;">
      <c:forEach var="errMsgObj" items="${errors.allErrors}">
        <li style="color: #E92121; font-weight: bold;">
          <spring:message code="${errMsgObj.code}" text="${errMsgObj.defaultMessage}" />
        </li>
      </c:forEach>
    </ul>
  </div>
</spring:hasBindErrors>

<spring:hasBindErrors name="advisor">
  <div class="errors" style="padding: 5px 10px; margin-bottom: 15px; border: 1px solid #C30B0B; background: #EBEBEB; line-height: 17px;">
    <p style="color: #E92121; font-weight: bold;">
      Please complete the following fields :
    </p>
    <ul style="margin-left: 20px; padding-bottom: 10px;">
      <c:forEach var="errMsgObj" items="${errors.allErrors}">
        <li style="color: #E92121; font-weight: bold;">
          <spring:message code="${errMsgObj.code}" text="${errMsgObj.defaultMessage}" />
        </li>
      </c:forEach>
    </ul>
  </div>
</spring:hasBindErrors>