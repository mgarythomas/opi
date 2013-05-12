<%@ include file="/WEB-INF/jsp/includes.jsp" %>
<%@ include file="/WEB-INF/jsp/header.jsp" %>
<%@ page import="org.opi.domain.Constants" %>

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

<spring:nestedPath path="investorindividual">
    <jsp:include page="/WEB-INF/jsp/individual.jsp"/>
</spring:nestedPath>

	  </td>
	 </tr>
	<tr>
	<td/>
	<td>
     <br />

      <div id="buttons">
       <!-- input name="previous" type="button" class="left" value="Previous"
	          onclick="javascript:doAction('trustDetailFrm','previous');" / -->
       <input name="save" type="submit" class="right" value="Save"/>
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
