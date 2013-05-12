package org.opi.service;

import java.util.Date;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.opi.domain.Application;
import org.opi.domain.ApplicationDAO;
import org.springframework.security.core.userdetails.User;


public class ApplicationService implements ApplicationServiceIF {
  public String getProductCodeForApplication(Application application) {
    this.applicationDAO.refresh(application);
    
    String productCode = application.getProduct().getCode();
    
    if (logger.isDebugEnabled()) {
      logger.debug("product code for application = " + productCode);
    }
    
    return productCode;
  }
  
  public Application getApplication(Long applicationId) {
    Application application = this.applicationDAO.findById(applicationId);
    
    return application;
  }
  
  public void saveChanges(Application application, User user) {
    application.setModifiedby(user.getUsername());
    application.setRecordModified(new Date());
    this.applicationDAO.update(application);
  }
  
  public boolean isCitibankApplication(Application application) {
    // Application persisApplication = this.applicationDao.findById(application.getId());
    
    String productCode = application.getProduct().getCode();
    
    return StringUtils.equalsIgnoreCase(productCode, "citibank1") || // TODO remove hardcoded values from here.
           StringUtils.equalsIgnoreCase(productCode, "citibank2");
  }
  
  public void setApplicationDAO(ApplicationDAO applicationDAO) {
    this.applicationDAO = applicationDAO;
  }
  
  private ApplicationDAO applicationDAO;
  
  private static final Log logger = LogFactory.getLog(ApplicationService.class);
}
