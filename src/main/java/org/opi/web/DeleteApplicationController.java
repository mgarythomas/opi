package org.opi.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.opi.service.AdvisorServiceIF;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;


/**
 * Controller to delete an application.
 *
 * @author Ana Velez
 */
public class DeleteApplicationController implements Controller {
  public ModelAndView handleRequest(HttpServletRequest request,
                                    HttpServletResponse response) throws Exception {
    Long applicationId = ServletRequestUtils.getLongParameter(request, "applicationId");
    
    if (applicationId != null) {
      if (logger.isDebugEnabled()) {
        logger.debug("Deleting application ...");
      }
      this.advisorService.deleteApplicationOfId(applicationId);
    }
    
    return new ModelAndView(this.successView);
  }
  
  /**
   * @param advisorService the advisorService to set
   */
  public void setAdvisorService(AdvisorServiceIF advisorService) {
    this.advisorService = advisorService;
  }

  /**
   * @param successView the successView to set
   */
  public void setSuccessView(String successView) {
    this.successView = successView;
  }
  
  private String successView;
  
  private AdvisorServiceIF advisorService;
   
  private static final Log logger = LogFactory.getLog(DeleteApplicationController.class);
}
