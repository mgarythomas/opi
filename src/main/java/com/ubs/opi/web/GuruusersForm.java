package com.ubs.opi.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindException;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.servlet.ModelAndView;

import com.ubs.opi.domain.Guruusers;

/**
 * JavaBean form controller that is used to view/add/modify <code>Dealergroups</code>
 * 
 * @author Paul McLachlan
 */
public class GuruusersForm extends AbstractOpiForm {

  private static final Log log = LogFactory.getLog(GuruusersForm.class);

  private String existingView;
  private String createadvisorView;
  private String editView;
  private String advisorfirmsView;

/**
    * Set the name of the view that should be used for existing display.
    */
   public void setExistingView(String existingView) {
      this.existingView = existingView;
   }

   public void setAdvisorfirmsView(String advisorfirmsView) {
      this.advisorfirmsView = advisorfirmsView;
     }

   public void setCreateadvisorView(String createadvisorView) {
      this.createadvisorView = createadvisorView;
   }

   public void setEditView(String editView) {
      this.editView = editView;
   }

	public GuruusersForm() {
		setCommandName("guruusers");
		// need a session to hold the formBackingObject
		setSessionForm(true);
	}

	/**
	 * Method creates a new <code>Application</code> with the correct
	 * <code>Advisor</code> info
	 */
	@Override
   protected Object formBackingObject(HttpServletRequest request) throws ServletException {
      Guruusers guruusers = new Guruusers();
//      List<Dealergroup> dgs = this.getOpi().loadDealergroups();
//      guruusers.setDealergroups(this.getOpi().loadDealergroups());
//      WebUtils.setSessionAttribute(request, "guruusers", guruusers);
		return guruusers;
	}

	/** Method inserts a new <code>Guruuser</code>. */
	@Override
   protected ModelAndView onSubmit(HttpServletRequest request, HttpServletResponse response, Object command, BindException errors) throws Exception 
   {
      Guruusers guruusers = (Guruusers) command;
      
      String dealergroupid = ServletRequestUtils.getStringParameter(request, "dealergroupid"); // dgafsl
      if (StringUtils.hasText(dealergroupid)) {
         Map model = new HashMap<String,String>();
         model.put("dealergroupid", dealergroupid);
         return new ModelAndView(this.advisorfirmsView, model);
      }

      // should never get here
      return new ModelAndView(this.existingView);

	}

	@Override
   protected ModelAndView handleInvalidSubmit(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		return disallowDuplicateFormSubmission(request, response);
	}

}
