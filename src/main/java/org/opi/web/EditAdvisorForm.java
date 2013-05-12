package org.opi.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.opi.domain.Advisor;
import org.opi.domain.Utils;
import org.opi.service.AdvisorServiceIF;
import org.springframework.web.servlet.ModelAndView;


/**
 * Form to edit Advisor details.
 *
 * @author Paul McLachlan
 * @author Ana Velez
 */
public class EditAdvisorForm extends AbstractOpiForm {
  //~ Constructors -------------------------------------------------------------

  public EditAdvisorForm() {
    setCommandName("advisor");
    setSessionForm(true);
  }

  //~ Methods ------------------------------------------------------------------

  @Override
  protected Map referenceData(HttpServletRequest request)
                       throws Exception {
    Map<String, Object> ref = new HashMap<String, Object>();

    ref.put("titles", Utils.getTitles());
    ref.put("states", Utils.getStates());

    return ref;
  }

  @Override
  protected Object formBackingObject(HttpServletRequest request)
                              throws ServletException {
    Advisor advisorInSession = super.getAdvisor(request, false);
    
    Advisor advisor = this.advisorService.loadAdvisorForEditing(advisorInSession.getId());
    
    return advisor;
  }

  @Override
  protected ModelAndView onSubmit(Object command) throws ServletException {
    Advisor advisor = (Advisor)command;

    if (logger.isDebugEnabled()) {
      logger.debug("Saving details ...");
    }
    
    this.advisorService.updateAdvisorDetails(advisor, advisor.getAdvisorfirm());
    
    return new ModelAndView(this.getSuccessView());
  }

  @Override
  protected ModelAndView handleInvalidSubmit(HttpServletRequest request,
                                             HttpServletResponse response)
                                      throws Exception {
    return disallowDuplicateFormSubmission(request, response);
  }

  /**
   * @param advisorService the advisorService to set
   */
  public void setAdvisorService(AdvisorServiceIF advisorService) {
    this.advisorService = advisorService;
  }

  //~ Static fields/initializers -----------------------------------------------

  private static final Log logger = LogFactory.getLog(EditAdvisorForm.class);

  //~ Instance fields ----------------------------------------------------------

  private AdvisorServiceIF advisorService;
}
