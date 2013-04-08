package com.ubs.opi.service;

import java.util.List;
import java.util.Set;

import com.ubs.opi.domain.Advisor;
import com.ubs.opi.domain.Advisorfirm;
import com.ubs.opi.domain.Application;
import com.ubs.opi.domain.ApplicationDirectCreditDetails;
import com.ubs.opi.domain.FinancialInformation;
import com.ubs.opi.domain.Individual;
import com.ubs.opi.domain.Investorindividual;
import com.ubs.opi.domain.Product;

import com.ubs.opi.exception.IncorrectRelationshipException;

/**
 * Service layer for operations that advisors can do.
 *
 * @author Ana Velez
 */
public interface AdvisorServiceIF {
  //~ Methods ------------------------------------------------------------------

  /**
   * Gets applications belonging to the given advisor that can be displayed
   * on the front end.  This means that all cancelled applications would be
   * filtered out.
   *
   * @param advisor The advisor.
   *
   * @return The applications.
   */
  Set<Application> getApplicationsToDisplay(Advisor advisor);

  /**
   * Similar to {@link #getApplicationsToDisplay(Advisor)}, but doesn't return
   * two applications with the same application designation.
   *
   * @param advisor The advisor.
   *
   * @return The applications.
   */
  Set<Application> getApplicationsToDisplayUnique(Advisor advisor);

  /**
   * Updates an advisor's details based on the given domain models.
   *
   * @param advisor
   */
  void updateAdvisorDetails(Advisor advisor, Advisorfirm advisorfirm);

  /**
   * Load advisor details for the edit-advisor page.
   *
   * @param advisorId The advisor id.
   *
   * @return The advisor with updatable dependencies.
   */
  Advisor loadAdvisorForEditing(long advisorId);

  /**
   * Findas the product by its ID.
   *
   * @param productId The product ID.
   *
   * @return The product.
   */
  Product findProductById(Long productId);

  /**
   * Find application by id.
   *
   * @param id The application id.
   *
   * @return The application.
   */
  Application findApplicationById(Long applicationId);

  /**
   * Loads an application with all dependencies that can be modified by the
   * adviser.
   *
   * @param applicationId The application Id.
   *
   * @return The application.
   */
  Application loadApplicationForEditing(Long applicationId);

  /**
   * Deletes application with the given id.
   *
   * @param applicationId The application.
   */
  void deleteApplicationOfId(Long applicationId);

  /**
   * Updates an application's direct credit details.
   *
   * @param application The application.
   * @param directCreditDetails The direct credit details.
   *
   * @throws IncorrectRelationshipException if the application already has an
   *         association to another direct credit details object, or
   *         vice-versa.
   */
  void updateDirectCreditDetails(Application application,
                                 ApplicationDirectCreditDetails directCreditDetails)
                          throws IncorrectRelationshipException;

  /**
   * Gets the products that the advisor can sell based on the logged in
   * theme.
   *
   * @param theme The logged in theme.
   *
   * @return The products matching the theme.
   */
  List<Product> getProductsToDisplayForTheme(String theme);

  /**
   * @param application
   * @param transientGuarantor
   * @param individual
   */
  void associateAsGuarantor(Application application,
                            Investorindividual transientGuarantor,
                            Individual transientIndividual,
                            FinancialInformation transientFinancialInformation);

  /**
   * Removes additional guarantors for the given application.
   * 
   * @param application The applicaiton.
   */
  void removeAdditionalGuarantor(Application application);

  /**
   * Finds an investorindividual by the given id.
   * 
   * @param investorindividualId The investor individual id.
   * 
   * @return The investor individiual.
   */
  Investorindividual findInvestorIndividualById(Long investorindividualId);
}
