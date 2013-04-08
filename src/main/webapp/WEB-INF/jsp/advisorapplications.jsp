<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt1" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
  <head>
    <title>OPI - Applications Summary</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
  
    <jsp:include flush="true" page="/WEB-INF/jsp/includes/scripts_and_styles.jsp"/>
    
    <script type="text/javascript">
      <!-- //
      
      function removeApplication (s, n, productId) {
        var removeId = document.getElementById('removeId');
        removeId.value = s;
        document.getElementById('productId').value = productId;
        var r=confirm("Do you really wish to delete draft application "+n+"?");
        if (r==true)
          submitForm('applicationsForm');
        else
          removeId.value="";
      }
      
      function enableCreate() {
        var investorType = document.getElementById("selectInvestor").selectedIndex;
        var productId = document.getElementById("selectProduct").selectedIndex;
        
        if (investorType != 0 && productId != 0) {
          document.getElementById('buttonCreate').disabled = false;
        } else {
          document.getElementById('buttonCreate').disabled = true;
        }
      }
      
      function disableCreate() {
        document.getElementById('buttonCreate').disabled=true;
      }
      
      function setHiddenParams(appId, advId, p, e) {
        document.getElementById('applicationId').value = appId;
        document.getElementById('advisorId').value=advId;
        document.getElementById('productId').value=p;
        document.getElementById('edit').value=e;
        
        submitForm('applicationsForm');
      }
      
      function showPdf(id) {
        width = 400;
        height = 600;
        left = 390;
        if (screen) {
          width = screen.width / 2;
          left = screen.width / 2 - 10;
          height = screen.height * 0.95;
        }
        
        mywindow = window.open ("/opi/pixml.pdf?applicationId="+id, id, "toolbar=no,location=no,resizable=yes,menubar=no,status=no,scrollbars=yes,width=800,height=800,left=0,top=0");
      }
      
      <c:if test="${!empty param.showPdf}">
        showPdf(${param.showPdf});
      </c:if>
      
      // -->
    </script>
  </head>
  
  <body onload="disableCreate();">
    <div id="wrapper">
      <jsp:include flush="true" page="/WEB-INF/jsp/includes/header.jsp"/>

      <!-- content -->
      <div id="content">
        <div class="breadcrumb-left">
          <a title="Edit Adviser" href="./editAdvisor.htm?advisorId=${advisor.id}">&gt; Edit my Adviser Profile</a>
          <c:if test="${sessionTheme == 'hfa'}">
            <a title="Open Credit Calculator Spreadsheet" href="/opi/images/Octane Global Credit Calculator Ver 1.0.xls">&gt; Credit Calculator</a>
            <a title="Open Cash Flow Calculator Spreadsheet" href="/opi/images/Octane Global cash flow calculator v3.xls">&gt; Cashflow Calculator</a>
          </c:if>
        </div>
        <div class="breadcrumb-right">
          <a title="Logout of OPI" href="<c:url value="/j_spring_security_logout"/>">&gt;Logout</a>
          <a title="Show help page" href="javascript:ShowWinContact();%20void(0);">&gt;Help</a>
        </div>
        
        <br class="clear"/>
        
        <h1>Summary</h1>
        
        <jsp:include flush="true" page="/WEB-INF/jsp/includes/errors_and_messages.jsp"/>

        <form id="applicationsForm" method="post">
          <spring:nestedPath path="advisor">
            <h2>Create Application</h2>
            
            <div class="create-application">
              <label for="selectInvestor" id="labelSelectInvestor">Select Investor</label>
              
              <spring:bind path="transinvestortype">
                <select name="<c:out value="${status.expression}"/>" id="selectInvestor" onchange="enableCreate();">
                  <option value="-1">Select Investor</option>
                  <option value="0">New Individual</option>
                  <option value="1">New Joint Individual</option>
                  <option value="2">New Corporate</option>
                  <option value="3">New Individual Trust</option>
                  <option value="4">New Corporate Trust</option>
                  <c:forEach items="${filteredApplicationsUnique}" var="application">
                    <option value="<c:out value="${application.id}"/>">
                      <c:out value="${application.accountdesignation}" />
                    </option>
                  </c:forEach>
                </select>
              </spring:bind>
              
              <label for="selectProduct" id="labelSelectProduct">Select Product</label>
  
              <spring:bind path="transproductname">
                <select name="<c:out value="${status.expression}"/>" id="selectProduct" onchange="enableCreate();">
                  <option>Select Product</option>
                  <c:forEach items="${products}" var="product">
                    <option value="<c:out value="${product.id}"/>">
                      <c:out value="${product.name}" />
                    </option>
                  </c:forEach>
                </select>
              </spring:bind>
              
              <button type="submit" id="buttonCreate" value="Create">Create Application</button>
  
              <br class="clear"/>
            </div>
            
            <input type="hidden" id="removeId" name="removeId" value="null" />
            <input type="hidden" id="applicationId" name="applicationId" value="null" />
            <input type="hidden" id="advisorId" name="advisorId" value="null" />
            <input type="hidden" id="productId" name="productId" value="null" />
            <input type="hidden" id="edit" name="edit" value="null" />
          </spring:nestedPath>
        </form>

        <br class="clear"/>

        <h2>My Applications</h2>
        
        <table cellspacing="0" class="data">
          <thead>
            <tr>
              <th>Account Designation</th>
              <th>Product Name</th>
              <th>Application Type</th>
              <th>Application Amount</th>
              <th>Application Status</th>
              <th>Payment Status</th>
              <th style="width: 100px; text-align: center;">Options</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="opt" items="${filteredApplications}" varStatus="s">
              <tr style="${s.index % 2 == 1 ? 'background: #f9f9ff;' : ''}">
                <td class="${s.last ? 'last-row' : ''}"><c:out value="${opt.accountdesignation}"/></td>
                <td class="${s.last ? 'last-row' : ''}"><c:out value="${opt.productname}" /></td>
                <td class="${s.last ? 'last-row' : ''}"><c:out value="${opt.displaypaymentmethod}"/></td>
                <td class="${s.last ? 'last-row' : ''}">
                  <fmt1:formatNumber value="${opt.totalamount}" type="currency" currencySymbol="$" maxFractionDigits="0" />
                </td>
                <td class="${s.last ? 'last-row' : ''}"><c:out value="${opt.displaystatus}" /></td>
                <td class="${s.last ? 'last-row' : ''}">
            			<c:choose>
            				<c:when test="${opt.displaypaymentstatus == 'Query'}">
            				  <a title="Show Contact details" href="javascript:ShowWinContact();%20void(0);"><c:out value="${opt.displaypaymentstatus}" /></a>
            				</c:when>
            				<c:otherwise>
            				  <c:out value="${opt.displaypaymentstatus}" />
            				</c:otherwise>
            			</c:choose>
                </td>
                <td class="${s.last ? 'last-row' : ''}" style="text-align: center;">
                  <c:choose>
                    <c:when test="${ (opt.status > 0) }">
                       <c:choose>
                         <c:when test="${opt.status != 7}">
                           <a href="#" title="Show PDF" onclick="showPdf('${opt.id}')">View PDF</a>
                         </c:when>
                         <c:otherwise>
                           <!--  status is widthdrawn -->
                           &nbsp;
                         </c:otherwise>
                        </c:choose>
                    </c:when>
                    <c:otherwise>
                      <!-- <a href="#" title="Edit Application" onclick="setHiddenParams('${opt.id}','${advisor.id}','${opt.product.id}', 'true')">Edit</a> -->
                      <a href="addAdvisorapplication.htm?applicationId=${opt.id}&edit=true" title="Edit Application">Edit</a>
                      |
                      <!-- <a href="#" title="Delete Application" onclick="removeApplication('${opt.id}','${opt.accountdesignation}', '${opt.product.id}')">Delete</a> -->
                      <a href="deleteapplication.htm?applicationId=${opt.id}" title="Delete Application" onclick="return confirm('Delete draft application ${opt.accountdesignation}?');">Delete</a>
                    </c:otherwise>
                  </c:choose>
                </td>
              </tr>
            </c:forEach>
          </tbody>
        </table>

      </div>

      <jsp:include flush="true" page="/WEB-INF/jsp/includes/footer.jsp"/>
      
    </div>
  </body>
</html>
