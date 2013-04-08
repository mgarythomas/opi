<%@ tag body-content="scriptless" %>
<%@ attribute name="name" required="true" %>
<%@ attribute name="path" required="true" %>
<%@ attribute name="dimension" required="true" %>
<%@ attribute name="mand" required="false" %>
<%@ attribute name="isdate" required="false" %>
<%@ attribute name="dollar" required="false" %>
<%@ attribute name="space" required="false" %>
<%@ attribute name="onchange" required="false" %>
<%@ attribute name="onblur" required="false" %>
<%@ attribute name="maxlength" required="false" %>
<%@ attribute name="id" required="false" %>
<%@ attribute name="percentage" required="false" %>
<%@ attribute name="formname" required="false" %>
<%@ attribute name="disabled" required="false" %>
<%@ attribute name="readonly" required="false" %>
<%@ attribute name="bold" required="false" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<spring:bind path="${path}">
  <label for="${status.expression}" style="${!empty status.errorMessage ? 'color: red; font-weight: bold;' : ''} ${!empty bold ? 'font-weight: bold;' : ''}">
    ${name}
    <c:if test="${!empty isdate}">(dd-mm-yyyy)</c:if>
    <c:if test="${!empty mand}"><span class="red">#</span></c:if>
  </label>
  <c:if test="${!empty dollar}">
    <p style="float: left; margin: 0px;">$</p>
  </c:if>
  <c:if test="${!empty space}">
    <p style="float: left;">&nbsp;&nbsp;</p>
  </c:if>
  <input class="${dimension} ${!empty isdate ? 'has-date' : ''}" 
         value="${status.value}" 
         name="${status.expression}" 
         <c:if test="${!empty onchange}">onchange="${onchange}"</c:if>
         <c:if test="${!empty onblur}">onblur="${onblur}"</c:if>
         <c:if test="${!empty maxlength}">maxlength="${maxlength}"</c:if>
         <c:if test="${!empty id}">id="${id}"</c:if>
         <c:if test="${!empty disabled}">disabled="${disabled}"</c:if>
         <c:if test="${!empty readonly}">readonly="${readonly}"</c:if>
         <c:if test="${!empty isdate}">readonly="readonly" id="${status.expression}"</c:if>
         <c:if test="${(empty id) && (empty isdate)}">id="${status.expression}"</c:if>
  />
  <c:if test="${!empty percentage}">
    <p style="float: left; margin: 0px 10px;">%</p>
  </c:if>
  <c:if test="${!empty isdate}">
   <img src="images/cal.gif" id="f_trigger_c" 
     style="cursor: pointer; float: left; margin-left: 10px;" title="Date selector"
     onmouseover="this.style.background='red';" onmouseout="this.style.background=''" 
     onclick="showCalendar('${status.expression}', '%d-%m-%Y', '12', false)" />
  </c:if>
  <%-- enable this sometime later i guess ...
  <c:if test="${status.error}">
    <br class="clear"/>
    <c:forEach var="errorMessage" items="${status.errorMessages}">
     <p class="label red">${errorMessage}</p>
    </c:forEach>
  </c:if>
  --%>
</spring:bind>

<br class="clear"/>
