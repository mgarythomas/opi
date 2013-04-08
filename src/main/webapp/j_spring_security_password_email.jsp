<%@ include file="/WEB-INF/jsp/includes.jsp"%>
<%@ include file="/WEB-INF/jsp/header1.jsp"%>
<tag:header title="OPI Password Finder Confirm"/>
<!-- content -->
<script type="text/javascript" src="scripts/help.js"></script>
<style>
  ol { margin-left: 2.5em; padding: 0 0; }
  ol ol { list-style-type: lower-alpha; }
  ol ol ol { list-style-type: lower-roman; }
  li { padding: 5pt 5pt; }
  ol p { margin-top: 5pt; margin-bottom: 5pt; }
</style>
<div id="content">
  <table width="100%">
    <tr>
      <td>
        &nbsp;
      </td>
      <td align="right">
        <span id="remove2"><a href="javascript:ShowWinContact();%20void(0);"> >Help</a> </span>
      </td>
    </tr>
  </table>
  <br>
  <div class="groupHeader">
    User details successfully retreived
  </div>
  <div class="infoBox">
    <p>
      A Confirmation email containing Access Code and Password has been sent to :
    </p>
    <p>
      <b><c:out value="${param.email}" /><b>
    </p>
  </div>
</div>
<form method="get" action='<c:url value="/j_spring_security_logout"/>' name="formLogin">
  <table width="100%">
    <tbody>
      <tr>
        <td>
          &nbsp;
        </td>
        <td>
          <div id="buttons">
            <input name="return" type="submit" class="right" value="Login" />
          </div>
        </td>
      </tr>
    </tbody>
  </table>
</form>
<!-- end content -->
<!-- footer -->
<%@ include file="/WEB-INF/jsp/footer.jsp"%>
