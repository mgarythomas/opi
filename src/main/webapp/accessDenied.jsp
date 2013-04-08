<%@ page import="org.acegisecurity.context.SecurityContextHolder" %>
<%@ page import="org.acegisecurity.Authentication" %>
<%@ page import="org.acegisecurity.ui.AccessDeniedHandlerImpl" %>
<%@ page import="org.apache.commons.logging.Log"%>
<%@ page import="org.apache.commons.logging.LogFactory"%>
<%@ page import="com.ubs.opi.domain.Utils"%>

<h1>Sorry, access is denied</h1>
<%--

GAV:  This is how the page looked below.  Fix this to make it proper.
<%Utils.log.info("entering "+this.getClass()+" Thread="+Thread.currentThread().toString());%>


<p>
<%= request.getAttribute(AccessDeniedHandlerImpl.ACEGI_SECURITY_ACCESS_DENIED_EXCEPTION_KEY)%>

<p>

<%		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth != null) { %>
			Authentication object as a String: <%= auth.toString() %><BR><BR>
<%      } %>

--%>