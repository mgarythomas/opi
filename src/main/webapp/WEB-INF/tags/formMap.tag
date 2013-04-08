<%@ tag body-content="scriptless" %>
<%@ attribute name="name" required="true" %>
<%@ attribute name="path" required="true" %>
<%@ attribute name="dimension" required="true" %>
<%@ attribute name="mand" required="false" %>
<%@ attribute name="map" required="true" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<label for="">${name}<span class="mandatoryField"><c:if test="${!empty mand}">#</c:if></span></label>
<spring:bind path="${path}">
  <select class="${dimension}" name="<c:out value="${status.expression}"/>">
                  <c:forEach items="${'<c:out value="${map}"/>'}" var="opt" >
                      <option value="<c:out value="${opt.value}"/>"
                          <c:if test="${opt.value == status.value}">selected</c:if>/>
                          <c:out value="${opt.value}"/></option>
                  </c:forEach>
  </select>
</spring:bind>
<br/>
