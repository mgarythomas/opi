<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt1" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
  <head>
    <title>OPI - Investor Details</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
  
    <jsp:include flush="true" page="/WEB-INF/jsp/includes/scripts_and_styles.jsp"/>
  </head>
  
  <body>
    <div id="wrapper">
      
      <jsp:include flush="true" page="/WEB-INF/jsp/includes/header.jsp"/>
      
      <!-- content -->
      <div id="content">
        <div class="breadcrumb-left">&#160;</div>
        <div class="breadcrumb-right">
          <a title="Logout of OPI" href="<c:url value="/j_spring_security_logout"/>">&gt;Logout</a>
          <a title="Show help page" href="javascript:ShowWinContact();%20void(0);">&gt;Help</a>
        </div>
        
        <br class="clear"/>
        
        <h1>Adviser</h1>
        
        <jsp:include flush="true" page="/WEB-INF/jsp/includes/errors_and_messages.jsp"/>      

        <form:form>
        
          <h2>Adviser Details</h2>
          
          <div class="form-group">
            <div class="two-columns">
              <div class="first-column">
                <spring:nestedPath path="advisor.individual">
                  <div class="form-row">
                    <tag:formTitles name="Title" path="title" list="titles" />
                  </div>
                  <div class="form-row">
                    <tag:formField2ColValText name="First Name" path="firstname" dimension="medium" mand="true" disabled="true" />
                  </div>
                  <div class="form-row">
                    <tag:formField2ColValText name="Surname" path="lastname" dimension="medium" mand="true" disabled="true" />
                  </div>
                </spring:nestedPath>
                <spring:nestedPath path="advisor">
                  <div class="form-row last-row">
                    <tag:formField2Col name="Assistant's Name" path="assistantname" dimension="medium" maxlength="40"/>
                  </div>
                </spring:nestedPath>
              </div>
              <div class="second-column">
                <spring:nestedPath path="advisor.individual">
                  <div class="form-row">
                    <tag:formField2Col name="Work Phone" path="workphone" dimension="medium" mand="true" maxlength="20" />
                  </div>
                  <div class="form-row">
                    <tag:formField2Col name="Mobile Phone" path="mobilephone" dimension="medium" maxlength="20" />
                  </div>
                  <div class="form-row">
                    <tag:formField2Col name="Fax Number" path="workfax" dimension="medium" mand="true" maxlength="20" />
                  </div>
                  <div class="form-row">
                    <tag:formField2Col name="Email" path="workemail" dimension="medium" mand="true" maxlength="50" />
                  </div>
                </spring:nestedPath>
                <spring:nestedPath path="advisor">
                  <div class="form-row last-row">
                    <tag:formField2Col name="Assistant's Email" path="assistantemail" dimension="medium" maxlength="50" />
                  </div>
                </spring:nestedPath>
              </div>
              <br class="clear"/>
            </div>
          </div>
          
          <br class="clear"/>
          
          <h2>Adviser Firm</h2>
          
          <spring:nestedPath path="advisor.advisorfirm.company">
            <div class="form-group">
              <div class="two-columns">
                <div class="first-column">
                  <div class="form-row">
                    <tag:formField2Col name="Adviser Firm Name" path="name" dimension="medium" mand="true" maxlength="80" readonly="${advisor.advisorfirm.company.type == 'PROVIDER' ? 'true' : ''}" />
                  </div>
                  <div class="form-row last-row">
                    <tag:formField2Col name="ABN" path="abn" dimension="medium" maxlength="11" />
                  </div>
                </div>
                <div class="second-column">
                  <div class="form-row">
                    <tag:formField2Col name="Postal Address" path="address1" dimension="medium" mand="true" maxlength="32" />
                  </div>
                  <div class="form-row">
                    <tag:formField2Col name="Suburb" path="suburb" dimension="small" mand="true" maxlength="25" />
                  </div>
                  <div class="form-row">
                    <spring:bind path="state">
                      <label>State <span class="mandatoryField"># <c:out value="${status.errorMessage}" /></span></label>
                      <select name='<c:out value="${status.expression}"/>' class="short">
                        <c:forEach items="${states}" var="opt">
                          <option value='<c:out value="${opt}"/>' 
                            <c:if test="${opt == status.value}">selected</c:if> />
                            <c:out value="${opt}" />
                          </option>
                        </c:forEach>
                      </select>
                    </spring:bind>
                    <br class="clear"/>
                  </div>
                  <div class="form-row last-row">
                    <tag:formField2Col name="Post Code" path="postcode" dimension="veryShort" mand="true" maxlength="4" />
                  </div>
                </div>
                <br class="clear"/>
              </div>
            </div>
          </spring:nestedPath>
          
          <p class="foot-note"><span style="color: red;">#</span> Denotes a Mandatory Field</p>
          
          <hr class="clear"/>
      
          <div class="button-row">
            <input name="next" type="submit" class="button" value="Save and Return" />
            
            <br class="clear"/>
          </div>
        </form:form>
      </div>
      
      <jsp:include flush="true" page="/WEB-INF/jsp/includes/footer.jsp"/>

    </div>
  </body>
</html>

