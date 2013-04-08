<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt1" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
  <head>
    <title>OPI - Advisor Firm Summary</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
  
    <jsp:include flush="true" page="/WEB-INF/jsp/includes/scripts_and_styles.jsp"/>
    
    <script type="text/javascript">
      <!-- //
        function initialise() {
          <spring:nestedPath path="advisorfirm">
            init('${advisorfirm.id}');
          </spring:nestedPath>
        }
      
        var names = { };
        var cache = {};
        var moveCache = {};
        var viewed = -1;
        var advsSize = -1;
        
        function init(advisorfirmid) {
        //  DWRUtil.useLoadingMessage();
          clearAdvisor();
        //  disableButtons();
          fillTable(advisorfirmid);
          update(names);
        }
        
        function update(names) {
          createList(names);
        //  Opi.loadNumbers(createList); //, $("bigselect").checked);
        //  DWRUtil.addOptions("numlist", names);
        //  alert("executed loadNumbers");
        }
        
        function createList(data) {
          DWRUtil.removeAllOptions("numlist");
          DWRUtil.addOptions("numlist", data);
        }
        
        function disableButtons() {
        //  document.getElementById('Save').disabled=true;
        //  document.getElementById('Clear').disabled=true;
          $("Applications").disabled=true;  
          $("num").style.display="none";
        }
        
        function enableButtons() {
          $("Save").disabled=false;
          $("Clear").disabled=false;
        //  $("Applications").disabled=false;
        }
        
        function fillTable(advisorfirmid) {
            Opi.getDwradvisors(advisorfirmid, function(advs) {
            // Delete all the rows except for the "pattern" row
            dwr.util.removeAllRows("advbody", { filter:function(tr) { return (tr.id != "pattern"); } } );
            
            // Create a new set cloned from the pattern row
            var adv, id;
            names = {}; // clear list
            for (var i = 0; i < advs.length; i++) {
              adv = advs[i];
              id = adv.id;
        
              dwr.util.cloneNode("pattern", { idSuffix:id });

              dwr.util.setValue("tableFullname" + id, adv.fullname);
              dwr.util.setValue("tableUsername" + id, adv.username);
              dwr.util.setValue("tableAssistantname" + id, adv.assistantname);
              dwr.util.setValue("tableAssistantemail" + id, adv.assistantemail);
              dwr.util.setValue("tableWorkemail" + id, adv.workemail);
              if (adv.doesnothaveapplications == false) {
                if (document.getElementById("delete" + id) != null) {
                  document.getElementById("delete" + id).style.display = "none";
                  document.getElementById("pipe" + id).style.display = "none";
                }
              }
              if ($("pattern" + id) != null) {
                $("pattern" + id).style.display = "";
              } 
              if (i == advs.length - 1) {
                // set class to last-row
                document.getElementById("tdName" + id).className = "last-row";
                document.getElementById("tdUsername" + id).className = "last-row";
                document.getElementById("tdEmail" + id).className = "last-row";
                document.getElementById("tdAssistantName" + id).className = "last-row";
                document.getElementById("tdAssistantEmail" + id).className = "last-row";
                document.getElementById("tdOptions" + id).className = "last-row";
              }
        
              advsSize = advs.length
              cache[id] = adv;
              
              document.getElementById("initialWaitMessage").style.display = "none";
              document.getElementById("tableAdvisorSummary").style.display = "";
            }
          });
        
        }
        
        function editClicked(eleid) {
          // we were an id of the form "edit{id}", eg "edit42". We lookup the "42"
        //  alert(eleid.substring(4));
          var adv = cache[eleid.substring(4)];
          dwr.util.setValues(adv);
        
          names = {};
          moveCache = {};
          var item;
          
        //  alert("adv.fullname="+adv.fullname);
          var j = 0;
          for (var i = 0; i < advsSize; i++) {
            item = cache[i];
        //    alert("item.fullname="+item.fullname);
        //    if (i != 0)
        //      names[j++] = "";
        //    else 
              if ((i != 0) && (item.dbid != adv.dbid)) {
                names[j] = item.fullname;
                moveCache[j++] = item;
              }
          } 
        
          DWRUtil.removeAllOptions("numlist");
          DWRUtil.addOptions("numlist", names);
        //  update(names);
          enableButtons();
          if (adv.doesnothaveapplications == false) {
            $("Applications").disabled=false;
            if (advsSize > 2)  
              $("num").style.display="";
            else
              $("num").style.display="none";
          } else
              $("num").style.display="none";
          
        }
        
        function deleteClicked(advisorfirmid, eleid) {
          // we were an id of the form "delete{id}", eg "delete42". We lookup the "42"
          var adv = cache[eleid.substring(6)];
          if (confirm("Are you sure you want to delete " + adv.fullname + "?")) {
        // TODO : don't offer this big gun unless sure the users can handle it!
            dwr.engine.beginBatch();
        //    alert(dg.afsl);
            Opi.removeDwradvisor(adv.dbid);
            fillTable(advisorfirmid);
            dwr.engine.endBatch();
            clearAdvisor(advisorfirmid)
          }
        }
        
        function writeAdvisor(advisorfirmid) {
          var adv = { id:viewed, dbid:-1, username:null, firstname:null, lastname:null, workemail:null, assistantname:null, assistantemail:null, doesnothaveapplications:true };
        //  alert("advisorfirmid="+advisorfirmid);
          dwr.util.getValues(adv);
        
          dwr.engine.beginBatch();
        //  alert("advisorfirmid="+advisorfirmid+"username="+adv.username+" adv.firstname="+adv.lastname+" adv.lastname="+adv.firstname+" adv.workemail="+adv.workemail+" adv.assistantname="+adv.assistantname);
        //  Opi.storeDwradvisor(advisorfirmid, adv);
          Opi.storeDwradvisor(advisorfirmid, adv, function(errors) {
            dwr.util.setValue(errors);
            if (errors != null)
              alert(errors);
            else {
              fillTable(advisorfirmid);
              clearAdvisor(advisorfirmid)
            }
          });
        //  fillTable(advisorfirmid);
          dwr.engine.endBatch();
        //  clearAdvisor(advisorfirmid)
        }
        
        function clearAdvisor(advisorfirmid) {
          viewed = -1;
          dwr.util.setValues({ id:-1, dbid:-1, username:null, firstname:null, lastname:null, workemail:null, assistantname:null, assistantemail:null, doesnothaveapplications:null });
          DWRUtil.removeAllOptions("numlist");
          disableButtons();
        }
        
        function moveApplications(advisorfirmid) {
          var toadvisor = dwr.util.getValue("toadvisor");
        //  alert("toadvisor="+toadvisor+" adv.name="+cache[toadvisor].fullname+" adv.dbid="+cache[toadvisor].dbid);
          var adv = { id:viewed, dbid:-1, username:null, firstname:null, lastname:null, workemail:null, assistantname:null, assistantemail:null, doesnothaveapplications:true };
        //  alert("advisorfirmid="+advisorfirmid);
          dwr.util.getValues(adv);
          dwr.engine.beginBatch();
        //  Opi.storeMoveDwradvisor(advisorfirmid, adv, cache[toadvisor].dbid);
          Opi.storeMoveDwradvisor(advisorfirmid, adv, moveCache[toadvisor].dbid, function(errors) {
        //    dwr.util.setValue(errors);
            if (errors != null)
              alert(errors);
            else {
              fillTable(advisorfirmid);
              clearAdvisor(advisorfirmid)
            }
          });
        
        //  fillTable(advisorfirmid);
          dwr.engine.endBatch();
        //  clearAdvisor(advisorfirmid)
        }
        
        function showApplications() {
          var adv = { id:viewed, dbid:-1, username:null, firstname:null, lastname:null, workemail:null, assistantname:null, assistantemail:null, doesnothaveapplications:true };
          dwr.util.getValues(adv);
        //  alert("af.dbid="+af.dbid);
          document.getElementById('advisorid').value=adv.dbid;
          var advisorid_var = dwr.util.getValue('dbid');
        //  alert(advisorfirmid_var);
          if (advisorid_var != null)
        //  alert(advisorid_var);
            submitForm('advisorsForm');
        }
        
        function goBack(advisorfirmid) {
          alert(advisorid);
          document.getElementById('advisorfirmid').value=advisorfirmid;
          submitForm('advisorsForm');
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
        
        <spring:nestedPath path="advisorfirm">
          <h1>Advisor Firm : <c:out value='${advisorfirm.company.name}'/></h1>
        </spring:nestedPath>
        
        <jsp:include flush="true" page="/WEB-INF/jsp/includes/errors_and_messages.jsp"/>
        
        <form:form id="advisorsForm">
          <input type="hidden" id="advisorid" name="advisorid"/>
          <input type="hidden" id="errors" name="errors" />
          
          <h2>Advisor</h2>
          
          <div class="form-group">
            <div class="two-columns">
              <div class="first-column">
                <div class="form-row">
                  <tag:noSpring2Col id="username" name="Username" path="username" type="hidden" dimension="medium" mand="true" maxlength="30" />
                  <tag:noSpring2Col id="dbid" name="Dbid" type="hidden" path="dbid" dimension="medium" mand="true" maxlength="6" />
                  <tag:noSpring2Col id="firstname" name="First Name" path="firstname" dimension="medium" mand="true" maxlength="30" />
                </div>
                <div class="form-row">
                  <tag:noSpring2Col id="lastname" name="Surname" path="lastname" dimension="medium" mand="true" maxlength="30" />
                </div>
                <div id="num" style="display:none;" class="form-row last-row">
                  <label id="toadvisorlabel" for="numlist">Associate Applications with</label>
                  <select name="toadvisor" id="numlist">
                  </select>
                  <input id="Move" title="Move" type="button" value="Save & Move" class="button" onclick="moveApplications('${advisorfirm.id}')"/>
                  <br class="clear"/>
                </div>
              </div>
              <div class="second-column">
                <div class="form-row">
                  <tag:noSpring2Col id="workemail" name="Email" path="workemail" dimension="medium" mand="true" maxlength="30" />
                </div>
                <div class="form-row">
                  <tag:noSpring2Col id="assistantname" name="Assistant Name" path="assistantname" dimension="medium" maxlength="30" />
                </div>
                <div class="form-row last-row">
                  <tag:noSpring2Col id="assistantemail" name="Assistant Email" path="assistantemail" dimension="medium" maxlength="30" />
                </div>
              </div>
            </div>
            
            <br class="clear"/>
          </div>
          
          <br class="clear"/>
          
    		  <div class="button-row">
            <spring:nestedPath path="advisorfirm">
               <input id="Save" title="Save" type="button" value="Save" class="button" onclick="writeAdvisor('${advisorfirm.id}')"/>
               <input id="Applications" title="Applications" type="button" value="Show Applications" class="button attached" onclick="showApplications()"/>
               <input id="Clear" title="Clear" type="button" value="Clear" class="button attached" onclick="clearAdvisor('${advisorfirm.id}')"/>
               <input id="Back" title="Back" type="submit" value="Back" name="Back" class="button attached" /> <!-- onclick="alert(advisorid);goBack'${advisorfirm.id}')" -->
            </spring:nestedPath>              
            
            <br class="clear"/>
    		  </div>
          
          <h2>Advisor Summary</h2>
          
          <div class="messages" id="initialWaitMessage">
            <p>Please wait.  Loading advisor summary ...</p>
          </div>
          
          <table class="data" cellspacing="0" id="tableAdvisorSummary" style="display: none;">
           <thead>
            <tr>
              <th>Fullname</th>
              <th>Username</th>
              <th>Email</th>
              <th>Assistant Name</th>
              <th>Assistant Email</th>
              <th style="width: 100px; text-align: center;">Options</th>
            </tr>
           </thead>
           <tbody id="advbody">
              <tr id="pattern" style="display:none; ${s.index % 2 == 1 ? 'background: #f9f9ff;' : ''}">
                <td id="tdName"><span id="tableFullname">Fullname</span></td>
                <td id="tdUsername"><span id="tableUsername">Username</span></td>
                <td id="tdEmail"><span id="tableWorkemail">Workemail</span></td>
                <td id="tdAssistantName"><span id="tableAssistantname">Assistantname</span></td>
                <td id="tdAssistantEmail"><span id="tableAssistantemail">Assistantemail</span></td>
                <td id="tdOptions" style="text-align: center;">
                  <a href="#" id="edit" title="Edit" onclick="editClicked(this.id)">Edit</a>
                  <spring:nestedPath path="advisorfirm">
                    <span id="pipe">|</span>
                    <a href="#" id="delete" title="Remove" onclick="deleteClicked('${advisorfirm.id}',this.id)">Delete</a>
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
