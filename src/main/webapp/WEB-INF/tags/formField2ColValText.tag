<%@ tag body-content="scriptless"%>
<%@ attribute name="name" required="true"%>
<%@ attribute name="path" required="true"%>
<%@ attribute name="dimension" required="true"%>
<%@ attribute name="mand" required="false"%>
<%@ attribute name="isdate" required="false"%>
<%@ attribute name="dollar" required="false"%>
<%@ attribute name="onchange" required="false"%>
<%@ attribute name="displayError" required="false"%>
<%@ attribute name="onblur" required="false"%>
<%@ attribute name="disabled" required="false"%>
<%@ attribute name="maxlength" required="false" %>
<%@ attribute name="id" required="false" %>
<%@ attribute name="bold" required="false" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<spring:bind path="${path}">
  <label for="applicantMiddle" style="float: left; ${!empty status.errorMessage ? 'color: red; font-weight: bold;' : ''} ${!empty bold ? 'font-weight: bold;' : ''}">
    ${name}
    <span class="mandatoryField"><c:if test="${!empty mand}">#</c:if></span>
  </label>
  <c:if test="${!empty dollar}">
    <p style="float: left; margin: 0px;">$</p>
  </c:if>
  <c:if test="${!empty isdate}">
    <p style="float: left;">&nbsp;(dd-mm-yyyy)</p>
  </c:if>
  <input class="${dimension}" 
         name="${status.expression}" 
         value="${status.value}"
         style="float: left;"
  <c:if test="${!empty disabled}">disabled="${disabled}"</c:if>
  <c:if test="${!empty onchange}">onchange="${onchange}"</c:if>
  <c:if test="${!empty onblur}">onblur="${onblur}"</c:if>
  <c:if test="${!empty maxlength}">maxlength="${maxlength}"</c:if>
  <c:choose>
    <c:when test="${!empty id}">
     id="${id}"
    </c:when>
    <c:otherwise>
      id="${path}"
    </c:otherwise>
  </c:choose> />
  <c:if test="${!empty status.errorMessage}">
    <p style="float: left; ${!empty status.errorMessage ? 'color: red;' : ''}">
      &nbsp;
      <c:out value="${status.errorMessage}" />
    </p>
  </c:if>
</spring:bind>

<br class="clear"/>
