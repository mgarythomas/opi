package org.opi.domain;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

public class ProductDAO extends HibernateDaoSupport {
  //~ Methods ------------------------------------------------------------------

  public Product findById(Long productId) {
    return (Product) super.getHibernateTemplate().get(Product.class, productId);
  }

  public List findByName(String name) {
    if (logger.isDebugEnabled()) {
      logger.debug("Finding product by name " + name);
    }

    DetachedCriteria criteria = DetachedCriteria.forClass(Product.class);
    criteria.add(Restrictions.eq("name", name));

    return super.getHibernateTemplate().findByCriteria(criteria);
  }

  /**
   * Reads all products that have an associated provider.
   *
   * @return All products that have a matching provider.
   */
  @SuppressWarnings("unchecked")
  public Set<Product> readAllProducts() {
    List<Product> productsList =
      super.getHibernateTemplate().find("from Product");

    return new HashSet<Product>(productsList);
  }

  //~ Static fields/initializers -----------------------------------------------

  private static final Log logger = LogFactory.getLog(ProductDAO.class);
}
