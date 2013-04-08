<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt1" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<h2>BDM Details</h2>

<spring:nestedPath path="individual">
  <div class="form-group">
    <div class="two-columns">
      <div class="first-column">
        <div class="form-row">
          <tag:formTitles name="Title" path="title" list="titles" />
        </div>
        <div class="form-row">
          <tag:formField2Col name="First Name" path="firstname" dimension="medium" mand="true" maxlength="24"/>
        </div>
        <div class="form-row">
          <tag:formField2Col name="Middle Name" path="middlename" dimension="medium" maxlength="24" />
        </div>
        <div class="form-row">
          <tag:formField2Col name="Surname" path="lastname" dimension="medium" mand="true" maxlength="24" />
        </div>
        <div class="form-row">
          <tag:formField2Col name="Address" path="address1" dimension="medium" maxlength="32" />
        </div>
        <div class="form-row">
          <tag:formField2Col name="Suburb" path="suburb" dimension="medium" maxlength="25" />
        </div>
        <div class="form-row">
          <tag:formStates name="State" path="state" list="states"/>
        </div>
        <div class="form-row last-row">
          <tag:formField2Col name="Postcode" path="postcode" dimension="veryShort" maxlength="4" />
        </div>
      </div>
      <div class="second-column">
        <div class="form-row">
          <tag:formField2Col name="Work Phone" path="workphone" dimension="medium" mand="true" maxlength="20" />
        </div>
        <div class="form-row">
          <tag:formField2Col name="Mobile Phone" path="mobilephone" dimension="medium" maxlength="20" />
        </div>
        <div class="form-row">
          <tag:formField2Col name="Fax Number" path="workfax" dimension="medium" mand="true" maxlength="20" />
        </div>
        <div class="form-row">
          <tag:formField2Col name="Email" path="workemail" dimension="medium" mand="true" maxlength="50" id="email" onblur='checkEmail()'/>
        </div>
      </div>
      <br class="clear"/>
    </div>
    <br class="clear"/>
  </div>
</spring:nestedPath>
