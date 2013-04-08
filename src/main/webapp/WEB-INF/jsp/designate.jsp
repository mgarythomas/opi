<%@ include file="/WEB-INF/jsp/includes.jsp"%>
<div id="designate">
  <fieldset class="twoCol">
    <legend class="groupLabel">
      <a name="0">Account Designation</a>
    </legend>
    <table width="100%" cellpadding="0" cellspacing="1">
      <tr class="address">
        <td colspan=2 valign="centre">
          <tag:formField2Col name="Account Name [1]" path="accountdesignation" dimension="veryLong" mand="true" maxlength="38"/>
        </td>
      </tr>
      <tr class="address">
        <td width="50%" valign="top">
          <tag:formField2Col name="Contact Person First Name" path="firstname" dimension="medium" mand="true" maxlength="24" />
          <tag:formField2Col name="Contact Person Surname" path="lastname" dimension="medium" mand="true" maxlength="24" />
          <tag:formField2Col name="Contact Telephone" path="homephone" dimension="small" mand="true" maxlength="20"/>
          <tag:formField2Col name="Contact Fax" path="fax" dimension="small" maxlength="20" />
          <tag:formField2Col name="Contact Email" path="email" dimension="medium" maxlength="50" />
        </td>
        <td width="50%" valign="top">
          <tag:formField2Col name="Postal Address" path="address1" dimension="medium" mand="true" maxlength="32" />
          <tag:formField2Col name="Suburb" path="suburb" dimension="medium" mand="true" maxlength="25" />
          <tag:formStates name="State" mand="true" path="state" list="states"  />
          <tag:formField2Col name="Postcode" mand="true" path="postcode" dimension="veryShort" maxlength="4" />
          <tag:formDefaultCountries name="Country" mand="true" path="country" map="defaultcountries" />
        </td>
      </tr>
      <tr>
        <td colspan="2">
          <div class="info" style="float: left;">
            <p class="hrIefix">
              [1] This is the name in which Units will be registered. This should correspond to and contain the name of
              the Applicant. Maximum 38 characters.
            </p>
          </div>
        </td>
      </tr>
    </table>
  </fieldset>
</div>