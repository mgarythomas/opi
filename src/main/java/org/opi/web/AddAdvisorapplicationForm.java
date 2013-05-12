package org.opi.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.opi.domain.Advisor;
import org.opi.domain.Application;
import org.opi.domain.Company;
import org.opi.domain.Constants;
import org.opi.domain.Individual;
import org.opi.domain.Investorindividual;
import org.opi.domain.Product;
import org.opi.domain.Trust;
import org.opi.domain.Utils;
import org.opi.service.AdvisorServiceIF;
import org.opi.validation.AdvisorapplicationFormValidator;
import org.springframework.dao.DataAccessException;
import org.springframework.validation.BindException;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.WebUtils;


/**
 * JavaBean form controller that is used to add a new <code>Advisor</code> with
 * Role.type "Advisor" to the system.
 * 
 * @author Paul McLachlan
 */
public class AddAdvisorapplicationForm extends AbstractOpiForm {

	private static final Log log = LogFactory
			.getLog(AdvisorapplicationsForm.class);

	private AdvisorServiceIF advisorService;

	private String beneficiaryView;

	/**
	 * Set the name of the view that should be used for beneficiary display.
	 */
	public void setBeneficiaryView(String beneficiaryView) {
		this.beneficiaryView = beneficiaryView;
	}

	public AddAdvisorapplicationForm() {
		setCommandName("application");
		// need a session to hold the formBackingObject
		setSessionForm(true);
	}

	protected boolean isFormSubmission(HttpServletRequest request) {
		return super.isFormSubmission(request);
		// logger.info("request method = " + request.getMethod());
		// return true;
	}

	/**
	 * Sets up the application command object. If we came in via a GET request
	 * then we create a new application. Otherwise, load the application from
	 * the session.
	 * 
	 * @return Application command object.
	 */
	protected Object formBackingObject(HttpServletRequest request)
			throws ServletException {
		Application application = null;

		// This "remove" parameter means that we just removed an applicant. see
		// onSubmit().
		if (request.getParameter("remove") != null) {
			if (logger.isDebugEnabled()) {
				logger.debug("Removing applicant ...");
			}
			application = this.getApplication(request, true);

			return application;
		}

		if (request.getParameter("edit") != null) {
			if (logger.isDebugEnabled()) {
				logger.debug("Editing existing application ...");
			}
			try {
				application = super.getApplicationWithId(request, true);
			} catch (Exception e) {
				throw new ServletException("Can't find an Application", e);
			}

			return application;
		}

		try {
			if (ServletRequestUtils.getRequiredBooleanParameter(request,
					"newapplicant")) {
				application = this.getApplication(request, true);

				Investorindividual investorindividual = new Investorindividual();
				investorindividual.setIndividual(new Individual());
				String role = Constants.APPLICANT;
				investorindividual.setIsapplicant(Constants.TRUE);
				if ((application.getType() == Constants.CORPORATE_TYPE)
						|| (application.getType() == Constants.CORPORATE_TRUST_TYPE)) {
					investorindividual.setIsdirector(Constants.TRUE);
					role = Constants.DIRECTOR;
				} else if (application.getType() == Constants.PRIVATE_TRUST_TYPE) {
					investorindividual.setIstrustee(Constants.TRUE);
					role = Constants.TRUSTEE;
				}
				// TODO for different types of Individual associations
				investorindividual.setRole(role);
				investorindividual.setApplication(application);
				application.addInvestorindividual(investorindividual);
				log.info("newApplicant Created");
				return application;
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			log.debug("Can't locate an application");
		}

		// Long investorType = ServletRequestUtils.getLongParameter(request,
		// "investorType");
		// Long productId = ServletRequestUtils.getLongParameter(request,
		// "productId");
		Long productId = new Long((String) WebUtils.getSessionAttribute(
				request, "productId"));
		Long investorType = new Long((String) WebUtils.getSessionAttribute(
				request, "investorType"));
		if (logger.isInfoEnabled()) {
			logger.info("Loading addAdvisorApplications page with investorType = "
					+ investorType + ", and productId = " + productId);
		}
		Product product = this.advisorService.findProductById(productId);
		if (investorType < 5) {
			// New application.
			if (logger.isDebugEnabled()) {
				logger.debug("Creating new application for product " + product);
			}
			application = createApplication(request, investorType, product);
		} else {
			// Clone existing application.
			Application original = this.getOpi().loadApplication(investorType);
			application = original.clone();

			// If we have cloned an application with a sole director we need to
			// allow space to add another one.
			if (application.isSoledirector()) {
				Investorindividual investorindividual = new Investorindividual();
				investorindividual.setRole(Constants.DIRECTOR);
				investorindividual.setIsdirector(Constants.TRUE);
				investorindividual.setIstrustee(Constants.FALSE);
				investorindividual.setIndividual(new Individual());
				application.addInvestorindividual(investorindividual);
			}

			if (productId != null) {
				if (logger.isDebugEnabled()) {
					logger.debug("Setting cloned application's product to "
							+ product);
				}

				application.setProduct(product);
			}
		}

		WebUtils.setSessionAttribute(request, "application", application);

		return application;
	}

	/**
	 * @see org.springframework.web.servlet.mvc.SimpleFormController#referenceData(javax.servlet.http.HttpServletRequest)
	 */
	@Override
	protected Map referenceData(HttpServletRequest request) throws Exception {
		Map<String, Object> ref = new HashMap<String, Object>();
		ref.put("titles", Utils.getTitles());
		ref.put("states", Utils.getStates());
		// ref.put("defaultstates", Utils.getStates());
		ref.put("defaultcountries", Utils.getDefaultCountries());
		ref.put("countries", Utils.getCountries());
		ref.put("nationalities", Utils.getNationalities());
		ref.put("startpage", StringUtils.removeStart(
				super.getUserStartView(request), "redirect:/"));
		return ref;
	}

	/** Method inserts a new <code>Advisor</code>. */
	protected ModelAndView onSubmit(HttpServletRequest request,
			HttpServletResponse response, Object command, BindException errors)
			throws Exception {
		Application application = (Application) command;
		application.setApplicantindex(0);

		Map<String, Object> model = new HashMap<String, Object>();

		try {
			String investorindex = ServletRequestUtils
					.getRequiredStringParameter(request, "investorindex");

			if (!investorindex.equals("null")) { // WebUtils.hasSubmitParameter(request,
													// "remove"))
				int i = ServletRequestUtils.getRequiredIntParameter(request,
						"investorindex");

				try {
					getOpi().removeInvestor(application, i); // persist all
																// changes
				} catch (Exception e) {
					log.debug("Couldn't remove Applicant");
				}
				model.put("remove", true);
				// WebUtils.setSessionAttribute(request, "application",
				// application);
				log.info("removed applicant from Application, id="
						+ application.getId() + " status="
						+ application.getStatus() + " accountdesignation="
						+ application.getAccountdesignation());
				return new ModelAndView("redirect:/addAdvisorapplication.htm",
						model);
			}
		} catch (Exception e) {
			log.debug("investorindex not present");
		}

		AdvisorapplicationFormValidator.validateDesignate(application, errors);
		if (!WebUtils.hasSubmitParameter(request, "addinvestor")) {
			AdvisorapplicationFormValidator.validateIndividuals(application,
					errors);
		}
		if (errors.hasErrors())
			return showForm(request, response, errors);

		// test for template update
		if (application.getTemplate() != null) {
			Application template = application.getTemplate();
			if (template.getAccountdesignation().equals(
					application.getAccountdesignation())) {
				template.setIslatest(Constants.FALSE);
				getOpi().storeApplicationDirty(template);
				application.setTemplate(null);
			}
		}

		getOpi().storeApplication(application); // persist all changes

		if (WebUtils.hasSubmitParameter(request, "addinvestor")) {
			model.put("newapplicant", true);
			WebUtils.setSessionAttribute(request, "application", application);
			log.info("setSessionAttribute Application; id="
					+ application.getId() + " status="
					+ application.getStatus() + " accountdesignation="
					+ application.getAccountdesignation());
			return new ModelAndView("redirect:/addAdvisorapplication.htm",
					model);
		}

		if (WebUtils.hasSubmitParameter(request, "save"))
			return new ModelAndView(this.getUserStartView(request));

		// model.put("applicationId", application.getId());
		WebUtils.setSessionAttribute(request, "application", application);
		log.info("setSessionAttribute Application; id=" + application.getId()
				+ " status=" + application.getStatus() + " accountdesignation="
				+ application.getAccountdesignation());

		if (application.getProduct().getCode().equals("hfa")
				&& (application.getType() == Constants.CORPORATE_TYPE || application
						.getType() == Constants.CORPORATE_TRUST_TYPE)) {
			return new ModelAndView(this.beneficiaryView, model);
		} else {
			return new ModelAndView(getSuccessView(), model);
		}
	}

	protected ModelAndView handleInvalidSubmit(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		return disallowDuplicateFormSubmission(request, response);
	}

	public Application createApplication(HttpServletRequest request,
			long investorType, Product product) throws ServletException {
		Application application = new Application();
		application.setCreatedby(Utils.getUser().getUsername());

		try {
			Advisor advisor = getAdvisor(request, false);
			application.setAdvisor(advisor);
			application.setProduct(product);
			application.setCommission(product.getMaxcommission());

			Investorindividual investorindividual1 = new Investorindividual();
			Individual individual1 = new Individual();
			Investorindividual investorindividual2; // = new
													// Investorindividual();
			Individual individual2; // = new Individual();

			if (investorType == Constants.CORPORATE_TYPE) {
				investorindividual2 = new Investorindividual();
				individual2 = new Individual();
				investorindividual1.setRole(Constants.DIRECTOR);
				investorindividual2.setRole(Constants.DIRECTOR);
				investorindividual1.setIsdirector(Constants.TRUE);
				investorindividual2.setIsdirector(Constants.TRUE);
				investorindividual1.setIstrustee(Constants.FALSE);
				investorindividual2.setIstrustee(Constants.FALSE);
				investorindividual1.setIsapplicant(Constants.TRUE);
				investorindividual2.setIsapplicant(Constants.TRUE);
				investorindividual1.setIndividual(individual1);
				investorindividual2.setIndividual(individual2);
				application.addInvestorindividual(investorindividual1);
				application.addInvestorindividual(investorindividual2);
			} else if (investorType == Constants.CORPORATE_TRUST_TYPE) {
				investorindividual2 = new Investorindividual();
				individual2 = new Individual();
				investorindividual1.setRole(Constants.DIRECTOR);
				investorindividual2.setRole(Constants.DIRECTOR);
				investorindividual1.setIsdirector(Constants.TRUE);
				investorindividual2.setIsdirector(Constants.TRUE);
				investorindividual1.setIstrustee(Constants.TRUE);
				investorindividual2.setIstrustee(Constants.TRUE);
				investorindividual1.setIsapplicant(Constants.TRUE);
				investorindividual2.setIsapplicant(Constants.TRUE);
				investorindividual1.setIndividual(individual1);
				investorindividual2.setIndividual(individual2);
				application.addInvestorindividual(investorindividual1);
				application.addInvestorindividual(investorindividual2);
			} else if (investorType == Constants.JOINT_TYPE) {
				investorindividual2 = new Investorindividual();
				individual2 = new Individual();
				investorindividual1.setRole(Constants.APPLICANT);
				investorindividual2.setRole(Constants.APPLICANT);
				investorindividual1.setIsdirector(Constants.FALSE);
				investorindividual2.setIsdirector(Constants.FALSE);
				investorindividual1.setIstrustee(Constants.FALSE);
				investorindividual2.setIstrustee(Constants.FALSE);
				investorindividual1.setIsapplicant(Constants.TRUE);
				investorindividual2.setIsapplicant(Constants.TRUE);
				investorindividual1.setIndividual(individual1);
				investorindividual2.setIndividual(individual2);
				application.addInvestorindividual(investorindividual1);
				application.addInvestorindividual(investorindividual2);
			} else if (investorType == Constants.PRIVATE_TRUST_TYPE) {
				investorindividual1.setRole(Constants.TRUSTEE);
				investorindividual1.setIstrustee(Constants.TRUE);
				investorindividual1.setIsdirector(Constants.FALSE);
				investorindividual1.setIsapplicant(Constants.TRUE);
				investorindividual1.setIndividual(individual1);
				application.addInvestorindividual(investorindividual1);
			} else if (investorType == Constants.INDIVIDUAL_TYPE) {
				investorindividual1.setRole(Constants.APPLICANT);
				investorindividual1.setIstrustee(Constants.FALSE);
				investorindividual1.setIsdirector(Constants.FALSE);
				investorindividual1.setIsapplicant(Constants.TRUE);
				investorindividual1.setIndividual(individual1);
				application.addInvestorindividual(investorindividual1);
			}

			application.setType(investorType);

			if ((investorType == Constants.CORPORATE_TYPE)
					|| (investorType == Constants.CORPORATE_TRUST_TYPE)) {
				application.setCompany(new Company());
			}

			if ((investorType == Constants.PRIVATE_TRUST_TYPE)
					|| (investorType == Constants.CORPORATE_TRUST_TYPE)) {
				Trust trust = new Trust();
				Company company = new Company();
				company.setType(Constants.CORPORATE_TRUST);
				trust.setCompanyByCompanyid(company);
				application.setTrust(trust);
			}

		} catch (DataAccessException e) {
			log.error("Could not Create Application", e);
			throw e;
		}
		return application;
	}

	public void setAdvisorService(AdvisorServiceIF advisorService) {
		this.advisorService = advisorService;
	}
}
