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
<%@ attribute name="type" required="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

  <c:if test="${empty type}">
    <label id="mylabel" for="applicantMiddle">
      ${name}
      <c:if test="${!empty isdate}">(dd-mm-yyyy)</c:if>
      <span class="red">
        <c:if test="${!empty mand}">#</c:if>
      </span>
    </label>
  </c:if>
  <c:if test="${!empty dollar}">$</c:if>
  <c:if test="${!empty space}">&nbsp;&nbsp;</c:if>
  <a><b2 id="b2"/></a>
  <input class="${dimension}" value="${status.value}"
         <c:if test="${!empty onchange}">onchange="${onchange}"</c:if>
         <c:if test="${!empty onblur}">onblur="${onblur}"</c:if>
         <c:if test="${!empty maxlength}">maxlength="${maxlength}"</c:if>
         <c:if test="${!empty id}">id="${id}" name="${id}"</c:if>
         <c:if test="${!empty disabled}">disabled="${disabled}"</c:if>
         <c:if test="${!empty readonly}">readonly="${readonly}"</c:if>
         <c:if test="${!empty type}">type="${type}"</c:if>
         <c:if test="${!empty isdate}">readonly=readonly id="${status.expression}"</c:if>
         <c:if test="${(empty id) && (empty isdate)}">id="${status.expression}"</c:if>
  />
  <c:if test="${!empty percentage}">%</c:if>
  <c:if test="${!empty isdate}">
   <img src="images/cal.gif" id="f_trigger_c" 
     style="cursor: pointer; border: 1px solid red;" title="Date selector"
     onmouseover="this.style.background='red';" onmouseout="this.style.background=''" 
     onclick="showCalendar('${status.expression}', '%d-%m-%Y', '12', false)" />
</c:if>
<c:if test="${empty type}">
  <br/>
</c:if>
