<%@ include file="/WEB-INF/jsp/includes.jsp"%>
<%@ tag body-content="scriptless"%>
<%@ attribute name="trust" required="false"%>
<%@ attribute name="formname" required="false"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div id="company">
  <h2>Company</h2>

  <p class="foot-note">Note: Country of incorporation must be Australia.</p>
  
  <div class="form-group">
    <div class="form-row">
      <tag:formField2Col name="Company Name" path="name" dimension="veryLong" mand="true" maxlength="60"/>
    </div>
    
    <br/>
    
    <div class="two-columns">
      <div class="first-column">
        <c:if test="${application.product.code == 'hfa'}">
          <div class="form-row">
            <tag:formDefaultCountries name="Country of Incorporation" path="incorporationcountry" mand="true" map="${defaultcountries}" />
          </div>
        </c:if>
        <div class="form-row last-row">
          <tag:formField2Col name="Date of Incorp" path="incorporationdate" dimension="short" mand="true" formname="${formname}" isdate="true" />
        </div>
      </div>
      <div class="second-column">
        <div class="form-row">
          <tag:formField2Col name="ABN" path="abn" dimension="short" maxlength="11" />
        </div>
        <c:if test="${application.product.code == 'hfa'}">
          <div class="form-row">
            <tag:formField2ColSecret name="TFN" path="tfn" dimension="short" maxlength="9" />
          </div>
        </c:if>
        <div class="form-row">
          <tag:formField2Col name="ACN" path="acn" dimension="short" maxlength="11" />
        </div>
        <div class="form-row last-row">
          <tag:formField2Col name="ARBN" path="arbn" dimension="short" maxlength="11" />
        </div>
      </div>
    </div>
    
    <br/>
  </div>
</div>
