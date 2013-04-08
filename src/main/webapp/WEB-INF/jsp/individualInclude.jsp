<%@ include file="/WEB-INF/jsp/includes.jsp" %>

<div class="groupBox">
 <table width="100%">
  <tr>
   <td>

<!-- START INVESTOR 1 SECTION -->
	 <div id="applicant0">
	  <fieldset class="twoCol">

	    <legend class="groupLabel"><a name="0">Individual Investor</a></legend>

		<!-- START TABLE MAIN -->
	    <table width="100%" cellpadding="0" cellspacing="1">

          <!-- START ROW1 -->
	      <tr class="address">
		    <td valign="top">

<spring:nestedPath path="investorindividual">

<label for="individual.title">Title</label>
<spring:bind path="individual.title">
              <select name="<c:out value="${status.expression}"/>">
                  <c:forEach items="${titles}" var="opt" >
                      <option value="<c:out value="${opt}"/>"
                          <c:if test="${opt == status.value}">selected</c:if>/>
                          <c:out value="${opt}"/></option>
                  </c:forEach>
              </select>
</spring:bind>
		      <br />

<tag:formField2Col name="First Name" path="individual.firstname" dimension="medium" mand="true"/>
<tag:formField2Col name="Middle Name" path="individual.middlename" dimension="medium" />
<tag:formField2Col name="Surname" path="individual.lastname" dimension="medium" mand="true"/>


<c:if test="${investorindividual.role == 'Individual'}">
<tag:formField2Col name="TFN*" path="individual.tfn" dimension="short" />
		      <div class="info" style="float: left;">
		       <p class="hrIefix"><strong>* TFN</strong>
		       <br />See clause 18 of the General Terms.<br/>Leave blank if this is a company, trust
		       <br/>or superannuation fund application.</p>
		      </div>
</c:if>	<!-- c:if test="${role == '%Constants.INDIVIDUAL%'}" -->     

<tag:formField2Col name="Address Line 1" path="individual.address1" dimension="medium" mand="true"/>
<tag:formField2Col name="Suburb" path="individual.suburb" dimension="medium" mand="true"/>

<spring:bind path="individual.state">
<label for="applicantMiddle">State<span class="mandatoryField">#&nbsp;<c:out value="${status.errorMessage}"/></span></label>  
              <select name="<c:out value="${status.expression}"/>">
                  <c:forEach items="${states}" var="opt" >
                      <option value="<c:out value="${opt}"/>"
                          <c:if test="${opt == status.value}">selected</c:if>/>
                          <c:out value="${opt}"/></option>
                  </c:forEach>
              </select>
</spring:bind>
		      <br />

<tag:formField2Col name="Postcode" path="individual.postcode" dimension="veryShort" mand="true"/>

              <label for="applicantCountry">Country<span class="mandatoryField">#</span></label>
<spring:bind path="individual.country">
              <select name="<c:out value="${status.expression}"/>">
                  <c:forEach items="${countries}" var="opt" >
                      <option value="<c:out value="${opt.value}"/>"
                          <c:if test="${opt.value == status.value}">selected</c:if>/>
                          <c:out value="${opt.value}"/></option>
                  </c:forEach>
              </select>
</spring:bind>

		    </td>

		    <td valign="top">

<tag:formField2Col name="Date of Birth" path="individual.dateofbirth" dimension="short15" mand="true" isdate="true"/>
<tag:formField2Col name="Place of Birth" path="individual.townofbirth"  mand="true" dimension="short" />
<tag:formField2Col name="Passport No." path="individual.passportno" dimension="short" />

<label for="accountContactHomePhone">Nationality</label>
<spring:bind path="individual.nationality">
              <select name="<c:out value="${status.expression}"/>">
                  <c:forEach items="${countries}" var="opt" >
                      <option value="<c:out value="${opt.value}"/>"
                          <c:if test="${opt.value == status.value}">selected</c:if>/>
                          <c:out value="${opt.value}"/></option>
                  </c:forEach>
              </select>
</spring:bind>
<br />

<tag:formField2Col name="Driver's licence" path="individual.driverslicenceno" dimension="short" />
<tag:formField2Col name="Occupation" path="individual.occupation" dimension="medium" />
<tag:formField2Col name="Employer" path="individual.employer" dimension="medium" />

		    </td>
		    <td rowspan="2" width="200px">
		      <!-- INFORMATION BOX -->
				 &nbsp;
		    </td>
	      </tr>
          <!-- END ROW1 -->

</spring:nestedPath>

          <!-- START ROW2 -->
          <tr>
          <!-- Start here -->
            <td colspan="2" width="100%">
		      <div class="info" style="float: left;">
		       <p class="hrIefix">The name/s entered should be used to define the legal name of the client. &nbsp;
                    &lt; &nbsp; &gt; brackets should be used to denote a designation.
                    <br/>Note: A PO Box cannot be used for your primary address.</p>
		      </div>
            </td>
          </tr>
          <!-- END ROW2 -->

</table>
<!-- END TABLE MAIN -->

</fieldset>
</div>


<!-- END INVESTOR 1 SECTION -->

	  </td>
	 </tr>
	</table>
	
	
	</div>
