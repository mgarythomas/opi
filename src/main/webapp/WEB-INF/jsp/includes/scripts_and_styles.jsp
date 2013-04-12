<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>

<link rel="stylesheet" href="<spring:theme code="css.layout.path"/>" type="text/css" media="all" />
<link rel="stylesheet" href="${contextPath}/css/calendar-win2k-cold-2.css" type="text/css" media="all" />
<link rel="favicon" href="${contextPath}/images/favicon.ico" type="image/x-icon" />

<!--[if IE]>
  <style type="text/css">

    br.clear {
      line-height: 16px;
    }
    
    div.form-row label {
      padding-top: 3px;
    }

  </style>
<![endif]-->

<script type="text/javascript" src="${contextPath}/dwr/interface/Opi.js"></script>
<script type="text/javascript" src="${contextPath}/dwr/engine.js"></script>
<script type="text/javascript" src="${contextPath}/dwr/util.js"></script>

<script type="text/javascript" src="${contextPath}/scripts/messages.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/AnchorPosition.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/zebraTables.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/popup.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/help.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/common.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/CalendarPopup.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/date.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/gbstCalendar.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/PopupWindow.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/calendar.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/calendar-en.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/calendar-setup.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/calendar-opi.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/DollarFunctions.js"></script>


<script type="text/javascript">
  // Hack to avoid bug in jscalendar - JRA-7713
  // if (!Calendar._TT["WEEKEND"]) Calendar._TT["WEEKEND"] = "0,6";
  // if (!Calendar._TT["DAY_FIRST"]) Calendar._TT["DAY_FIRST"] = "Display %s first";
</script>
