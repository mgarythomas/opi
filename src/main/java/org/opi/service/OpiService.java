package org.opi.service;

import java.util.Comparator;
import java.util.Set;
import java.util.TreeSet;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.opi.domain.Advisor;
import org.opi.domain.AdvisorDAO;
import org.opi.domain.Application;
import org.opi.domain.ApplicationComp;
import org.opi.domain.ApplicationDAO;
import org.opi.domain.Company;
import org.opi.domain.CompanyDAO;
import org.opi.domain.Constants;
import org.opi.domain.Product;
import org.opi.domain.ProductDAO;

public class OpiService implements OpiServiceIF {

	public Set<Application> getApplicationsManagedByAdvisor(Advisor advisor) {
		this.advisorDao.refresh(advisor);

		Set<Application> applications = advisor.getApplications();

		Set<Application> filteredApplications = new TreeSet<Application>(
				new ApplicationComp());
		for (Application application : applications) {
			if (application.getStatus() == Constants.CANCELLED_STATUS) {
				continue;
			}
			filteredApplications.add(application);
		}

		return filteredApplications;
	}

	public Set<Product> getProductsForPortalTheme(String theme) {
		Set<Product> products;

		products = this.productDao.readAllProducts();
		return products;
	}

	public Application getApplicationById(Long applicationId) {
		return this.applicationDao.findById(applicationId);
	}

	public Application getApplicationByIdForEditing(Long applicationId) {
		Application application = this.applicationDao
				.findApplicationByIdWithDependencies(applicationId);

		return application;
	}

	public void deleteApplication(Application application) {
		logger.error("STUB to delete");
	}

	public boolean isDaApproved(Advisor advisor) {
		this.advisorDao.refresh(advisor);
		return StringUtils.equalsIgnoreCase(advisor.getAdvisorfirm()
				.getDealergroup().getIsdaapproved(), "true");
	}

	/**
	 * @param advisorDao
	 *            the advisorDao to set
	 */
	public void setAdvisorDao(AdvisorDAO advisorDao) {
		this.advisorDao = advisorDao;
	}

	/**
	 * @param companyDao
	 *            the companyDao to set
	 */
	public void setCompanyDao(CompanyDAO companyDao) {
		this.companyDao = companyDao;
	}

	/**
	 * @param productDao
	 *            the productDao to set
	 */
	public void setProductDao(ProductDAO productDao) {
		this.productDao = productDao;
	}

	/**
	 * @param applicationDao
	 *            the applicationDao to set
	 */
	public void setApplicationDao(ApplicationDAO applicationDao) {
		this.applicationDao = applicationDao;
	}

	private AdvisorDAO advisorDao;
	private CompanyDAO companyDao;
	private ProductDAO productDao;
	private ApplicationDAO applicationDao;

	private static final Log logger = LogFactory.getLog(OpiService.class);
}
