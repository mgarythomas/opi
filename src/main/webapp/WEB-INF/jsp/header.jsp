<%@ page import="com.ubs.opi.domain.Utils"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<%Utils.log.info("entering "+this.getClass()+" Thread="+Thread.currentThread().toString());%>
<head>
  <title>New Adviser</title>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

  <!-- STYLESHEETS -->
  <link rel="stylesheet" href="/opi/css/layout.css" type="text/css" media="all" />
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

<body>
  <div id="wrapper">
    <table align=center width=900>
      <tr>
        <td>
          <!-- header -->
          <div id="header">
            <!-- Logo Image and Text -->
            <table cellPadding=0 width="100%">
              <tbody>
                <tr height="115">
                  <td width="100%" align=left>
                    <img align="center" src="<spring:theme code="banner.img"/>">
                  </td>
                </tr>
              </tbody>
            </table>
            <!--  % com.ubs.opi.domain.HibernateSessionFactory.getSession(); % -->
          </div>