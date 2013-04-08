<%@ include file="/WEB-INF/jsp/includes.jsp" %>

      <div id="designate">
      <fieldset class="twoCol">

      <legend class="groupLabel"><a name="0">Contact Person</a></legend>

<!-- START TABLE MAIN -->

	    <table width="100%" cellpadding="0" cellspacing="1">

              <!-- START ROW1 -->
	      <tr class="address">

		    <td valign="top">

<tag:formField2Col name="First Name" path="firstname" dimension="medium" mand="true"/>
<tag:formField2Col name="Last Name" path="lastname" dimension="medium" mand="true"/>

		    </td>

		    <td valign="top">

<tag:formField2Col name="Telephone" path="telephone" dimension="small" mand="true"/>
<tag:formField2Col name="Email" path="email" dimension="medium" mand="true"/>


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
