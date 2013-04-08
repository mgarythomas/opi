<%@ tag body-content="scriptless" %>
<%@ attribute name="title" required="true" %>
<%@ attribute name="onload" required="false" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<head>
  <title>${title}</title>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

  <!-- STYLESHEETS -->
  <link rel="stylesheet" href="<spring:theme code="css.layout.path"/>" type="text/css" media="all" />
  <link rel="stylesheet" href="/opi/css/forms.css" type="text/css" media="all" />
  <link rel="stylesheet" href="/opi/css/popup.css" type="text/css" media="all" />
  <link rel="stylesheet" href="/opi/css/TP00001-header.css" type="text/css" media="all" />
  <link rel="stylesheet" href="<spring:theme code="css.content.path"/>" type="text/css" media="all" />
  <!-- end stylesheets -->

  <!--[if IE 5]>
    <link rel="stylesheet" href="../css/ie5.css" type="text/css" media="all" />
  <![endif]-->
  
  <!-- INCLUDED JAVAscripts -->
  <!-- script type="text/javascript" src="/opi/scripts/popup.js"></script>
  <script type="text/javascript" src="/opi/scripts/zebraTables.js"></script>
  <script type="text/javascript" src="/opi/scripts/AnchorPosition.js"></script>
  <script type="text/javascript" src="/opi/scripts/CalendarPopup.js"></script>
  <script type="text/javascript" src="/opi/scripts/date.js"></script>
  <script type="text/javascript" src="/opi/scripts/gbstCalendar.js"></script>
  <script type="text/javascript" src="/opi/scripts/PopupWindow.js"></script>
  <script type="text/javascript" src="//opiscripts/messages.js"></script-->
  <!-- end scripts -->

  <script type="text/javascript" src="/opi/scripts/common.js"></script>

</head>
         
 
<c:if test="${empty onload}"><body></c:if>
<c:if test="${!empty onload}"><body onload="${onload}"></c:if>

  <div id="wrapper">
    <table align=center width=900>
      <tr>
        <td>
          <!-- header -->
          <div id="header">
            <!-- Logo Image and Text -->
            <table cellPadding=0 width="100%">
              <tbody>
                <tr height="115" align="middle" >
                  <td width="100%" align=center>
                    <img align="middle" src="<spring:theme code="banner.img"/>">
                  </td>
                </tr>
              </tbody>
            </table>
          </div>