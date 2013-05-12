package org.opi.web;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.opi.domain.Dealergroup;
import org.springframework.validation.BindException;
import org.springframework.web.servlet.ModelAndView;


/**
 * JavaBean Form controller that is used to search for <code>Dealergroup</code>s by last name.
 *
 * @author Paul McLachlan
 */
public class FindDealergroupsForm extends AbstractOpiForm {

   private static final Log log = LogFactory.getLog(FindDealergroupsForm.class);

   private String selectView;
  
	/** Creates a new instance of FindDealergroupsForm */
	public FindDealergroupsForm() {
		setCommandName("dealergroup");
		// OK to start with a blank command object
		setCommandClass(Dealergroup.class);
	}

	/**
	 * Set the name of the view that should be used for selection display.
	 */
	public void setSelectView(String selectView) {
		this.selectView = selectView;
	}

	protected void initApplicationContext() {
		super.initApplicationContext();
		if (this.selectView == null) {
			throw new IllegalArgumentException("selectView isn't set");
		}
	}

	/**
	 * Method used to search for Dealergroups renders View depending on how many are found.
	 */
	protected ModelAndView onSubmit(
			HttpServletRequest request, HttpServletResponse response, Object command, BindException errors)
			throws Exception {

		Dealergroup dealergroup = (Dealergroup) command;

		// find Dealergroups by last name
		Collection results = getOpi().findDealergroups(dealergroup.getAfsl());

      Map model = new HashMap();

		if (results.size() < 1) {
			log.info("no Dealergroups found");
         model.put("dealergroupId", null); 
         model.put("afsl", dealergroup.getAfsl()); 
         return new ModelAndView(getSuccessView(), model);
		}

		if (results.size() > 1) {
//			// multiple Dealergroups found
//			return new ModelAndView(this.selectView, "selections", results);
		   log.warn("MULTIPLE DEALERGROUPS FOUND!");
      }

		// 1 Dealergroup found
      dealergroup = (Dealergroup) results.iterator().next();

      model.put("dealergroupId", dealergroup.getId()); 

		return new ModelAndView(getSuccessView(), model);
   }
   
}
