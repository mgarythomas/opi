<!-- 
WARNING

This JSP is not used.

Look at company.tag instead.

-->







<%@ include file="/WEB-INF/jsp/includes.jsp" %>

<!-- START COMPANY SECTION -->

	 <div id="company">
	  <fieldset class="twoCol">

	    <legend class="groupLabel"><a name="0">Company</a></legend>

		<!-- START TABLE MAIN
		<table class="dataTableNoBorder" swidth="100%" cellpadding="1" cellspacing="0">
		-->
	    <table width="100%" cellpadding="0" cellspacing="1">

          <!-- START ROW1 -->
	      <tr class="address">

		    <td valign="top">


<tag:formField2Col name="Company Name" path="name" dimension="medium" mand="true"/>
<tag:formField2Col name="Date of Incorporation" path="incorporationdate" dimension="short" mand="true"/>

		    </td>

		    <td valign="top">

<tag:formCountries name="Incorporated in" path="incorporationdate" mand="true" map="${countries}"/>

		    </td>

		    <td rowspan="2" width="80px">
		      <!-- INFORMATION BOX -->
				&nbsp;</td>
	      </tr>
          <!-- END ROW1 -->

        </table>

		<!-- END TABLE MAIN -->

      </fieldset>
      </div>

<!-- END COMPANY SECTION -->
