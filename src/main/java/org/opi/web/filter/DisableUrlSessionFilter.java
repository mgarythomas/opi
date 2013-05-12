package org.opi.web.filter;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

//import org.opi.acegi.OpiRememberMeServices;
import org.springframework.util.StringUtils;

/*******************************************************************************
 * * Servlet filter which disables URL-encoded session identifiers.
 */
@SuppressWarnings("deprecation")
public class DisableUrlSessionFilter implements Filter
{
   /** * Filters requests to disable URL-based session identifiers. */
   protected static final Log logger = LogFactory.getLog(DisableUrlSessionFilter.class);
   private String finder;
      

   public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException,
         ServletException
   {
      // skip non-http requests
      if (!(request instanceof HttpServletRequest))
      {
         chain.doFilter(request, response);
         return;
      }

      HttpServletRequest httpRequest = (HttpServletRequest) request;
      HttpServletResponse httpResponse = (HttpServletResponse) response;

      /*
       * Place the following 3 variable in the session. 
       * Spring Security will redirect this request and lose request variables.
       */
      String url = httpRequest.getRequestURL().toString();
      if (url.endsWith("j_spring_security_check")) {
         finder = httpRequest.getParameter("finder");
         if (StringUtils.hasText(finder))
         {
            httpRequest.getSession().setAttribute("finder", true);
            httpRequest.getSession().setAttribute("key", httpRequest.getParameter("key"));
            httpRequest.getSession().setAttribute("value", httpRequest.getParameter("value"));
            logger.info("username="+httpRequest.getParameter("j_username")+", finder="+httpRequest.getParameter("finder"));
         }
      }

      // clear session if session id in URL 
      if (httpRequest.isRequestedSessionIdFromURL())
      {
         HttpSession session = httpRequest.getSession();
         if (session != null)
            session.invalidate();
      }

      // wrap response to remove URL encoding

      HttpServletResponseWrapper wrappedResponse = new HttpServletResponseWrapper(httpResponse)

      {
         @Override
         public String encodeRedirectUrl(String url)
         {
          logger.info("encodeRedirectUrl url="+url);
            return url;
         }

         @Override
         public String encodeRedirectURL(String url)
         {
            logger.info("encodeRedirectURL url="+url);
            return url;
         }

         @Override
         public String encodeUrl(String url)
         {
          logger.info("encodeUrl url="+url);
            return url;
         }

         @Override
         public String encodeURL(String url)
         {
          logger.info("encodeUrl url="+url);
            return url;
         }
      
      };

      // process next request in chain
      chain.doFilter(request, wrappedResponse);
   }

   /** * Unused. */
   public void init(FilterConfig config) throws ServletException
   {
   }

   /** * Unused. */
   public void destroy()
   {
   }

}
