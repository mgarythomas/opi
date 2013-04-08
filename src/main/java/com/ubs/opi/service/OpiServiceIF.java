package com.ubs.opi.service;

import java.util.List;
import java.util.Set;

import com.ubs.opi.domain.Advisor;
import com.ubs.opi.domain.Application;
import com.ubs.opi.domain.Product;

/**
 * Main service layer for the OPI application.
 * 
 * @author Ana Velez
 */
public interface OpiServiceIF {
  /**
   * Gets applications to be display on an advisor's main page.
   * 
   * This method would apply any business logic to filter out certain 
   * applications, such as those that are cancelled. 
   * 
   * @param advisor The advisor.
   * 
   * @return Set of applications the advisor can display.
   */
  Set<Application> getApplicationsManagedByAdvisor(Advisor advisor);

  /**
   * Gets the products to display on the advisor's main page.
   * 
   * The products returned depend on the theme value passes in.
   * 
   * @param theme The current session theme.  <code>null</code> would indicate
   *        the default UBS theme.
   * 
   * @return {@link List} of products.
   */
  Set<Product> getProductsForPortalTheme(String theme);

  /**
   * Reads an application by it's ID.
   * 
   * @param applicationId The applicationId.
   * 
   * @return The application.
   */
  Application getApplicationById(Long applicationId);

  /**
   * Reads an application by it's ID and loads all dependencies needed for
   * the application wizard pages.
   * 
   * @param applicationId The application ID.
   * 
   * @return The application.
   */
  Application getApplicationByIdForEditing(Long applicationId);
  
  /**
   * Delete the given application.
   * 
   * XXX get advisor object in here ?
   * 
   * @param applicationId The application.
   */
  void deleteApplication(Application application);

  /**
   * Checks if an adviser's dealer group is DA approved.
   * 
   * @param advisor The advisor to check.
   * 
   * @return true of false.
   */
  boolean isDaApproved(Advisor advisor);

}
