<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt1" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
  <head>
    <title>OPI - Dealergroup Summary</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
  
    <jsp:include flush="true" page="/WEB-INF/jsp/includes/scripts_and_styles.jsp"/>
    
    <script type="text/javascript">
      <!-- //
        function init() {
          clearDealergroup();
          disableButtons();
          fillTable();
        }
        
        var dgCache = { };
        var viewed = -1;
        
        function disableButtons() {
        //  document.getElementById('Save').disabled=true;
        //  document.getElementById('Clear').disabled=true;
          document.getElementById('Show Firms').disabled=true;
        }
        
        function enableButtons() {
        //  document.getElementById('Save').disabled=false;
          document.getElementById('Clear').disabled=false;
          document.getElementById('Show Firms').disabled=false;
        }
        
        function fillTable() {
          Opi.getAllDwrdealergroups(function(dgs) {
            // Delete all the rows except for the "pattern" row
            dwr.util.removeAllRows("dgbody", { filter:function(tr) {
              return (tr.id != "pattern");
            }});
            // Create a new set cloned from the pattern row
            var dg, id;

            for (var i = 0; i < dgs.length; i++) {
              dg = dgs[i];
              id = dg.id;
              dwr.util.cloneNode("pattern", { idSuffix:id });
              dwr.util.setValue("tableName" + id, dg.name);
              dwr.util.setValue("tableAfsl" + id, dg.afsl);
              dwr.util.setValue("tableAbn" + id,  dg.abn);
              dwr.util.setValue("tableIsdaapproved" + id,  dg.isdaapproved);
//              dwr.util.setValue("tableDbid" + id, dg.dbid); // Gav:  What is this element?  I can't see it.
              if (dg.doesnothaveadvisorfirms == false) {
                if (document.getElementById("delete" + id) != null) {
                  document.getElementById("delete" + id).style.display = "none";
                  document.getElementById("pipe" + id).style.display = "none";
                } 
              }
              if ($("pattern" + id) != null) {
                $("pattern" + id).style.display = "";
              }
              if (i == dgs.length - 1) {
                document.getElementById("tdName" + id).className = "last-row";
                document.getElementById("tdAfsl" + id).className = "last-row";
                document.getElementById("tdAbn" + id).className = "last-row";
                document.getElementById("tdApproved" + id).className = "last-row";
                document.getElementById("tdOptions" + id).className = "last-row";
              }
              dgCache[id] = dg;
              
              document.getElementById("initialWaitMessage").style.display = "none";
              document.getElementById("tableDealerGroups").style.display = "";
            }
          });
          
          
        }
        
        function editClicked(eleid) {
          // we were an id of the form "edit{id}", eg "edit42". We lookup the "42"
        //  alert(eleid.substring(4));
          var dg = dgCache[eleid.substring(4)];
          dwr.util.setValues(dg);
          // enableButtons();
          document.getElementById('Clear').disabled=false;
          //alert("dg.name="+dg.name+"dg.doesnothaveadvisorfirms="+dg.doesnothaveadvisorfirms);
          if (dg.doesnothaveadvisorfirms == false) {
            document.getElementById('Show Firms').disabled=false;
          } else {
            document.getElementById('Show Firms').disabled=true;
          }
        }
        
        function deleteClicked(eleid) {
          // we were an id of the form "delete{id}", eg "delete42". We lookup the "42"
          var dg = dgCache[eleid.substring(6)];
          if (confirm("Are you sure you want to delete " + dg.name + "?")) {
        // TODO : don't offer this big gun unless sure the users can handle it!
        //    dwr.engine.beginBatch();
        //    alert(dg.afsl);
        //    Opi.removeDwrdealergroup(dg.afsl);
        //    fillTable();
        //    dwr.engine.endBatch();
          }
        }
        
        function writeDealergroup() {
          var dg = { id:viewed, dbid:-1, name:null, afsl:null, abn:null, isdaapproved:null };
          dwr.util.getValues(dg);
        //  alert(dg.name);
          dwr.engine.beginBatch();
        //  Opi.storeDwrdealergroup(dg);
           Opi.storeDwrdealergroup(dg, function(errors) {
           dwr.util.setValue(errors);
           if (errors != null)
             alert(errors);
           else {
             fillTable();
             clearDealergroup();
            }
          });  
        //  fillTable();
          dwr.engine.endBatch();
        }
        
        function clearDealergroup() {
          viewed = -1;
          dwr.util.setValues({ id:-1, dbid:-1, name:null, afsl:null, abn:null, isdaapproved:null });
          disableButtons();
        }
        
        function showFirms() {
          var dg = { id:viewed, dbid:-1, name:null, afsl:null, abn:null, isdaapproved:null };
          dwr.util.getValues(dg);
        //  alert("dg.dbid="+dg.dbid+" dg.afsl="+dg.afsl);
          document.getElementById('dealergroupid').value=dg.dbid; // dgafsl
        //  var afsl_var = dwr.util.getValue('afsl');
          var dealergroup_var = dwr.util.getValue('dealergroupid');
        //  alert(afsl_var);
          if (dealergroup_var != null)
            submitForm('dealergroupsForm');
        }
      // -->
    </script>
  </head>
  
  <body onload="init();">
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
        
        <h1>Dealer Group Management Console</h1>
        
        <jsp:include flush="true" page="/WEB-INF/jsp/includes/errors_and_messages.jsp"/>

        <form:form id="dealergroupsForm">
          <input type="hidden" id="remove" name="remove"/>
          <input type="hidden" id="dealergroupid" name="dealergroupid"/>
          <input type="hidden" id="dgafsl" name="dgafsl"/>
          <input type="hidden" id="edit" name="edit"/>
          
          <h2>Dealer Group</h2>
          
          <div class="form-group">
            <div class="two-columns">
              <div class="first-column">
                <div class="form-row">
                  <tag:noSpring2Col id="afsl" name="AFSL" path="afsl" dimension="small" mand="true" maxlength="6" />
                </div>
                <div class="form-row last-row">
                  <tag:noSpring2Col id="name" name="Name" path="name" dimension="medium" mand="true" maxlength="30" />
                  <tag:noSpring2Col id="dbid" name="Dbid" type="hidden" path="dbid" dimension="medium" mand="true" maxlength="6" />
                </div>
              </div>
              <div class="second-column">
                <div class="form-row">
                  <tag:noSpring2Col id="abn" name="ABN" path="abn" dimension="medium" mand="true" maxlength="30" />
                </div>
                <div class="form-row last-row">
                  <label id="isdaapprovedlabel" for="applicantMiddle">Approved</label>
                  <select id="isdaapproved" name="Approved">
                    <option value="false">false</option>
                    <option value="true">true</option>
                  </select>
                  <br class="clear"/>
                </div>
              </div>
              <br class="clear"/>
            </div>
          </div>
            
          <br class="clear"/>
          
    		  <div class="button-row">
            <input class="button" id="Show Firms" title="Show Firms" type="button" value="Show Firms" onclick="showFirms()"/>
            <input class="button attached" id="Save" title="Save" type="button" value="Save" onclick="writeDealergroup()"/>
            <input class="button attached" id="Clear" title="Clear" type="button" value="Clear" onclick="clearDealergroup()"/>
            
            <br class="clear"/>
    		  </div>
          
          <h2>Dealergroup Status</h2>
          
          <div class="messages" id="initialWaitMessage">
            <p>Please wait.  Loading dealer groups ...</p>
          </div>
          
          <table class="data" cellspacing="0" id="tableDealerGroups" style="display: none;">
           <thead>
            <tr bgcolor="#e0e0e0" class="tableIn">
              <th>Name</th>
              <th>Afsl</th>
              <th>Abn</th>
              <th>Approved</th>
              <th style="width: 100px; text-align: center;">Options</th>
            </tr>
           </thead>
           <tbody id="dgbody">
              <tr id="pattern" style="display:none; ${s.index % 2 == 1 ? 'background: #f9f9ff;' : ''}">
                <td id="tdName"><span id="tableName">Name</span></td>
                <td id="tdAfsl"><span id="tableAfsl">Afsl</span></td>
                <td id="tdAbn"><span id="tableAbn">Abn</span></td>
                <td id="tdApproved"><span id="tableIsdaapproved">Isdaapproved</span></td>
                <td id="tdOptions" style="text-align: center;">
                  <a href="#" id="edit" title="Edit" onclick="editClicked(this.id)">Edit</a>
                  <span id="pipe">|</span>
                  <a href="#" id="delete" title="Remove" onclick="deleteClicked(this.id)">Delete</a>
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
