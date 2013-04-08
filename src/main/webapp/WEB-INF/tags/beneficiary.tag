<%@ include file="/WEB-INF/jsp/includes.jsp"%>
<%@ tag body-content="scriptless"%>
<%@ attribute name="dir1" required="true"%>
<%@ attribute name="path1" required="true"%>
<%@ attribute name="dir2" required="true"%>
<%@ attribute name="path2" required="true"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div id="beneficiary">
<fieldset class="twoCol"><legend class="groupLabel"><a name="0">Beneficial Owner Details</a></legend>
<!-- START TABLE MAIN
		<table class="dataTableNoBorder" swidth="100%" cellpadding="1" cellspacing="0">
		-->
<table width="100%" cellpadding="0" cellspacing="1">
  <!-- START ROW1 -->
  <tr class="address">
    <td valign="top">
       <tag:formCheckbox name="${dir1}" path="${path1}" />
    </td>
    <td valign="top">
       <tag:formCheckbox name="${dir2}" path="${path2}" />
    </td>
    <td rowspan="2" width="80px"><!-- INFORMATION BOX --> &nbsp;</td>
  </tr>
  <!-- END ROW1 -->
</table>
<!-- END TABLE MAIN -->
</fieldset>
</div>
