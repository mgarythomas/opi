package com.ubs.opi.web;

import java.io.FileNotFoundException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;
import org.springframework.web.util.WebUtils;

import com.ubs.opi.domain.Advisor;
import com.ubs.opi.domain.Application;
import com.ubs.opi.domain.Dealergroup;
import com.ubs.opi.service.ApplicationServiceIF;
import com.ubs.opi.service.Opi;
import com.ubs.opi.service.Pixml;

/**
 * <code>MultiActionController</code> that handles all non-form URL's.
 *
 * @author Paul McLachlan
 */
public class OpiController extends MultiActionController implements InitializingBean {
   private static final Log log = LogFactory.getLog(OpiController.class);

   private Pixml pixml;
   private Opi opi;
   private ApplicationServiceIF applicationService;

	public void setApplicationService(ApplicationServiceIF applicationService) {
    this.applicationService = applicationService;
  }

  public void setOpi(Opi opi) {
		this.opi = opi;
	}

   public void setPixml(Pixml pixml)
   {
      this.pixml = pixml;
   }

	public void afterPropertiesSet() {
		if (this.opi == null) {
			throw new IllegalArgumentException("Must set opi bean property on " + getClass());
		}
	}

	/**
	 * Custom handler for the welcome view.
	 * <p>Note that this handler returns an empty ModelAndView object.
	 * It relies on the RequestToViewNameTranslator to come up with
	 * a view name based on the request URL: "/welcome.html" -> "welcome",
	 * plus configured "View" suffix -> "welcomeView".
	 * @param request current HTTP request
	 * @param response current HTTP response
	 * @return a ModelAndView to render the response
	 */
	public ModelAndView welcomeHandler(HttpServletRequest request, HttpServletResponse response) {
		return new ModelAndView();
	}

   /**
    * Custom handler for the welcome view.
    * <p>Note that this handler returns an empty ModelAndView object.
    * It relies on the RequestToViewNameTranslator to come up with
    * a view name based on the request URL: "/checklist.htm" -> "checklist",
    * plus configured "View" suffix -> "checklistView".
    * @param request current HTTP request
    * @param response current HTTP response
    * @return a ModelAndView to render the response
    */
   public ModelAndView checklistHandler(HttpServletRequest request, HttpServletResponse response) {
      if (WebUtils.hasSubmitParameter(request, "checked"))
      {
         log.info("forwarding to redirect:/advisorapplications.htm");
         Map<String, Object> model = new HashMap<String, Object>();
         model.put("advisorId", ServletRequestUtils.getLongParameter(request, "advisorId", 0));
         return new ModelAndView("redirect:/advisorapplications.htm").addAllObjects(model);
      }
      log.info("forwarding to ???");
      WebUtils.setSessionAttribute(request, "advisorId", ServletRequestUtils.getLongParameter(request, "advisorId", 0)); // clear session attribute
      return new ModelAndView();
   }

   //checkAndPrepare(request, response, lastModified)

	/**
	 * Custom handler for owner display.
	 * <p>Note that this handler usually returns a ModelAndView object
	 * without view, also leveraging convention-based model attribute names.
	 * It relies on the RequestToViewNameTranslator to come up with
	 * a view name based on the request URL: "/dealergroup.html" -> "dealergroup",
	 * plus configured "View" suffix -> "ownerView".
	 * @param request current HTTP request
	 * @param response current HTTP response
	 * @return a ModelAndView to render the response
	 */
   public ModelAndView dealergroupHandler(HttpServletRequest request, HttpServletResponse response) {
      Dealergroup dealergroup = this.opi.loadDealergroup(ServletRequestUtils.getLongParameter(request, "dealergroupId", 0));
      if (dealergroup == null) {
         return new ModelAndView("redirect:/findDealergroups.htm");
      }
      return new ModelAndView().addObject(dealergroup);
   }

   
   public ModelAndView directdebitHandler(HttpServletRequest request, HttpServletResponse response) {
      Dealergroup dealergroup = this.opi.loadDealergroup(ServletRequestUtils.getLongParameter(request, "dealergroupId", 0));
      if (dealergroup == null) {
         return new ModelAndView("redirect:/findDealergroups.htm");
      }
      return new ModelAndView().addObject(dealergroup);
   }
   
   /**
    * Custom handler for advisorindividual display.
    * <p>Note that this handler usually returns a ModelAndView object
    * without view, also leveraging convention-based model attribute names.
    * It relies on the RequestToViewNameTranslator to come up with
    * a view name based on the request URL: "/advisorindividuals.html" -> "advisorindividuals",
    * plus configured "View" suffix -> "advisorindividualsView".
    * @param request current HTTP request
    * @param response current HTTP response
    * @return a ModelAndView to render the response
    */
   public ModelAndView advisorindividualsHandler(HttpServletRequest request, HttpServletResponse response) {
      Advisor advisor = this.opi.loadAdvisor(ServletRequestUtils.getLongParameter(request, "advisorId", 0));
      if (advisor == null) { // never enters here
         return new ModelAndView("redirect:/advisorindividuals.htm");
      }
      return new ModelAndView().addObject(advisor);
   }

   public ModelAndView logoutHandler(HttpServletRequest request, HttpServletResponse response) {
      // effectively boot the User out
      SecurityContextHolder.clearContext();

      return new ModelAndView("/j_spring_security_logout");
   }

   public ModelAndView advisorfirmHandler(HttpServletRequest request, HttpServletResponse response) {
      Dealergroup dealergroup = this.opi.loadDealergroup(ServletRequestUtils.getLongParameter(request, "dealergroupId", 0));
      if (dealergroup == null) {
         return new ModelAndView("redirect:/findDealergroups.htm");
      }

      return new ModelAndView().addObject(dealergroup);
      //return new ModelAndView().addObject(advisorfirm);
   }

   /**
    * Custom handler for countries PDF document.
    * @param request current HTTP request
    * @param response current HTTP response
    * @return a ModelAndView to render the response
    */
   public ModelAndView pdfHandler(HttpServletRequest request, HttpServletResponse response) throws ServletException, FileNotFoundException {
     
      Long applicationId = ServletRequestUtils.getLongParameter(request, "applicationId");
     
      String xmlFilename = pixml.createXml(applicationId.toString());
      
      // determine which stylesheet to use:
      Application application = this.applicationService.getApplication(applicationId);
      
      String applicationProductCode = 
        this.applicationService.getProductCodeForApplication(application);
      
      ModelAndView modelAndView;
      if (StringUtils.equalsIgnoreCase(applicationProductCode, "hfa")) {
        modelAndView = new ModelAndView("pdfViewHfa", "xmlFilename", xmlFilename);
      } else if (StringUtils.equalsIgnoreCase(applicationProductCode, "citibank1")) {
        modelAndView = new ModelAndView("pdfViewCitibankAud", "xmlFilename", xmlFilename);
      } else if (StringUtils.equalsIgnoreCase(applicationProductCode, "citibank2")) {
        modelAndView = new ModelAndView("pdfViewCitibankUsd", "xmlFilename", xmlFilename);
      } else {
        throw new ServletException("Unknown product code '" + applicationProductCode + "' given for application id " + applicationId);
      }
      
      return modelAndView;
   }
}
