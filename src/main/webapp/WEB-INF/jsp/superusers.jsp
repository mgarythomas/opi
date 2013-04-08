<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt1" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<spring:nestedPath path="superuser">
  <c:if test="${!superuser.authorized}">
    <c:redirect url="/advisorapplications.htm" />
  </c:if>
</spring:nestedPath>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
  <head>
    <title>Superuser</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
  
    <jsp:include flush="true" page="/WEB-INF/jsp/includes/scripts_and_styles.jsp"/>
    
    <script type="text/javascript">
      
      function doRefresh()
      {
      	var refreshId = document.getElementById('refreshId');
      	refreshId.value=1;
      	submitForm('superusersForm');
      }
      
      function setinvestorindex(i)
      {
         var investorIndex = document.getElementById('investorindexId');
         investorIndex.value=i;
      
      //   var investorkeyVar = document.getElementById('investorkeyId');
      //   var investorkeyDwr = dwr.util.getValue("investorkey");
      //   investorkeyVar.value=investorkeyDwr;
      }
      
      function removeApplication (s,n)
      {
          var index = document.getElementById('index');
          index.value=s;
          var r=confirm("Do you really wish to delete draft application "+n+"?");
          if (r==true)
      	submitForm('superusersForm');
      else
          index.value="";
      }
      
      function showPdf(id)
      {
        width = 400;
        height = 600;
        left = 390;
        if (screen)
        {
          width = screen.width/2;
          left = screen.width/2-10;
          height = screen.height*0.95;
        }
        
        mywindow = window.open ("/opi/pixml.pdf?applicationId="+id, id, "toolbar=no,location=no,resizable=yes,menubar=no,status=no,scrollbars=yes,width=800,height=800,left=0,top=0");
      }
      
      function forward(id) {
        var idval = id;
        var transadvisorid = dwr.util.getValue("transadvisorId");
        document.getElementById('createId').disabled=true;
      	  Opi.getInclude(transadvisorid, function(data) {
      	    dwr.util.setValue("forward", data, { escapeHtml:false });
      	  });
      }
      
      function advisorapps(id) {
        var idval = id;
        var transadvisorid = dwr.util.getValue("transadvisorId");
      	  Opi.getApplicationTable(transadvisorid, function(data) {
      	    dwr.util.setValue("advisorapps", data, { escapeHtml:false });
      	  });
      }
      
      function enableCreate() {
        // We don't care about the advisorIndex really ...
        // var selectAdvisorIndex = document.getElementById("transadvisorId").selectedIndex;
        
        var selectInvestorIndex = document.getElementById("transadvisor.transinvestortype").selectedIndex;
        var selectProductIndex = document.getElementById("selectProduct").selectedIndex;
        
        if (selectInvestorIndex == 0 || selectProductIndex == 0) {
          document.getElementById('createId').disabled = true;
        } else {
          document.getElementById('createId').disabled = false;
        }
      }
      
      function disableCreate() {
        document.getElementById('createId').disabled = true;
      }
      
      
      <c:if test="${!empty param.showPdf}">
        showPdf(${param.showPdf});
      </c:if>
    </script>
  </head>
  
  <body onload="disableCreate();">
    <div id="wrapper">
      <jsp:include flush="true" page="/WEB-INF/jsp/includes/header.jsp"/>

      <!-- content -->
      <div id="content">
        <div class="breadcrumb-left">
          <c:if test="${sessionTheme == 'hfa'}">
            <a title="Open Credit Calculator Spreadsheet" href="/opi/images/Octane Global Credit Calculator Ver 1.0.xls">&gt; Credit Calculator</a>
            <a title="Open Cash Flow Calculator Spreadsheet" href="/opi/images/Octane Global cash flow calculator v3.xls">&gt; Cashflow Calculator</a>
          </c:if>
          <c:if test="${sessionTheme != 'hfa'}">
            &#160;
          </c:if>
        </div>
        <div class="breadcrumb-right">
          <a title="Logout of OPI" href="<c:url value="/j_spring_security_logout"/>">&gt;Logout</a>
          <a title="Show help page" href="javascript:ShowWinContact();%20void(0);">&gt;Help</a>
        </div>
        
        <br class="clear"/>
        
        <h1>Summary</h1>
        
        <jsp:include flush="true" page="/WEB-INF/jsp/includes/errors_and_messages.jsp"/>

        <form id="superusersForm" method="post"> 
          <input type="hidden" id="refreshId" name="refresh" value="false" />
          <input type="hidden" id="index" name="removeId" value="null" />
          <input type="hidden" id="investorindexId" name="investorindex" value="-1" />
          <input type="hidden" id="investorkeyId" name="investorkey" value="-1" />

          <h2>Create Applications for Advisers</h2>
          
          <div id="create-application-super">
            <spring:nestedPath path="superuser">
              <label for="transadvisorId">Select Adviser</label>
              <spring:bind path="transadvisorId">
                <select id="transadvisorId" onchange="forward(this.selectedIndex); advisorapps(this.selectedIndex); enableCreate();" name="<c:out value="${status.expression}"/>" class="attached" style="width: 200px;">
                  <c:forEach items="${advisors}" var="opt">
                    <option value='<c:out value="${opt.key}"/>'
                      <c:if test="${opt.key == status.value}"><c:set var="myid" value="${opt.key}"/>selected</c:if> />
                      <c:out value="${opt.value}" />                                
                    </option>
                  </c:forEach>
                </select>
              </spring:bind>
              
              <spring:bind path="transadvisor.transinvestortype">
                <div id="forward">
                  <jsp:include flush="false" page="/WEB-INF/jsp/investorselect.jsp"/>
                </div>
              </spring:bind>
              
              <label for="selectProduct" class="attached">Select Product</label>
              <spring:bind path="transadvisor.transproductname">
                <select id="selectProduct" onchange="enableCreate();" name="<c:out value="${status.expression}"/>" class="attached auto">
                  <option>Select Product</option>
                  <c:forEach items="${products}" var="opt">
                    <option value='<c:out value="${opt.id}"/>'
                      <c:if test="${opt.name == status.value}">selected</c:if> />
                      <c:out value="${opt.name}" />
                    </option>
                  </c:forEach>
                </select>
              </spring:bind>
              
              <button type="submit" id="createId" value="Create" class="attached">Create</button>
            </spring:nestedPath>
            
            <br class="clear"/>
          </div>

          <!-- START ADVISOR APPS. SECTION -->
          <div id="advisorapps">
          	<%@ include file="/WEB-INF/jsp/applicationtable.jsp"%>
          </div>
        </form>
      
      </div>
      
      <jsp:include flush="true" page="/WEB-INF/jsp/includes/footer.jsp"/>

    </div>
  </body>
</html>