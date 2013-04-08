<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt1" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
  <head>
    <title>OPI - BDM</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
  
    <jsp:include flush="true" page="/WEB-INF/jsp/includes/scripts_and_styles.jsp"/>
    
    <script type="text/javascript">
      <!-- //
        function preLogout()
        {
            var r=confirm("Click OK to Save changes. Click CANCEL to discard");
            if (r==true) {
              var save = document.getElementById('save');
              save.value=true;
            }
            var logout = document.getElementById('logout');
            logout.value=true;
            submitForm('hfausersForm');
        }
        
        function toggleEditButton() {
          if (document.getElementById("selectBdm").value == "1") {
            document.getElementById("buttonEdit").disabled = true;
          } else {
            document.getElementById("buttonEdit").disabled = false;
          }
        }
      // -->
    </script>
  </head>
  
  <body onload="toggleEditButton();">
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
        
        <h1>BDM Summary</h1>
        
        <jsp:include flush="true" page="/WEB-INF/jsp/includes/errors_and_messages.jsp"/>

      
        <!-- START FORM SECTION -->
        <form id="hfausersForm" method="post">
          <input type="hidden" id="logout" name="logout" value="null" />
          <input type="hidden" id="save" name="save" value="null" />
          
          <h2>Manager BDMs</h2>
          
          <spring:nestedPath path="company">
            <div class="form-group">
              <div class="form-row last-row">
                <label class="auto" for="applicantTitle">Select BDM</label>
                <spring:bind path="transbdmid"> 
                  <select id="selectBdm" onchange="toggleEditButton();" name="<c:out value="${status.expression}"/>" class="attached auto">
                    <option value="1"></option>
                    <c:forEach items="${bdms}" var="opt">
                      <option value="<c:out value="${opt.id}"/>"
                        <c:if test="${opt.id == status.value}">selected</c:if> />
                        <c:out value="${opt.fullname}" />
                      </option>
                    </c:forEach>
                  </select>
                </spring:bind>
                <br class="clear"/>
              </div>
              
              <hr class="clear"/>
              
              <div class="button-row">
                <input name="create" type="submit" value="Create" class="button" />
                <input id="buttonEdit" name="edit" type="submit" value="Edit" class="button" />

                <br class="clear"/>
              </div>
            </div>
              
          </spring:nestedPath>
        
          <br class="clear"/>
          
          <h2>Advisers</h2>
          
          <div id="advisorapps">
            <table class="data" cellspacing="0">
              <thead>
                <tr>
                  <th>Code</th>
                  <th>Adviser Name</th>
                  <th>Adviser Firm</th>
                  <th>Dealer Group</th>
                  <th>State</th>
                  <th>BDM</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="opt" items="${company.advisorprovidersarray}" varStatus="s">
                  <tr class="tableIn" <c:if test="${s.index % 2 == 1}">bgcolor="#f9f9ff"</c:if>>
                    <td class="${s.last ? 'last-row' : ''}">
                      <spring:bind path="company.advisorprovidersarray[${s.count -1}].advisornumber">
                        <input type="text" class="veryShort " maxlength="12" name='<c:out value="${status.expression}"/>'
                          value='<c:out value="${status.value}"/>'>
                      </spring:bind>
                    </td>
                    <td class="${s.last ? 'last-row' : ''}"><c:out value="${opt.advisor.individual.fullname}" /></td>
                    <td class="${s.last ? 'last-row' : ''}"><c:out value="${opt.advisorfirmname}" /></td>
                    <td class="${s.last ? 'last-row' : ''}"><c:out value="${opt.dealergroupname}" /></td>
                    <td class="${s.last ? 'last-row' : ''}"><c:out value="${opt.advisorfirmstate}" /></td>
                    <td class="${s.last ? 'last-row' : ''}">
                      <spring:bind path="company.advisorprovidersarray[${s.count -1}].transbdmid">
                        <select 
                          <c:if test="${(status.value == 1) || (status.value == '')}">
                            style="background: yellow; border: 1px solid blue;" 
                          </c:if>
                          name='<c:out value="${status.expression}"/>'>
                          <option value="1"></option>
                          <c:forEach items="${bdms}" var="opt">
                            <option value='<c:out value="${opt.id}"/>'
                              <c:if test="${opt.id == status.value}">selected</c:if> />
                              <c:out value="${opt.fullname}" />
                            </option>
                          </c:forEach>
                        </select>
                      </spring:bind>
                    </td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>
          
          <hr class="clear"/>
          
          <div class="button-row">
            <input name="associate" type="submit" class="button" value="Save"/>
  
            <br class="clear"/>
          </div>
        </form>

      </div>

      <jsp:include flush="true" page="/WEB-INF/jsp/includes/footer.jsp"/>
      
    </div>
  </body>
</html>
