package com.ubs.opi.web;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.beans.propertyeditors.CustomNumberEditor;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.validation.BindException;
import org.springframework.web.bind.ServletRequestBindingException;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ThemeResolver;
import org.springframework.web.servlet.mvc.SimpleFormController;
import org.springframework.web.servlet.support.RequestContextUtils;
import org.springframework.web.util.WebUtils;

import com.ubs.opi.acegi.OpiRememberMeServices;
import com.ubs.opi.domain.Advisor;
import com.ubs.opi.domain.Application;
import com.ubs.opi.domain.Superusers;
import com.ubs.opi.domain.Utils;
import com.ubs.opi.exception.RestrictedAccessException;
import com.ubs.opi.service.Opi;

/**
 * JavaBean abstract base class for opi-aware form controllers. Provides
 * convenience methods for subclasses.
 *
 * @author Paul McLachlan
 */
public abstract class AbstractOpiForm extends SimpleFormController
{
   private static final Log log = LogFactory.getLog(AbstractOpiForm.class);

   private String advisorStartView = "redirect:/advisorapplications.htm";
   private String superusersStartView = "redirect:/superusers.htm";

   /**
    * Set the name of the view that should be used for beneficiary display.
    */
   public void setAdvisorStartView(String advisorStartView) {
      this.advisorStartView = advisorStartView;
   }

   private Opi opi;

   public void setOpi(Opi opi)
   {
      this.opi = opi;
   }

   protected Opi getOpi()
   {
      return opi;
   }

   public void afterPropertiesSet()
   {
      if (this.opi == null)
      {
         throw new IllegalArgumentException("'opi' is required");
      }
   }
   
   public static String getSessionTheme(HttpServletRequest request) {
     ThemeResolver themeResolver = RequestContextUtils.getThemeResolver(request);
     return themeResolver.resolveThemeName(request);
   }


   /**
    * Loads an application by the <code>applicationId</code> parameter.
    * 
    * @param request The request.
    * @param deep Set to true to load application ORM dependencies.
    * 
    * @return The application.
    * 
    * @throws ServletRequestBindingException If the parameter doesn't exist.
    */
   protected Application getApplicationWithId(HttpServletRequest request, boolean deep) throws ServletRequestBindingException {
      Application application;
      
      long applicationId = ServletRequestUtils.getLongParameter(request, "applicationId");

      if (deep) {
        application = (Application) getOpi().loadApplication(applicationId);
      } else {
        application = (Application) getOpi().loadApplicationSimple(applicationId);
      }
      
      WebUtils.setSessionAttribute(request, "application", application);

      return application;
   }

   protected Application getApplication(HttpServletRequest request, boolean deep) throws ServletRequestBindingException
   {
      Application application = (Application) WebUtils.getSessionAttribute(request, "application");

      // This is a hack till i figure out why the application gets removed
      // from the session when you refresh.
      Application application2 = (Application) WebUtils.getSessionAttribute(request, "application2");
      if (application != null) {
        request.getSession().setAttribute("application2", application);
      } else {
        application = application2;
      }

      
      if (application == null) {
        logger.warn("Application doesn't exist in session.  " +
            "Attempting to retrieve by applicationId parameter.");
        application = this.getApplicationWithId(request, deep);
      }
      
      return application;
   }

   protected Advisor getAdvisor(HttpServletRequest request, boolean deep) throws ServletException
   {
      Advisor advisor;
      try
      {
         Superusers Superusers = (Superusers)WebUtils.getSessionAttribute(request, "superusers");
         advisor = Superusers.getTransadvisor();
         if (deep)
         {
            advisor = (Advisor) getOpi().loadAdvisorDeep(advisor.getId());
            return advisor;
         }
         else
            return advisor;
      } catch (Exception e)
      {
         log.debug("No Superuser in Session");
      }
      
      advisor = (Advisor) WebUtils.getSessionAttribute(request, "advisor");
      if (advisor == null)
      {
         long id;
         try
         {
            id = ServletRequestUtils.getRequiredLongParameter(request, "advisorId");
            if (deep)
               advisor = (Advisor) getOpi().loadAdvisorDeep(id);
            else
               advisor = (Advisor) getOpi().loadAdvisorSimple(id);

            WebUtils.setSessionAttribute(request, "advisor", advisor); // clear session attribute

         } catch (Exception e)
         {
            try
            {
               if (!Utils.hasAuthority("ROLE_ADMINISTRATOR"))
               {
                  User user = (User)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
                  String username = user.getUsername();
                  advisor = getOpi().loadAdvisorByUsername(username);
               }
               else
               {
                  //Application application = getOpi().loadApplication(ServletRequestUtils.getRequiredLongParameter(request, "applicationId"));
                  advisor = (Advisor) getOpi().loadAdvisorDeep(advisor.getId());
               }
               log.error("Advisor is not in Session nor Request! Loading Advisor from Username in Principle");
               WebUtils.setSessionAttribute(request, "advisor", advisor); // clear session attribute

            } catch (Exception e1)
            {
               advisor = new Advisor();
               log.error("Advisor is not in Session nor Request! Username not present in Principle either", e);
            }
         }

      }

      return advisor;
   }

   protected Advisor getAdvisorByUsername() throws ServletException
   {
      Advisor advisor= null;
            try
            {
               User user = (User)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
               String username = user.getUsername();
               advisor = getOpi().loadAdvisorByUsername(username);
            } catch (Exception e)
            {
               log.error("Advisor is not in Session nor Request! Username not present in Principle either", e);
               advisor = new Advisor();
            }
            return advisor;
   }

   /**
    * Sets up a number of custom property editors; one for the application's
    * date format, and another for empty fields.
    */
   protected void initBinder(HttpServletRequest request, ServletRequestDataBinder binder)
   {
      SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
      dateFormat.setLenient(false);
      binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true,10));
      binder.registerCustomEditor(String.class, new StringTrimmerEditor(false));
      binder.registerCustomEditor(Long.class, new CustomNumberEditor(Long.class, new DecimalFormat("###,###,###"), false));
      binder.registerCustomEditor(long.class, new CustomNumberEditor(Long.class, new DecimalFormat("###,###,###"), false));
   }

   /**
    * Method disallows duplicate form submission. Typically used to prevent
    * duplicate insertion of entities into the datastore. Shows a new form with
    * an error message.
    */
   protected ModelAndView disallowDuplicateFormSubmission(HttpServletRequest request, HttpServletResponse response)
         throws Exception
   {

      BindException errors = getErrorsForNewForm(request);
      errors.reject("duplicateFormSubmission", "Duplicate form submission");
      return showForm(request, response, errors);
   }

   public String getUserStartView(HttpServletRequest request)
   {
      WebUtils.setSessionAttribute(request, "application", null);
      Superusers superusers = (Superusers)WebUtils.getSessionAttribute(request, "superusers"); 
      if (superusers != null)
         return getSuperusersStartView();
      else
         return getAdvisorStartView();
   }

   public ModelAndView getLogoutView(HttpServletRequest request, HttpServletResponse response)
   {
      OpiRememberMeServices OpiRememberme = new OpiRememberMeServices();
      OpiRememberme.logout(request, response, SecurityContextHolder.getContext().getAuthentication());
      request.getSession().invalidate();
      return new ModelAndView(advisorStartView);
   }

   public String getAdvisorStartView()
   {
      return advisorStartView;
   }

   public String getSuperusersStartView()
   {
      return superusersStartView;
   }

   public void setSuperusersStartView(String superusersStartView)
   {
      this.superusersStartView = superusersStartView;
   }

  /**
   * Gets the logged in advisor held in the HTTP session.
   * 
   * @param request The request.
   * 
   * @return The advisor.
   * 
   * @throws RestrictedAccessException If no advisor is logged into the session. 
   */
  public Advisor getAdvisorInSession(HttpServletRequest request) throws RestrictedAccessException {
    Advisor advisor = (Advisor) WebUtils.getRequiredSessionAttribute(request, "advisor");
    
    if (advisor == null) {
      throw new RestrictedAccessException("Advisor must be in session.");
    }
    
    return advisor;
  }

}
