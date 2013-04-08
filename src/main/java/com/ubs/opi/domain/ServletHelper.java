package com.ubs.opi.domain;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
  * @author Paul McLachlan
 */
public class ServletHelper
{
   private static final Log log = LogFactory.getLog(ServletHelper.class);

   static public void logException(javax.servlet.http.HttpServletRequest request)
   {
      try {
         // The Servlet spec guarantees this attribute will be available
         Throwable exception = (Throwable) request.getAttribute("javax.servlet.error.exception"); 

         if (exception != null) {
            if (exception instanceof ServletException) {
               // It's a ServletException: we should extract the root cause
               ServletException sex = (ServletException) exception;
               Throwable rootCause = sex.getRootCause();
               if (rootCause == null)
                  rootCause = sex;
               log.error("** Root cause is: "+ rootCause.getMessage(), exception);
//               out.println("** Root cause is: "+ rootCause.getMessage());
//               rootCause.printStackTrace(new java.io.PrintWriter(out)); 
            }
            else {
               // It's not a ServletException, so we'll just show it
               log.error("It's not a ServletException", exception);
               //exception.printStackTrace(new java.io.PrintWriter(out)); 
            }
         } 
         else  {
            log.error("No error information available");
//            out.println("No error information available");
         } 

         // Display cookies
         log.info("Cookies:");
         Cookie[] cookies = request.getCookies();
         if (cookies != null) {
            for (int i = 0; i < cookies.length; i++) {
                  log.info(cookies[i].getName() + "=[" + cookies[i].getValue() + "]");
            }
         }
             
      } catch (Exception ex) { 
         log.error("Threw an Exception in Servlet Logging", ex);
      }
      
   }
}
