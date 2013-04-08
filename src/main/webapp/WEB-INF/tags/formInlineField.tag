<%@ tag body-content="scriptless" %>
<%@ attribute name="name" required="true" %>
<%@ attribute name="path" required="true" %>
<%@ attribute name="dimension" required="true" %>
<%@ attribute name="mand" required="false" %>
<%@ attribute name="dollar" required="false" %>
<%@ attribute name="onchange" required="false" %>
<%@ attribute name="onblur" required="false" %>
<%@ attribute name="maxlength" required="false" %>
<%@ attribute name="id" required="false" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<spring:bind path="${path}">
  <div style="float: left;">
    <label for="${status.expression}" 
           style="width: auto; margin-right: 10px; padding-top: 2px; float: left;">
      <span style="${!empty status.errorMessage ? 'color: red; font-weight: bold;' : ''}">
           ${name}
      </span>
           
    </label>
    <c:if test="${!empty dollar}">$</c:if>
    <input style="float: left; width: 200px;" class="${dimension}" name="${status.expression}" value="${status.value}"
           <c:if test="${!empty onchange}">onchange="${onchange}"</c:if>
           <c:if test="${!empty onblur}">onblur="${onblur}"</c:if>
           <c:if test="${!empty maxlength}">maxlength="${maxlength}"</c:if>
           <c:if test="${!empty id}">id="${id}"</c:if>
    />
  </div>
</spring:bind>
