package org.opi.spring.security;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.rememberme.TokenBasedRememberMeServices;

/**
 * @author mclachpa
 * Overrides the Acegi baseclass to correct a bug.
 * The Bug is that an NPI is occurring in TokenBasedRememberMeServices when
 * the user attempts to logout when he is already logged out.
 */
@SuppressWarnings(value = { "deprecation" })
public class OpiRememberMeServices extends TokenBasedRememberMeServices {

   protected static final Log logger = LogFactory.getLog(OpiRememberMeServices.class);

   public void logout(HttpServletRequest request, HttpServletResponse response, Authentication authentication) {
      if (authentication != null)
         this.cancelCookie(request, response, "Logout of user " + authentication.getName());
      else
      {
         logger.warn("Attempting to RememberMe when there is no authentication in the Session");
         this.cancelCookie(request, response, "Logout of user Unknown");
      }
  }

   protected void cancelCookie(HttpServletRequest request, HttpServletResponse response, String reasonForLog) {
      if ((reasonForLog != null) && logger.isDebugEnabled()) {
          logger.debug("Cancelling cookie for reason: " + reasonForLog);
      }
      // the cancel cookie feature is no longer required in spring security. Replaced ageci
  }


}
