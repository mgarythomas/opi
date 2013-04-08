package com.ubs.opi.service;

import org.springframework.security.core.userdetails.User;

import com.ubs.opi.domain.Application;

/**
 * Service layer for application related business logic. 
 * 
 * @author Ana Velez
 */
public interface ApplicationServiceIF {
  /**
   * Reads the product code associated to an application.
   * 
   * @param application The application.
   * 
   * @return The product code.
   */
  String getProductCodeForApplication(Application application);
  
  /**
   * Gets the application based on the applicationId
   * 
   * @param applicationId The applicationId
   * 
   * @return The application, or <code>null</code> if none found.
   */
  Application getApplication(Long applicationId);

  /**
   * Saves changes made to an application.  Similar to 
   * Opi.storeApplicationDirty().
   * 
   * @param application The updated application.
   * @param user The user doing the modification.
   */
  void saveChanges(Application application, User user);
  

  /**
   * Returns true if the application given belongs to a citibank product.
   * 
   * @param application The application to check.
   * 
   * @return <code>true</code> if it's a citibank application.
   */
  boolean isCitibankApplication(Application application);
}
