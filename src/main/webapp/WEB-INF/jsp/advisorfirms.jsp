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
          <spring:nestedPath path="dealergroup">
            init('${dealergroup.id}');
          </spring:nestedPath> 
        }
        
        var names = {};
        var moveCache = {};
        var statuses = {};
        var cache = { };
        var viewed = -1;
        var afsLength = -1;
        
        function update(names) {
          createList(names);
        }
        
        function createList(data) {
        //  alert('hi');
          DWRUtil.removeAllOptions("numlist");
          DWRUtil.addOptions("numlist", data);
        }
        
        function init(dealergroupid) 
        { 
        //  alert(dealergroupid);
          clearAdvisorfirm();
          disableButtons();
          fillTable(dealergroupid);
        }
        
        function disableButtons() {
        //  $("Save").disabled=true;
        //  $("Clear").disabled=true;
          $("Show Advisers").disabled=true;
          $("num").style.display="none";
        }
        
        function enableButtons() {
          $("Save").disabled=false;
          $("Clear").disabled=false;
          $("Show Advisers").disabled=false;
          $("num").style.display="";
        }
        
        function fillTable(dealergroupid) { // afsl
            Opi.getDwradvisorfirms(dealergroupid, function(afs) { // afsl
              // Delete all the rows except for the "pattern" row
              dwr.util.removeAllRows("afbody", { filter:function(tr) {
                return (tr.id != "pattern");
              }});
            
            // Create a new set cloned from the pattern row
            var af, id;
            for (var i = 0; i < afs.length; i++) {
              af = afs[i];
              id = af.id;
              dwr.util.cloneNode("pattern", { idSuffix:id });
              dwr.util.setValue("tableName" + id, af.afname);
              dwr.util.setValue("tableAbn" + id, af.afabn);
              dwr.util.setValue("tableFulladdress" + id, af.fulladdress);
              dwr.util.setValue("tableDbid" + id, af.dbid);
              if (af.doesnothaveadvisors == false) {
                if (document.getElementById("delete" + id) != null) {
                  document.getElementById("delete" + id).style.display="none";
                  document.getElementById("pipe" + id).style.display = "none";
                }
              }
              if ($("pattern" + id) != null) {
                $("pattern" + id).style.display = "";
                names[id] = af.afname;
              }
              if (i == afs.length - 1) {
                // set class to last-row
                document.getElementById("tdName" + id).className = "last-row";
                document.getElementById("tdAbn" + id).className = "last-row";
                document.getElementById("tdAddress" + id).className = "last-row";
                document.getElementById("tdOptions" + id).className = "last-row";
              }
              cache[id] = af;
            }
            afsLength = afs.length;
            
            document.getElementById("initialWaitMessage").style.display = "none";
            document.getElementById("tableAdvisorFirms").style.display = "";
          });
        }
        
        function editClicked(eleid) {
        // we were an id of the form "edit{id}", eg "edit42". We lookup the "42"
        // alert(eleid.substring(4));
          var af = cache[eleid.substring(4)];
        //  alert(af.afname);
          dwr.util.setValues(af);
        
        //  update(names);
          names = {};
          moveCache = {};
          var item;
          
          var j = 0;
          for (var i = 0; i < afsLength; i++) {
            item = cache[i];
              if ((i != 0) && (item.dbid != af.dbid)) {
                names[j] = item.afname;
                moveCache[j++] = item;
              }
          } 
        
          DWRUtil.removeAllOptions("numlist");
          DWRUtil.addOptions("numlist", names);
        
          enableButtons();
          if (af.doesnothaveadvisors == false) {
            $("Show Advisers").disabled=false;
            if (afsLength > 2)  
              $("num").style.display="";
            else
              $("num").style.display="none";
          } else
              $("num").style.display="none";
        }
        
        function deleteClicked(dealergroupid, eleid) { // afsl
          // we were an id of the form "delete{id}", eg "delete42". We lookup the "42"
          var af = cache[eleid.substring(6)];
          if (confirm("Are you sure you want to delete " + af.afname + "?")) {
        // TODO : don't offer this big gun unless sure the users can handle it!
            dwr.engine.beginBatch();
        //    alert("dealergroupid="+dealergroupid+", af.dbid="+af.dbid);
            Opi.removeDwradvisorfirm(af.dbid);
            fillTable(dealergroupid); //  afsl
            dwr.engine.endBatch();
            clearAdvisorfirm()
          }
        }
        
        function writeAdvisorfirm(dealergroupid) { //  afsl
          var af = { id:viewed, dbid:-1, afname:null, afabn:null, address1:null, suburb:null, state:null, postcode:null, doesnothaveadvisors:true };
          dwr.util.getValues(af);
        //  alert("afsl="+afsl+" af.afname="+af.afname+" af.dbid="+af.dbid+" af.address1="+af.address1+" af.suburb="+af.suburb+" af.state="+af.state+" af.postcode="+af.postcode);
        
          dwr.engine.beginBatch();
          Opi.storeDwradvisorfirm(dealergroupid, af, function(errors) { // afsl
        //    dwr.util.setValue(errors);
            if (errors != null)
              alert(errors);
            else {
              fillTable(dealergroupid); //  afsl
              clearAdvisorfirm();
            }
          });
        //  fillTable(advisorfirmid);
          dwr.engine.endBatch();
        
        //  Opi.storeDwradvisorfirm(afsl, af);
        //  fillTable(afsl);
        //  dwr.engine.endBatch();
        }
        
        function clearAdvisorfirm() {
        //  alert("hi");
          viewed = -1;
          dwr.util.setValues({ id:-1, dbid:-1, afname:null, afabn:null, address1:null, suburb:null, state:null, postcode:null, doesnothaveadvisors:true });
          DWRUtil.removeAllOptions("numlist");
          disableButtons(); // need to re-enable onblur of abn entry 
        }
        
        
        function showAdvisors() {
          var af = { id:viewed, dbid:-1, afname:null, afabn:null, address1:null, suburb:null, state:null, postcode:null, doesnothaveadvisors:true };
          dwr.util.getValues(af);
        //  alert("af.dbid="+af.dbid);
          document.getElementById('advisorfirmid').value=af.dbid;
          var advisorfirmid_var = dwr.util.getValue('dbid');
        //  alert(advisorfirmid_var);
          if (advisorfirmid_var != null)
        //  alert(advisorfirmid_var);
            submitForm('advisorfirmsForm');
        }
        
        
        function moveAdvisors(dealergroupid) {
        //  alert('hi');
          var toadvisorfirm = dwr.util.getValue("toadvisorfirm");
          var af = { id:viewed, dbid:-1, afname:null, afabn:null, address1:null, suburb:null, state:null, postcode:null, doesnothaveadvisors:true };
          dwr.util.getValues(af);
        //  alert("toadvisorfirm="+toadvisorfirm+" toaf.dbid="+cache[toadvisorfirm].dbid);
          dwr.engine.beginBatch();
        //  Opi.storeMoveDwradvisor(advisorfirmid, adv, cache[toadvisorfirm].dbid);
          Opi.storeMoveDwradvisorfirm(dealergroupid, af, moveCache[toadvisorfirm].dbid, function(errors) {
        //    dwr.util.setValue(errors);
            if (errors != null)
              alert(errors);
            else {
              fillTable(dealergroupid);
              clearAdvisorfirm(dealergroupid)
            }
          });
        
          dwr.engine.endBatch();
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
        
        <spring:nestedPath path="dealergroup">
          <h1>Dealergroup : <c:out value='${dealergroup.company.name}'/></h1>
        </spring:nestedPath>
        
        <jsp:include flush="true" page="/WEB-INF/jsp/includes/errors_and_messages.jsp"/>
        
        <form:form id="advisorfirmsForm">
          <!-- START FORM SECTION -->
          <input type="hidden" id="dgafsl" name="dgafsl"/>
          <input type="hidden" id="advisorfirmid" name="advisorfirmid"/>
          
          <h2>Advisor Firm</h2>
          
          <div class="form-group">
            <div class="two-columns">
              <div class="first-column">
                <div class="form-row">
            		  <tag:noSpring2Col id="afname" name="Name" path="afname" dimension="medium" mand="true" maxlength="30" />
                </div>
                <div class="form-row last-row">
                  <tag:noSpring2Col id="afabn" name="ABN" path="afabn" dimension="medium" mand="true" maxlength="30" />
                  <tag:noSpring2Col id="dbid" name="Dbid" type="hidden" path="dbid" dimension="medium" mand="true" maxlength="6" />
                </div>
                <div id="num" style="display: none;" class="form-row last-row">
                  <label id="toadvisorfirmlabel" for="applicantMiddle">Associate Advisors with</label>
                  <select name="toadvisorfirm" id="numlist">
                  </select>
                  <spring:nestedPath path="dealergroup">
                    <input id="Move" title="Move" type="button" value="Save & Move" class="button auto" onclick="moveAdvisors('${dealergroup.id}')"/>
                  </spring:nestedPath>              
                  <br class="clear"/>
                </div>
              </div>
              <div class="second-column">
                <div class="form-row">
                  <tag:noSpring2Col id="address1" name="Address" path="address1" dimension="medium" mand="true" maxlength="30" />
                </div>
                <div class="form-row">
                  <tag:noSpring2Col id="suburb" name="Suburb" path="suburb" dimension="medium" mand="true" maxlength="30" />
                </div>
                <div class="form-row">
                  <tag:noSpring2Col id="postcode" name="Postcode" path="postcode" dimension="veryShort" mand="true" maxlength="4" />
                </div>
                <div class="form-row last-row">
                  <label id="statelabel" for="applicantMiddle">State <span class="red">#</span></label>
                  <select id="state" name="State">
                    <option value="NSW"/>NSW</option>              
                    <option value="VIC"/>VIC</option>
                    <option value="QLD"/>QLD</option>            
                    <option value="ACT"/>ACT</option>              
                    <option value="SA"/>SA</option>              
                    <option value="WA"/>WA</option>
                    <option value="TAS"/>TAS</option>              
                    <option value="NT"/>NT</option>              
                  </select>
                  <br class="clear"/>
                </div>
              </div>
            </div>
            <br class="clear"/>
          </div>
          
          <br class="clear"/>
          
    		  <div class="button-row">
            <spring:nestedPath path="dealergroup">
              <input id="Show Advisers" title="Show Advisers" type="button" value="Show Advisers" class="button attached" onclick="showAdvisors()"/>
              <input id="Save" title="Save" type="button" value="Save" class="button attached" onclick="writeAdvisorfirm('${dealergroup.id}')"/>
              <input id="Clear" title="Clear" type="button" value="Clear" class="button attached" onclick="clearAdvisorfirm()"/>
              <input id="Back" title="Back" type="submit" name="Back" value="Back" class="button attached"/>
            </spring:nestedPath>              
    		  </div>
          
          <br class="clear"/>
          
          <h2>Advisor Firm Status</h2>
          
          <div class="messages" id="initialWaitMessage">
            <p>Please wait.  Loading advisor firms ...</p>
          </div>
          
          <table class="data" cellspacing="0" id="tableAdvisorFirms" style="display: none;">
            <thead>
              <tr>
                <th>Name</th>
                <th>Abn</th>
                <th>Address</th>
                <th style="width: 100px; text-align: center;">Options</th>
              </tr>
            </thead>
            <tbody id="afbody">
              <tr id="pattern" style="display: none; ${s.index % 2 == 1 ? 'background: #f9f9ff;' : ''}">
                <td id="tdName"><span id="tableName">Name</span></td>
                <td id="tdAbn"><span id="tableAbn">Abn</span></td>
                <td id="tdAddress"><span id="tableFulladdress">Fulladdress</span></td>
                <td id="tdOptions" style="text-align: center;">
                 <spring:nestedPath path="dealergroup">
                  <a href="#" id="edit" title="Edit" onclick="editClicked(this.id)">Edit</a>
                  <span id="pipe">|</span>
                  <a href="#" id="delete" title="Remove" onclick="deleteClicked('${dealergroup.id}', this.id)">Delete</a>
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

