<%@ include file="/WEB-INF/jsp/includes.jsp" %>
<%@ include file="/WEB-INF/jsp/header.jsp" %>

      <!-- content -->
	  <div id="content">
       <table width="100%">
        <tr>
         <td width="15px">&nbsp;</td>
         <td>


<!-- START FORM -->
<form id="individualDetailFrm" name="individualDetailFrm" method="POST">

<table width="100%">

 <tr>
  <td width="5px">&nbsp;</td>
  <td>
<div class="groupHeader">
  &nbsp;&nbsp;&nbsp;&nbsp;Enter Investor Details
</div>

<div class="groupBox">
 <table width="100%">
  <tr>
   <td>
	 <input type="hidden" name="submitAction" id="submitAction" value="" />
	 <input type="hidden" name="appType" id="appType" value="1"/>

	 <!-- START INVESTOR 1 SECTION -->
	 <div id="applicant0">
	  <fieldset class="twoCol">

	    <legend class="groupLabel"><a name="0">Individual Investor</a></legend>

		<!-- START TABLE MAIN -->
	    <table width="100%" cellpadding="0" cellspacing="1">

          <!-- START ROW1 -->
	      <tr class="address">
		    <td valign="top">

<spring:nestedPath path="individual">

<label for="applicantTitle">Title</label>
<spring:bind path="title">
              <select name="<c:out value="${status.expression}"/>">
                  <c:forEach items="${titles}" var="opt" >
                      <option value="<c:out value="${opt}"/>"
                          <c:if test="${opt == status.value}">selected</c:if>/>
                          <c:out value="${opt}"/></option>
                  </c:forEach>
              </select>
</spring:bind>
		      <br />

<tag:formField2Col name="First Name" path="firstname" dimension="medium" mand="true"/>
<tag:formField2Col name="Middle Name" path="middlename" dimension="medium" />
<tag:formField2Col name="Surname" path="lastname" dimension="medium" mand="true"/>
<tag:formField2Col name="TFN*" path="tfn" dimension="short" />
		      
		      <div class="info" style="float: left;">
		       <p class="hrIefix"><strong>* TFN</strong>
		       <br />See clause 18 of the General Terms.<br/>Leave blank if this is a company, trust
		       <br/>or superannuation fund application.</p>
		      </div>

		    </td>

		    <td valign="top">

<tag:formField2Col name="Address Line 1" path="address1" dimension="medium"  mand="true"/>
<!-- tag:formField2Col name="Address Line 2" path="address2" dimension="medium" / -->
<tag:formField2Col name="Suburb" path="suburb" dimension="medium" />

<label for="applicantMiddle">State</label>
<spring:bind path="state">
              <select name="<c:out value="${status.expression}"/>">
                  <c:forEach items="${states}" var="opt" >
                      <option value="<c:out value="${opt}"/>"
                          <c:if test="${opt == status.value}">selected</c:if>/>
                          <c:out value="${opt}"/></option>
                  </c:forEach>
              </select>
</spring:bind>
		      <br />

<tag:formField2Col name="Postcode" path="postcode" dimension="veryShort"  mand="true"/>

              <label for="applicantCountry">Country<span class="mandatoryField">#</span></label>
<spring:bind path="country">
              <select name="<c:out value="${status.expression}"/>">
                  <c:forEach items="${countries}" var="opt" >
                      <option value="<c:out value="${opt.value}"/>"
                          <c:if test="${opt.value == status.value}">selected</c:if>/>
                          <c:out value="${opt.value}"/></option>
                  </c:forEach>
              </select>
</spring:bind>

		    </td>
		    <td rowspan="2" width="200px">
		      <!-- INFORMATION BOX -->
				 &nbsp;
		    </td>
	      </tr>
          <!-- END ROW1 -->

          <!-- START ROW2 -->
          <tr>
          <!-- Start here -->
		    <td colspan="2" width="100%">
		      <br/><div class="info">
		        <table width="100%">
		          <tr>
		            <td colspan="2">
		              The name/s entered should be used to define the legal name of the client. &nbsp;
  					  &lt; &nbsp; &gt; brackets should be used to denote a designation.<br/>
  					  Note: A PO Box cannot be used for your primary address.
  					</td>
  				  </tr>
				  <tr>
					<td colspan="2"><strong>Examples: </strong></td>
		      </tr>

	        </table>
		      </div>
		    </td>
          </tr>
          <!-- END ROW2 -->

          <!-- START ROW TEMP -->
				  <tr>
				    <td colspan="2">
						&nbsp;&nbsp;</td>
				  </tr>

	      <tr class="address">

		    <td valign="top">

<tag:formField2Col name="Home Phone" path="homephone" dimension="short" />
<tag:formField2Col name="Work Phone" path="workphone" dimension="short" />
<tag:formField2Col name="Mobile Phone" path="mobilephone" dimension="short" />
<tag:formField2Col name="Fax Number" path="personalfax" dimension="short" />
<tag:formField2Col name="Email *" path="personalemail" dimension="short"  mand="true"/>

		    </td>
		    <td valign="top">

<tag:formField2Col name="Date of Birth" path="dateofbirth" dimension="short" mand="true" isdate="true"/>
<tag:formField2Col name="Place of Birth" path="townofbirth" mand="true" dimension="short" />
<tag:formField2Col name="Passport No." path="passportno" dimension="short" />

<label for="accountContactHomePhone">Nationality</label>
<spring:bind path="nationality">
              <select name="<c:out value="${status.expression}"/>">
                  <c:forEach items="${countries}" var="opt" >
                      <option value="<c:out value="${opt.value}"/>"
                          <c:if test="${opt.value == status.value}">selected</c:if>/>
                          <c:out value="${opt.value}"/></option>
                  </c:forEach>
              </select>
</spring:bind>
<br />

<tag:formField2Col name="Driver's licence" path="driverslicenceno" dimension="short" />
<tag:formField2Col name="Occupation" path="occupation" dimension="medium" />
<tag:formField2Col name="Employer" path="employer" dimension="medium" />

</spring:nestedPath>

		    </td>
		    <td rowspan="2" width="200px">
		      <!-- INFORMATION BOX -->
				 &nbsp;
		    </td>
	      </tr>

        </table>

		<!-- END TABLE MAIN -->

      </fieldset>
      </div>

	 <!-- END INVESTOR 1 SECTION -->

	  </td>
	 </tr>
	</table>
	
	
	</div>
	  </td>
	 </tr>
	<tr>
	<td/>
	<td>
     <br />

      <div id="buttons">
       <input name="previous" type="button" class="left" value="Previous"
	          onclick="javascript:doAction('trustDetailFrm','previous');" />
       <input name="next" type="submit" class="right" value="Next"/>
      </div>

	</td>
	</tr>
	</table>

    </form>
         </td>
        </tr>
       </table>
	  </div>


	  <!-- end content -->
<%@ include file="/WEB-INF/jsp/footer.jsp" %>
