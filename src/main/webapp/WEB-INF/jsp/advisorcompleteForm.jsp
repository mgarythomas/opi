<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt1" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<spring:nestedPath path="advisor">
  <c:if test="${advisor.id == -1}">
    <c:redirect url="/emailsent.htm?email=${individual.workemail}" />
  </c:if>
  <c:if test="${advisor.id == -2}">
    <c:redirect url="/forgotpassword.htm?login_error=1"/>
  </c:if>
</spring:nestedPath>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
  <head>
    <title>OPI - Adviser Details</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
  
    <jsp:include flush="true" page="/WEB-INF/jsp/includes/scripts_and_styles.jsp"/>
    
    <script type="text/javascript">
      <!--//
//         function IsNumeric(input){
//           var RE = /^-{0,1}\d*\.{0,1}\d+$/;
//          return (RE.test(input));
//        }
        
        function checkEmail()
        {
          var attr = document.getElementById('advisoremail');
          var r=confirm("Are you sure your email address is : "+attr.value+"?");
          if (r==false) {
            attr.focus();
            attr.select();
          }
        }
        
        function disableDg()
        {
//          alert("dg_name = "+document.getElementById('name').value);
          var dg_name = document.getElementById('name').value;
          if (dg_name != "") {
            document.getElementById('afsl').disabled=true;
            document.getElementById('abn').disabled=true;
            document.getElementById('name').disabled=true;
          }
        }
        
        function enableDg()
        {
          document.getElementById('afsl').disabled=false;
          document.getElementById('abn').disabled=false;
          document.getElementById('name').disabled=false;
        //  alert("enable Dg");
        }
        
        function enableAll()
        {
          enableDg();
          enableAf();
        //  submit('advisorFrm');
        }
        
        function clearDg()
        {
          clearAf();
          enableDg();
          document.getElementById('afsl').value="";
          document.getElementById('abn').value="";
          document.getElementById('name').value="";
          document.getElementById('afsl').focus();
//          alert("zeroed DG and refocussed to afsl");
        }
        
        function clearAf()
        {
          document.getElementById('afabn').value="";
          document.getElementById('afname').value="";
          document.getElementById('address1').value="";
          document.getElementById('suburb').value="";
          document.getElementById('state').value="";
          document.getElementById('postcode').value="";
          document.getElementById('afabn').disabled=false;
          document.getElementById('afabn').focus();
        //  alert("cleared Af");
        }
        
        function findDealergroup() {
          var afsl = dwr.util.getValue("afsl");
//          alert("in findDealergroup afsl = "+afsl);
//          if IsNumeric(afsl)
            Opi.fillDealergroup(afsl, findAfsl);
        }
        
        function findAfsl(dgc) {
          enableDg();
          dwr.util.setValues(dgc);
        //  alert("findAfsl : DG name ="+dgc.name);
          if (dgc.name == null)
          {
        //    alert("entered dgc.name null");
            document.getElementById('afsl').disabled=false;  
            document.getElementById('afsl').focus();
          }
          else
          {
        //    alert("entered dgc.name not null");
        
            document.getElementById('afsl').disabled=true;
            document.getElementById('abn').disabled=true;
            document.getElementById('name').disabled=true;
        
            document.getElementById('afabn').disabled=false;
            document.getElementById('afabn').focus();
          }
        }
        
        function disableAf()
        {
          var afname = document.getElementById('afname').value;
          if (afname != "") {
            document.getElementById('afabn').disabled=true;
            document.getElementById('afname').disabled=true;
            document.getElementById('address1').disabled=true;
            document.getElementById('suburb').disabled=true;
            document.getElementById('state').disabled=true;
            document.getElementById('postcode').disabled=true;
          }
        }
        
        function enableAf()
        {
          document.getElementById('afabn').disabled=false;
          document.getElementById('afname').disabled=false;
          document.getElementById('address1').disabled=false;
          document.getElementById('suburb').disabled=false;
          document.getElementById('state').disabled=false;
          document.getElementById('postcode').disabled=false;
        //  alert("enable Af");
        }
        
        function findAdvisorfirm(inabn) {
          var afsl = dwr.util.getValue("afsl");
          var afabn = dwr.util.getValue("afabn");
          
          if (afsl != "" && afabn != "") {
            Opi.fillAdvisorfirm(afsl, afabn, findAfAbn);
          }
        
        }
        
        function findAfAbn(afc) {
          dwr.util.setValues(afc);
        
          if (afc.afname == null) {
            enableAf();
            document.getElementById('afname').focus();
          } else {
            document.getElementById('title').focus();
          }
        }
      //-->
    </script>

  </head>
  
  <body onload="document.getElementById('afsl').focus();">
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
        
        <h1>Adviser Details</h1>
        
        <jsp:include flush="true" page="/WEB-INF/jsp/includes/errors_and_messages.jsp"/>
        
        <form id="advisorFrm" name="individualDetailFrm" method="post">
          <h2>Dealer Group</h2>
          
          <div class="form-group">
            <spring:nestedPath path="advisor.advisorfirm.dealergroup">
              <div class="two-columns">
                <div class="first-column">
                  <div class="form-row">
                    <tag:formField2Col id="afsl" name="AFSL" path="afsl" dimension="small" mand="true" maxlength="6" onblur="findDealergroup();disableDg()" />
                  </div>
                  <div class="form-row last-row">
                    <tag:formField2Col id="name" name="Dealer Group Name" path="displayname" dimension="medium" mand="true" maxlength="30" />
                  </div>
                </div>
                <div class="second-column">
                  <div class="form-row last-row">
                    <tag:formField2Col id="abn" name="ABN" path="displayabn" dimension="medium" mand="true" maxlength="11" />
                  </div>
                </div>
              </div>
            </spring:nestedPath>
            <br class="clear"/>
            
            <div class="button-row">
              <button type="button" onclick="clearDg();" name="clear">Clear</button>
              
              <br class="clear"/>
            </div>
          </div>
          
          <hr class="clear"/>
          
          <h2>Adviser Firm</h2>
          
          <div class="form-group">
            <div class="two-columns">
              <div class="first-column">
                <spring:nestedPath path="advisor.advisorfirm">
                  <div class="form-row">
                    <tag:formField2Col id="afabn" name="ABN" path="afabn" dimension="medium" onblur="findAdvisorfirm(this.value);disableAf()" maxlength="11"/> <%-- onblur="findAdvisorfirm(this.value)" --%> 
                  </div>
                  <div class="form-row last-row">
                    <tag:formField2Col id="afname" name="Adviser Firm Name" path="afname" dimension="medium" mand="true" maxlength="80" />
                  </div>
                </spring:nestedPath>
              </div>
              <div class="second-column">
                <spring:nestedPath path="advisor.advisorfirm.company">
                  <div class="form-row">
                    <tag:formField2Col id="address1" name="Postal Address" path="address1" dimension="medium" mand="true" maxlength="32" />
                  </div>
                  <div class="form-row">
                    <tag:formField2Col id="suburb" name="Suburb" path="suburb" dimension="small" mand="true" maxlength="25" />
                  </div>
                  <div class="form-row">
                    <spring:bind path="state">
                      <label for="applicantMiddle">State <span class="red">#&nbsp;<c:out value="${status.errorMessage}" /></span></label>
                      <select id="state" name='<c:out value="${status.expression}"/>'>
                        <c:forEach items="${states}" var="opt">
                          <option value='<c:out value="${opt}"/>' <c:if test="${opt == status.value}">selected</c:if> /><c:out value="${opt}" /></option>
                        </c:forEach>
                      </select>
                      <br class="clear"/>
                    </spring:bind>
                  </div>
                  <div class="form-row last-row">
                    <tag:formField2Col id="postcode" name="Post Code" path="postcode" dimension="veryShort" mand="true" maxlength="4" />
                  </div>
                </spring:nestedPath>
              </div>
            </div>
            <br class="clear"/>
            
            <div class="button-row">
              <button type="button" onclick="enableAf(); clearAf();" name="clear">Clear</button>
              
              <br class="clear"/>
            </div>
          </div>
          
          <hr class="clear"/>
          
          <h2>Adviser</h2>
          
          <div class="form-group">
            <div class="two-columns">
              <div class="first-column">
                <div class="form-row">
                  <spring:nestedPath path="advisor.individual">
                    <label for="title">Title</label>
                    <spring:bind path="title">
                      <select id="title" name='<c:out value="${status.expression}"/>'>
                        <c:forEach items="${titles}" var="opt">
                          <option value='<c:out value="${opt}"/>' <c:if test="${opt == status.value}">selected</c:if> /><c:out value="${opt}" /></option>
                        </c:forEach>
                      </select>
                    </spring:bind>
                    <br class="clear"/>
                  </spring:nestedPath>
                </div>
                <div class="form-row">
                  <spring:nestedPath path="advisor.individual">
                    <tag:formField2Col id="firstname" name="Adviser First Name" path="firstname" dimension="medium" mand="true" maxlength="24" />
                  </spring:nestedPath>
                </div>
                <div class="form-row">
                  <spring:nestedPath path="advisor.individual">
                    <tag:formField2Col id="lastname" name="Adviser Last name" path="lastname" dimension="medium" mand="true" maxlength="24" />
                  </spring:nestedPath>
                </div>
                <div class="form-row last-row">
                  <spring:nestedPath path="advisor">
                    <tag:formField2Col id="assistantname" name="Assistant Name" path="assistantname" dimension="medium" maxlength="40" />
                  </spring:nestedPath>
                </div>
              </div>
              <div class="second-column">
                <spring:nestedPath path="advisor.individual">
                  <div class="form-row">
                    <tag:formField2Col id="workphone" name="Adviser Work Phone" path="workphone" dimension="medium" mand="true" maxlength="20" />
                  </div>
                  <div class="form-row">
                    <tag:formField2Col id="mobilephone" name="Adviser Mobile Phone" path="mobilephone" dimension="medium" maxlength="20" />
                  </div>
                  <div class="form-row">
                    <tag:formField2Col id="workfax" name="Adviser Fax Number" path="workfax" dimension="medium" mand="true" maxlength="20" />
                  </div>
                  <div class="form-row">
                    <tag:formField2Col id="advisoremail" name="Adviser Email" path="workemail" dimension="medium" mand="true" maxlength="50" /> <%--  onblur='checkEmail()' --%>
                  </div>
                </spring:nestedPath>
                <spring:nestedPath path="advisor">
                  <div class="form-row last-row">
                    <tag:formField2Col id="assistantemail" name="Assistant's Email" path="assistantemail" dimension="medium" maxlength="50" />
                  </div>
                </spring:nestedPath>
              </div>
            </div>
            
            <br class="clear"/>
            
            <p class="normal"><strong>EMAIL :</strong>
              <br/>
              Please note that the Adviser Email and Assistant's Email address will be used to communicate information about the status of each application. Please leave the Assistant's
              Email field blank if you do not want client information and queries copied to your assistant.
            </p>
          </div>
          
          <br class="clear"/>
          
          <div class="button-row">
            <button type="submit" onclick="enableAll();">Proceed</button>
            
            <br class="clear"/>
          </div>
        </form>
      </div>
      
      <jsp:include flush="true" page="/WEB-INF/jsp/includes/footer.jsp"/>

    </div>
  </body>
</html>