package org.opi.web.controller.login;

import java.util.Collection;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.opi.domain.Advisor;
import org.opi.domain.Constants;
import org.opi.domain.Superusers;
import org.opi.service.Opi;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;
import org.springframework.web.util.WebUtils;


/**
 * Controller to redirect uses to their first page after login depending on who
 * they are.
 * 
 * @author Ana Velez
 */
public class MainPageRedirectionController implements Controller {
	// ~ Methods
	// ------------------------------------------------------------------

	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws ServletException {
		Authentication authentication = SecurityContextHolder.getContext()
				.getAuthentication();

		Collection<? extends GrantedAuthority> grantedAuthorities = authentication
				.getAuthorities();

		List<String> authoritiesAsList = returnAsList(grantedAuthorities);

		ModelAndView modelAndView = null;

		if (authoritiesAsList.contains(Constants.DATAENTRY)
				|| authoritiesAsList.contains(Constants.ADMINISTRATOR)) {
			Superusers superusers = (Superusers) WebUtils.getSessionAttribute(
					request, "superusers");

			if (superusers != null) {
				superusers.setTransadvisor(new Advisor(-1));
				superusers.setTransadvisorId(new Long(Constants.NEW_DOMAIN_ID));
			} else {
				if (logger.isDebugEnabled()) {
					logger.debug("No Superuser in Session");
				}
			}

			if (logger.isInfoEnabled()) {
				logger.info("Super user logged in.");
			}
			modelAndView = new ModelAndView("redirect:/superusers.htm");
		} else if (authoritiesAsList.contains(Constants.BDM)) {
			if (logger.isInfoEnabled()) {
				logger.info("BDM logged in.");
			}
			modelAndView = new ModelAndView("redirect:/bdmusers.htm");
		} else if (authoritiesAsList.contains(Constants.GURU)) {
			if (logger.isInfoEnabled()) {
				logger.info("Guru user logged in.");
			}
			modelAndView = new ModelAndView("redirect:/guruusers.htm");
		} else {
			User user = (User) authentication.getPrincipal();
			String username = user.getUsername();

			if (StringUtils.equalsIgnoreCase(username, "dealer")) {
				modelAndView = new ModelAndView(
						"redirect:/findDealergroups.htm");
			} else {
				Advisor advisor = this.opiService
						.loadAdvisorByUsername(username);

				if (advisor == null) {
					logger.error("Cannot determine user role for username "
							+ username);
					throw new ServletException("Unknown user role.");
				}

				if (logger.isInfoEnabled()) {
					logger.info("Adviser logged in.");
				}

				WebUtils.setSessionAttribute(request, "advisorId",
						advisor.getId());
				WebUtils.setSessionAttribute(request, "advisor", advisor);

				if (StringUtils.equalsIgnoreCase(advisor.getIsactivated(),
						"false")) {
					modelAndView = new ModelAndView(
							"redirect:/advisorcomplete.htm");
				} else if (StringUtils.equalsIgnoreCase(
						advisor.getPasswordconfirmed(), "false")) {
					modelAndView = new ModelAndView(
							"redirect:/changepassword.htm");
				} else {
					modelAndView = new ModelAndView(
							"redirect:/advisorapplications.htm");
				}
			}
		}

		return modelAndView;
	}

	/**
	 * Convienience method to return granted authorities array as a list of
	 * string.
	 * 
	 * @param grantedAuthorities
	 *            granted authorities array.
	 * 
	 * @return string list.
	 */
	private static List<String> returnAsList(
			Collection<? extends GrantedAuthority> grantedAuthorities) {
		List<String> authoritiesAsList = new LinkedList<String>();

		for (GrantedAuthority authority : grantedAuthorities) {
			logger.debug("Adding Authority :"+authority.getAuthority());
			authoritiesAsList.add(authority.getAuthority());
		}

		return authoritiesAsList;
	}

	/**
	 * @param opiService
	 *            the opiService to set
	 */
	public void setOpiService(Opi opiService) {
		this.opiService = opiService;
	}

	// ~ Static fields/initializers
	// -----------------------------------------------

	private static final Log logger = LogFactory
			.getLog(MainPageRedirectionController.class);

	// ~ Instance fields
	// ----------------------------------------------------------

	private Opi opiService;
}
