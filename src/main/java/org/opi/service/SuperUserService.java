package org.opi.service;

import java.util.LinkedList;
import java.util.List;


import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.opi.domain.Product;
import org.opi.domain.ProductDAO;

/**
 * Default implementation for {@link SuperUserServiceIF}
 *
 * @author Ana Velez
 */
public class SuperUserService implements SuperUserServiceIF {
  //~ Methods ------------------------------------------------------------------

  public List<Product> getProductsToDisplayForSuperusers() {
    if (logger.isDebugEnabled()) {
      logger.debug("Returning all products ...");
    }

    return new LinkedList<Product>(this.productDAO.readAllProducts());
  }

  public void setProductDAO(ProductDAO productDAO) {
    this.productDAO = productDAO;
  }

  //~ Static fields/initializers -----------------------------------------------

  private static final Log logger = LogFactory.getLog(SuperUserService.class);

  //~ Instance fields ----------------------------------------------------------

  private ProductDAO productDAO;
}
