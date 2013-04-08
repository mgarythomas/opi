package com.ubs.opi.web.interceptor;

//import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.WebUtils;

import com.ubs.opi.acegi.OpiRememberMeServices;
import com.ubs.opi.domain.Individual;
import com.ubs.opi.service.Opi;

/**
 * XXX why do we need this?
 * 
 * 
 * @author paul?
 */
public class DateInsertionInterceptor implements HandlerInterceptor {

   private static final Log log = LogFactory.getLog(DateInsertionInterceptor.class);

   private Opi opi;
   private String url; // = request.getRequestURL().toString();
   private Boolean finder; // = (Boolean)WebUtils.getSessionAttribute(request, "finder");

   public void setOpi(Opi opi)
   {
      this.opi = opi;
   }

   protected Opi getOpi()
   {
      return opi;
   }

    public boolean preHandle(HttpServletRequest request,
            HttpServletResponse response, Object handler) throws Exception {
       finder = (Boolean)WebUtils.getSessionAttribute(request, "finder");
       url = request.getRequestURL().toString();
       log.info("preHandle : Thread="+Thread.currentThread().toString()+" URL="+url);
       if ((finder != null) && url.endsWith("advisorcomplete.htm")) {
          String key = (String)WebUtils.getSessionAttribute(request, "key");
          String value = (String)WebUtils.getSessionAttribute(request, "value");
          log.info("Finding a User's details with [Key,Value]=["+key+","+value+"]");
          Individual individual = this.getOpi().findIndividual(key, value);
          if (individual != null)
             getOpi().myMailManager().resendUserNameandPassword(individual);
          request.getSession().setAttribute("individual", individual);
       }

       log.info("preHandle : Thread="+Thread.currentThread().toString());
       return true;
    }

    public void postHandle(HttpServletRequest request,
            HttpServletResponse response, Object handler,
            ModelAndView modelAndView) throws Exception {
//       String url = request.getRequestURL().toString();
       log.info("postHandle : Thread="+Thread.currentThread().toString()+" URL="+url);
//       Boolean finder = (Boolean)WebUtils.getSessionAttribute(request, "finder");
//       if ((finder != null) && url.endsWith("advisorcomplete.htm")) {
//          log.info("User has been sent email to "+request.getAttribute("email")+" Logging anonymous User out now");
//       }
    }

    public void afterCompletion(HttpServletRequest request,
            HttpServletResponse response, Object handler, Exception ex)
            throws Exception {
       log.info("afterCompletion : Thread="+Thread.currentThread().toString()+" URL="+url);
//       String url = request.getRequestURL().toString();
//       Boolean finder = (Boolean)WebUtils.getSessionAttribute(request, "finder");
       if ((finder != null) && url.endsWith("advisorcomplete.htm")) {
          log.info("logging out user");
          OpiRememberMeServices OpiRememberme = new OpiRememberMeServices(); 
          OpiRememberme.logout(request, response, SecurityContextHolder.getContext().getAuthentication());
          request.getSession().invalidate();
       }
    }

}
