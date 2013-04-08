<%@ include file="/WEB-INF/jsp/includes.jsp"%>

<div id="trust">
  <h2>Trust</h2>
  
  <div class="form-group">
    <c:if test="${application.product.code == 'hfa'}">
      <div class="form-row">
          <tag:formCheckbox name="Is this Trust a Super Fund?" path="issuperfund" />
      </div>

      <br/>
    </c:if>

    <div class="form-row">
      <tag:formField2Col name="Trust / Super Fund Name" path="companyByCompanyid.name" dimension="veryLong"
        mand="true" maxlength="80" />
    </div>
    
    <br/>
    
    <div class="two-columns">
      <div class="first-column">
        <div class="form-row">
          <tag:formField2Col name="ABN" path="companyByCompanyid.abn" dimension="short" maxlength="11" />
        </div>
        <c:if test="${application.product.code == 'hfa'}">
          <div class="form-row">
            <tag:formField2ColSecret name="TFN" path="companyByCompanyid.tfn" dimension="short" mand="true" maxlength="9"/>
          </div>
        </c:if>
      </div>
      <div class="second-column">
        <div class="form-row">
          <tag:formField2Col name="ARBN" path="companyByCompanyid.arbn" dimension="short" maxlength="11" />
        </div>
      </div>
    </div>
    
    <br/>

    <div class="form-row last-row">
      <tag:formField2Col name="Beneficiaries (Comma Seperated)" path="beneficiaries" dimension="veryLong" />
    </div>
    
    <br class="clear"/>

    <c:if test="${application.product.code == 'hfa'}">
      <tag:formSourceOfWealth name="Source of Wealth" path="wealth" mand="true" />
      
      <br/>
      <br/>
    
      <div class="messages">
        <p>
          If you are a trust applicant AND you intend to borrow from UBS Australia to finance the purchase of
          Units, UBS Australia will need to confirm your ability to borrow and grant a mortgage under your
          trust deed. Consequently, you must either: a) arrange for your solicitor to complete the declaration
          set out in Appendix A of the Application form, and submit that signed declaration with your
          Application Form; OR b) provide a complete and current copy of your trust deed to UBS Australia, who
          will arrange for a review of the relevant terms for a fee of A$250, to be deducted from your bank
          account specified in this Application form.&nbsp;
        </p>
        <p>
          This requirement is not applicable to superannuation funds or trust applicants who are only buying
          Units or Units and a Put option.
        </p>
        <tag:formInlineCheckBox
          name="Please tick this box if you would like UBS Australia to arrange for a review of your trust deed"
          path="reviewdeeds" />
        
    </c:if>

  </div>
</div>
