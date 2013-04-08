<%@ include file="/WEB-INF/jsp/includes.jsp" %>
<%@ include file="/WEB-INF/jsp/header.jsp" %>

      <!-- content -->
	  <div id="content">
       <table width="100%">
        <tr>
         <td width="15px">&nbsp;</td>
         <td>

<table width="100%">

<tr>
    <td width="5px">&nbsp;</td>

    <td colspan="4">
          <span id="remove2">
              <a href="./new_adv_02.html"
              onclick="javascript:document.getElementById('applicant2Content').style.display = 'none';"
              target=_newAdv>> Edit my Adviser Profile</a>
          </span>
		  &nbsp;

          <span id="remove2">
		     <A href="individual.htm"> Create a New Investor Profile</a>
          </span>
		  &nbsp;
          <span id="remove2">
		     <A href="adv_client_list_02.html" target=_invContact>> Investor Contacts Summary</a>
          </span>
	</td>

    <td colspan="3">
          <span id="remove2"><a href="./new_adv_02.html" target=_new onclick="javascript:document.getElementById('applicant2Content').style.display = 'none';"> > Logout</a></span>
		  &nbsp;
          <span id="remove2"><a href="./new_adv_02.html" onclick="javascript:document.getElementById('applicant2Content').style.display = 'none';"> > Help</a></span>
	</td>

 </tr>
<tr>
  <td width="5px">&nbsp;</td>
<td colspan="4">&nbsp;
	</td>
 </tr>
</table>

<table width="100%">

  <td width="5px">&nbsp;</td>
<div class="groupHeader">
  &nbsp;&nbsp;&nbsp;&nbsp;Adviser Selection
</div>


<div class="groupBox">
 <table width="100%">
  <tr>
   <td>
	 <input type="hidden" name="submitAction" id="submitAction" value="" />
	 <input type="hidden" name="appType" id="appType" value="1"/>

	 <!-- START PENDING SECTION -->
	 <div id="company">
	  <fieldset class="twoCol">

	    <legend class="groupLabel"><a name="0">Adviser Selection</a></legend>

		<!-- START TABLE MAIN -->
	    <table class="dataTable" width="100%" cellpadding="1" cellspacing="0">

	      <tr class="tableIn">
		    <td><label for="company.name"><b>Investor Name</b></label></td>
		    <td><label for="company.country"><b>Telephone</b></label></td>
		    <td><label for="company.country"><b>Mobile</b></label></td>
		    <td><label for="company.country"><b>Email</b></label></td>
          <!-- 
		    <td>&nbsp;
			  <div id="buttons">
			   <input name="modify" type="button" class="left" value="Modify"
					  onclick="javascript:doAction('trustDetailFrm','previous');" />
			  </div>
		    </td>
          -->
	      </tr>

          <!-- END ROW1 -->

    <c:forEach var="advisorindividual" items="${advisor.advisorindividuals}">
	      <tr class="tableIn">
                <TD><c:out value="${advisorindividual.individual.lastname}"/></TD>
                <TD><c:out value="${advisorindividual.individual.homephone}"/></TD>
                <TD><c:out value="${advisorindividual.individual.mobilephone}"/></TD>
                <TD><c:out value="${advisorindividual.individual.personalemail}"/></TD>
		    <!-- <td>
				&nbsp;
			  <div id="buttons">
			   <input name="modify" type="button" class="left" value="Modify"
					  onclick="javascript:doAction('trustDetailFrm','previous');" />
			  </div>
		    </td> -->
	      </tr>
    </c:forEach>

        </table>

		<!-- END TABLE MAIN -->

    <form method=GET action="<c:url value="/addAdvisorindividual.htm"/>" name="formAddAdvisorindividual">
        <input type="hidden" name="advisorId" value="<c:out value="${advisor.id}"/>"/>
        <input type="submit" value="Add New Investor"/>
    </form>

      </fieldset>
      </div>

	 <!-- END PENDING SECTION -->

	 <!-- end content -->

     <!-- footer -->
     <%@ include file="/WEB-INF/jsp/footer.jsp" %>
