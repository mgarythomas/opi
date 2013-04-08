<%@ include file="/WEB-INF/jsp/includes.jsp"%>
<%@ tag body-content="scriptless"%>
<%@ attribute name="title" required="true"%>
<%@ attribute name="formid" required="true"%>
<%@ attribute name="apptype" required="false"%>
<%@ attribute name="director" required="false"%>
<%@ attribute name="trust" required="false"%>
<%@ attribute name="index" required="false"%>
<%@ attribute name="displayindex" required="false"%>
<%@ attribute name="role" required="false"%>
<%@ attribute name="removable" required="false"%>
<%@ attribute name="formname" required="false"%>
<%@ attribute name="noheading" required="false"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:if test="${displayindex == 1}">
  <script type="text/javascript">
    function disableStructure (structure, disable)
    {
      var nodes = structure.childNodes;
      for (var i = 0; i < nodes.length; i++)
        if ((nodes[i].nodeName == "TABLE") ||
            (nodes[i].nodeName == "TBODY") ||
            (nodes[i].nodeName == "TR") ||
            (nodes[i].nodeName == "TD") ||
            (nodes[i].nodeName == "FIELDSET"))
          disableStructure (nodes[i], disable);
        else if ((nodes[i].nodeName == "INPUT") ||
                    (nodes[i].nodeName == "SELECT") ||
                    (nodes[i].nodeName == "LABEL") ||
                    (nodes[i].nodeName == "LEGEND"))
          nodes[i].disabled = disable;
        else if ((nodes[i].nodeName != "SPAN") &&
                    (nodes[i].nodeName != "BR") &&
                    (nodes[i].nodeName != "DIV") &&
                    (nodes[i].nodeName != "#text") &&
                    (nodes[i].nodeName != "") &&
                    (nodes[i].nodeName != "#comment"))
          alert("Ignored " + nodes[i].nodeName);
    }

    function controlExtraDirectors ()
    {
      // Called when the "sole director" box is clicked and also at on-load.
      // If "sole director" is checked, disabled the associated "is guarantor",
      // disabled the "applicant 2" area, and disables the "add applicant"
      // button.  (This code knows that the "sole director" will only be in the
      // first - index 1 - applicant.)

      var soleDirectorBox = document.getElementById ("isSoleDirector1");
      var guarantorBox = document.getElementById ("isGuarantor1");
      guarantorBox.disabled = soleDirectorBox.checked;
      var applicant2 = document.getElementById ("applicantArea2");
      disableStructure (applicant2, soleDirectorBox.checked);
      document.getElementById ("addinvestor").disabled = soleDirectorBox.checked;
    }

    function submitForm(formId)
    {
	  var frm = document.getElementById(formId);
	  if (frm != null) {
	    frm.submit();
	  }
    }    
    
    function removeApplicant (s, formId)
    {
	    var index = document.getElementById('index');
	    index.value=s;
	    var r=confirm("Are you sure?")
	    if (r==true)
	    	submitForm(formId);
        else
            index.value="null";
    }

  </script>
</c:if>
<div class="groupBox">
  <c:if test="${displayindex == 1}">
    <input type="hidden" id="index" name="investorindex" value="null" />
  </c:if>
  
  <c:choose>
    <c:when test="${noheading}">
      <hr class="clear"/>
    </c:when>
    <c:otherwise>
      <h2>${title} ${displayindex}</h2>
    </c:otherwise>
  </c:choose>
  
  <div class="form-group">
    <c:if test="${director == 'true'}">
      <div class="two-columns">
        <div class="first-column">
          <div class="form-row last-row">
            <c:if test="${displayindex == 1}">
              <tag:formCheckbox name="Sole Director/Co Secretary?" path="issoledirector" id="isSoleDirector1"
                onclick="isGuarantor1.checked = this.checked;controlExtraDirectors ()" />
            </c:if>
            <c:if test="${displayindex == 2}">
              <tag:formCheckbox name="Co Secretary?" path="iscompanysecretary" />
            </c:if>
            <c:if test="${displayindex > 2}">
              &#160;
            </c:if>
          </div>
        </div>
        <div class="second-column">
          <c:choose>
            <c:when test="${application.product.code == 'hfa'}">
              <div class="form-row last-row">
                <tag:formCheckbox name="Director is Guarantor?" path="isguarantor" id="isGuarantor${index}" />
              </div>
            </c:when>
            <c:otherwise>&#160;</c:otherwise>
          </c:choose>
        </div>
      </div>
      
      <br class="clear"/>
      <br class="clear"/>
    </c:if>
    <c:if test="${trust == 'true' && director== 'false'}">
      <div class="two-columns">
        <div class="first-column">
          <div class="form-row">
            <tag:formCheckbox name="Trustee is Guarantor?" path="isguarantor" id="isGuarantor${index}" />
          </div>
        </div>
        <div class="second-column">
          <div class="form-row">&#160;</div>
        </div>
      </div>
      
      <br class="clear"/>
    </c:if>
      
    <div class="two-columns">
      <div class="first-column">
        <div class="form-row">
          <tag:formTitles name="Title" path="individual.title" list="titles" />
        </div>
        <div class="form-row">
          <tag:formField2Col name="First Name" path="individual.firstname" dimension="medium" mand="true"
            maxlength="24" />
        </div>
        <div class="form-row">
          <tag:formField2Col name="Middle Name" path="individual.middlename" dimension="medium" maxlength="24" />
        </div>
        <div class="form-row">
          <tag:formField2Col name="Last Name" path="individual.lastname" dimension="medium" mand="true"
            maxlength="24" />
        </div>
        <div class="form-row">
          <tag:formField2Col name="Residential Address [2]" path="individual.address1" dimension="medium"
            mand="true" maxlength="32" />
        </div>
        <div class="form-row">
          <tag:formField2Col name="Suburb" path="individual.suburb" dimension="medium" mand="true"
            maxlength="25" />
        </div>
        <div class="form-row">
          <tag:formStates name="State" path="individual.state" list="states" mand="true" id="investorindividuals[${index}].individual.state" />
        </div>
        <div class="form-row">
          <tag:formField2Col name="Postcode" path="individual.postcode" dimension="veryShort" mand="true"
            maxlength="4" />
        </div>
        <div class="form-row last-row">
          <tag:formDefaultCountries name="Country of Residence [3]" path="individual.country" mand="true" map="defaultcountries" id="investorindividuals[${index}].individual.country"/>
        </div>
      </div>
      <div class="second-column">
        <c:if test="${application.product.code == 'hfa'}">
          <div class="form-row">
            <tag:formField2Col name="Passport No." path="individual.passportno" dimension="short" maxlength="24" />
          </div>
          <div class="form-row">
            <tag:formNationalities name="Nationality" path="individual.nationality"  mand="true" map="nationalities" />
          </div>
          <div class="form-row">
            <tag:formField2Col name="Driver's Licence No." path="individual.driverslicenceno" dimension="short"
              maxlength="24" />
          </div>
        </c:if>
        <div class="form-row">
          <tag:formField2Col name="Occupation" path="individual.occupation" dimension="medium" mand="true"
            maxlength="24" />
        </div>
        <c:if test="${application.product.code == 'hfa'}">
          <div class="form-row">
            <tag:formField2Col name="Employer" path="individual.employer" dimension="medium" maxlength="48" />
          </div>
        </c:if>
        <div class="form-row">
          <tag:formField2Col name="Date of Birth" path="individual.dateofbirth" mand="true" formname="${formname}" isdate="true"
            dimension="short" />
        </div>
        <c:if test="${application.product.code == 'hfa'}">
          <div class="form-row">
            <tag:formField2Col name="Place of Birth" path="individual.townofbirth" mand="true" dimension="medium"
              maxlength="24" />
          </div>
        </c:if>
        <div class="form-row">
          <tag:formCountries name="Country of Birth" path="individual.countryofbirth"  mand="true" map="countries" />
        </div>
        <c:if test="${application.product.code != 'citibank1' and application.product.code != 'citibank2'}">
          <div class="form-row last-row">
            <tag:formField2ColSecret name="TFN" path="individual.tfn" dimension="short" maxlength="9" />
          </div>
        </c:if>
      </div>
    </div>

    <br class="clear"/>
    
    <c:if test="${application.product.code == 'hfa'}">
      <tag:formSourceOfWealth name="Source of Wealth" path="wealth" mand="true" index="${index}"/>
      <br class="clear"/>
    </c:if>
    
    <c:if test="${displayindex > 1}">
      <div class="button-row">
        <button type="button" style="float: none;" name="populate" onclick="populateAddress('${index}')">Get Address</button>
        <c:if test="${ (apptype == 3) || (displayindex > 2) || (role == 'Beneficiary')}">
          <input type="submit" style="float: none;" class="button attached" name="remove" onclick="removeApplicant(${index}, '${formid}')" value="Remove"/>
        </c:if>
        
        <br class="clear"/>
      </div>
    </c:if >
    
    <br class="clear"/>
  </div>
  
  <c:if test="${displayindex == 1}">
    <p class="foot-note">
      <strong>[2]</strong> A PO Box cannot be used for your Residential Address.<br/>
      <strong>[3]</strong> Country of residence must be Australia for applicants and guarantors.
    </p>
  </c:if>
</div>
