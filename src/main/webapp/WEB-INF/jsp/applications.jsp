<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt1" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
  <head>
    <title>OPI - Application Summary</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
  
    <jsp:include flush="true" page="/WEB-INF/jsp/includes/scripts_and_styles.jsp"/>
    
    <script type="text/javascript">
      <!-- //
        function initialise() {
          <spring:nestedPath path="advisor">
            init('${advisor.id}','${advisor.advisorfirm.id}')
          </spring:nestedPath>
        }
        
        var cache = { };
        var advCache = { };
        var viewed = -1;
        var names = { };
        var j = 0;
        var statuses = { }; //"Draft", "Submitted", "Processing", "Information Required", "Conditional Approval", "Approved", "Rejected", "Withdrawn", "Cancelled"};
        
        function init(advisorid, advisorfirmid) {
          clearApplication();
          fillAdvisornames(advisorid, advisorfirmid);
          DWRUtil.addOptions("statuslist", statuses);
          fillTable(advisorid);
        }
        
        function update(names) {
        //  alert("j="+j);
          if (j > 1) {
            createList(names);
            $("num").style.display="";
          } //else
        }
        
        function createList(data) {
          DWRUtil.removeAllOptions("numlist");
          DWRUtil.addOptions("numlist", data);
        }
        
        function disableButtons() {
          document.getElementById('Save').disabled=true;
        //  document.getElementById('Clear').disabled=true;
          $("num").style.display="none";
        }
        
        function enableButtons() {
          $("Save").disabled=false;
          $("Clear").disabled=false;
        //  $("num").style.display="";
        }
        
        function fillAdvisornames(advisorid, advisorfirmid) {
        //    alert("advisorfirmid="+advisorfirmid);
            
        //    names[0] = "dummy";
        //    statuses[0] = "Draft";
        //    statuses[1] = "Submitted";
        //    statuses[2] = "Processing";
        //    statuses[3] = "Information Required";
        //    statuses[4] = "Conditional Approval";
        //    statuses[5] = "Approved";
        //    statuses[6] = "Rejected";
        //    statuses[7] = "Withdrawn";
        //    statuses[8] = "Cancelled";
            Opi.getDwradvisors(advisorfirmid, function(advs) {
        
            var adv, id;
        //    alert("adv.length="+advs.length);
            j = 0
            for (var i = 0; i < advs.length; i++) {
              adv = advs[i];
              id = adv.dbid;
              if ( id != advisorid ) {
        //        if (i == 0)
        //          names[0] = "";
        //        else {
                  if (i == 0)
                    names[0] = "";
                  else
                    names[j] = adv.fullname;
                  advCache[j] = adv;
                  j++;
                } 
        //        else
        //          alert("i="+i+" adv.dbid="+adv.dbid+" adv.fullname="+adv.fullname+" advisorid="+advisorid);  
            }
          });
        }
        
        function fillTable(advisorid) {
            Opi.getDwrapplications(advisorid, function(apps) {
            // Delete all the rows except for the "pattern" row
            dwr.util.removeAllRows("appbody", { filter:function(tr) { return (tr.id != "pattern"); } } );
            
            // Create a new set cloned from the pattern row
            var app, id;
            for (var i = 0; i < apps.length; i++) {
              app = apps[i];
              id = app.id;
        
              dwr.util.cloneNode("pattern", { idSuffix:id });
              dwr.util.setValue("tableName" + id, app.name);
              dwr.util.setValue("tableType" + id, app.type);
              dwr.util.setValue("tableAmount" + id, app.amount);
              dwr.util.setValue("tableProduct" + id, app.product);
              dwr.util.setValue("tableStatus" + id, app.status);
              dwr.util.setValue("tableDisplaystatus" + id, app.displaystatus);
              if ($("pattern" + id) != null) {
                $("pattern" + id).style.display = "";
              } 
              if (i == apps.length - 1) {
                // set class to last-row
                document.getElementById("tdName" + id).className = "last-row";
                document.getElementById("tdType" + id).className = "last-row";
                document.getElementById("tdProduct" + id).className = "last-row";
                document.getElementById("tdStatus" + id).className = "last-row";
                document.getElementById("tdAmount" + id).className = "last-row";
                document.getElementById("tdOptions" + id).className = "last-row";
              }
              
              cache[id] = app;
              
              document.getElementById("initialWaitMessage").style.display = "none";
              document.getElementById("tableApplicationSummary").style.display = "";
            }
          });
        }
        
        function editClicked(eleid) {
          // we were an id of the form "edit{id}", eg "edit42". We lookup the "42"
        //  alert(eleid.substring(4));
          var adv = cache[eleid.substring(4)];
          dwr.util.setValues(adv);
          update(names);
          enableButtons();
        }
        
        function deleteClicked(advisorid, eleid) {
          // we were an id of the form "delete{id}", eg "delete42". We lookup the "42"
          var app = cache[eleid.substring(6)];
          if (confirm("Are you sure you want to delete " + app.name + "?")) {
        // TODO : don't offer this big gun unless sure the users can handle it!
            dwr.engine.beginBatch();
        //    alert(dg.afsl);
            Opi.removeDwrapplication(app.dbid);
            fillTable(advisorid);
            dwr.engine.endBatch();
            clearApplication(advisorid)
          }
        }
        
        function writeApplication(advisorid) {
          var app = { id:viewed, dbid:-1, name:null, amount:null, product:null, displaystatus:null, status:null };
        //  alert("advisorid="+advisorid);
          dwr.util.getValues(app);
        
          dwr.engine.beginBatch();
        //  alert("advisorfirmid="+advisorfirmid+"username="+adv.username+" adv.firstname="+adv.lastname+" adv.lastname="+adv.firstname+" adv.workemail="+adv.workemail+" adv.assistantname="+adv.assistantname);
          Opi.storeDwrapplication(advisorid, app, function(errors) {
            dwr.util.setValue(errors);
            if (errors != null)
              alert(errors);
            else {
              fillTable(advisorid);
              clearApplication(advisorid)
            }
          });
          dwr.engine.endBatch();
        }
        
        function clearApplication(advisorid) {
          viewed = -1;
          dwr.util.setValues({ id:-1, dbid:-1, name:null, type:null, amount:null, product:null, displaystatus:null, status:null });
          DWRUtil.removeAllOptions("numlist");
          disableButtons();
        }
        
        function moveApplication(advisorid) {
          var toadvisor = dwr.util.getValue("toadvisor");
        //  alert(toadvisor);
          if (toadvisor != 0) {
            var app = { id:viewed, dbid:-1, name:null, type:null, amount:null, product:null, displaystatus:null, status:null };
            dwr.util.getValues(app);
          //  alert("toadvisor="+toadvisor+" advisorid="+advisorid+" app.name="+app.name+" toadvisor.dbid="+advCache[toadvisor].dbid);
            dwr.engine.beginBatch();
          //  Opi.storeMoveDwradvisor(advisorfirmid, adv, cache[toadvisor].dbid);
            Opi.storeMoveDwrapplication(advisorid, app, advCache[toadvisor].dbid, function(errors) {
              if (errors != null)
                alert(errors);
              else {
                fillTable(advisorid);
                clearApplication(advisorid)
              }
            });
          
            dwr.engine.endBatch();
          }
        }
        
        function goBack(advisorid) {
        //  alert(advisorid);
          document.getElementById('advisorid').value=advisorid;
          submitForm('applicationsForm');
        }

      // -->
    </script>
  </head>
  
  <body onload="initialise();">
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
        
        <spring:nestedPath path="advisor">
          <h1>Advisor : <c:out value='${advisor.individual.fullname}'/></h1>
        </spring:nestedPath>
        
        <jsp:include flush="true" page="/WEB-INF/jsp/includes/errors_and_messages.jsp"/>
        
        <form:form id="applicationsForm">
          <input type="hidden" id="advisorid" name="advisorid"/>
          <input type="hidden" id="errors" name="errors" />
          
          <h2>Application</h2>
          
          <div class="form-group">
            <div class="two-columns">
              <div class="first-column">
                <div class="form-row last-row">
                  <tag:noSpring2Col id="name" name="Designate" path="name" dimension="medium" mand="true" maxlength="30" />
                  <tag:noSpring2Col id="dbid" name="Dbid" type="hidden" path="dbid" dimension="medium" mand="true" maxlength="6" />
                </div>
                <div class="form-row last-row" id="num" style="display:none;">
                  <label id="toadvisorlabel" for="numlist">Associate Application with</label>
                  <select name="toadvisor" id="numlist">
                  </select>
                  <spring:nestedPath path="advisor">
                    <input id="Move" title="Move" type="button" value="Save & Move" class="button" onclick="moveApplication('${advisor.id}')"/>
                  </spring:nestedPath>              
                </div>
              </div>
              <div class="second-column">
                <div class="form-row last-row">
                  <tag:noSpring2Col id="type" name="Type" type="hidden" path="type" dimension="medium" mand="true" maxlength="30" />
                  <tag:noSpring2Col id="displaystatus" name="displaystatus" type="hidden" path="displaystatus" dimension="medium" maxlength="30" />
                  <label id="statuslabel" for="numlist">Status <span class="red">#</span></label>
                  <select id="status" name="Status">
                    <option value="0"/>Draft</option>
                    <option value="1"/>Submitted</option>
                    <option value="2"/>Processing</option>
                    <option value="3"/>Information Required</option>
                    <option value="4"/>Conditional Approval</option>
                    <option value="5"/>Approved</option>
                    <option value="6"/>Rejected</option>
                    <option value="7"/>Withdrawn</option>
                    <option value="8"/>Cancelled</option>
                  </select>
                  <br class="clear"/>
            		  <tag:noSpring2Col id="product" name="Product" type="hidden" path="product" dimension="medium" mand="true" maxlength="30" />
                </div>
              </div>
            </div>
              
            <br class="clear"/>
          </div>
          
    		  <div class="button-row">
            <spring:nestedPath path="advisor">
              <input id="Save" title="Save" type="button" value="Save" class="button" onclick="writeApplication('${advisor.id}')"/>
              <input id="Clear" title="Clear" type="button" value="Clear" class="button attached" onclick="clearApplication('${advisor.id}')"/>
              <input id="Back" title="Back" type="submit" value="Back" class="button attached" onclick="goBack'${advisor.id}')"/>
              
              <br class="clear"/>
            </spring:nestedPath>              
    		  </div>
            
          <h2>Application Summary</H2>

          <div class="messages" id="initialWaitMessage">
            <p>Please wait.  Loading application summary ...</p>
          </div>
          
          <table class="data" cellspacing="0" id="tableApplicationSummary" style="display: none;">
            <thead>
              <tr>
                <th>Designate</th>
                <th>Type</th>
                <th>Product</th>
                <th>Status</th>
                <th>Amount</th>
                <th style="width: 100px; text-align: center;">Options</th>
              </tr>
            </thead>
            <tbody id="appbody">
              <tr id="pattern" style="display:none; ${s.index % 2 == 1 ? 'background: #f9f9ff;' : ''}">
                <td id="tdName"><span id="tableName">Name</span></td>
                <td id="tdType"><span id="tableType">Type</span></td>
                <td id="tdProduct"><span id="tableProduct">Product</span></td>
                <td id="tdStatus"><span id="tableDisplaystatus">Displaystatus</span></td>
                <td id="tdAmount"><span id="tableAmount">Amount</span></td>
                <td id="tdOptions" style="text-align: center;">
                  <a href="#" id="edit" title="Edit" onclick="editClicked(this.id)">Edit</a>
                  <spring:nestedPath path="advisor">
                    <c:if test="${state == '0'}">
                      |
                      <a href="#" id="delete" title="Remove" onclick="deleteClicked('${advisor.id}',this.id)">Delete</a>
                    </c:if>
                  </spring:nestedPath>
                </td>
              </tr>
            </tbody>
          </table>
        </form:form>
      </div>

      <jsp:include flush="true" page="/WEB-INF/jsp/includes/footer.jsp"/>
      
    </div>
  </body>
</html>
