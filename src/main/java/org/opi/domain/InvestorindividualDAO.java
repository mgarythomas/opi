package org.opi.domain;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

public class InvestorindividualDAO extends HibernateDaoSupport {
  //~ Methods ------------------------------------------------------------------

  public void save(Investorindividual transientInstance) {
    getHibernateTemplate().save(transientInstance);
  }

  public void delete(Investorindividual persistentInstance) {
    getHibernateTemplate().delete(persistentInstance);
  }

  public Investorindividual merge(Investorindividual detachedInstance) {
    logger.debug("merging Investorindividual instance");

    Investorindividual result =
      (Investorindividual) getHibernateTemplate().merge(detachedInstance);
    logger.debug("merge successful");
    return result;
  }

  public void attachDirty(Investorindividual instance) {
    getHibernateTemplate().saveOrUpdate(instance);
  }

  public void update(Investorindividual investorindividual) {
    super.getHibernateTemplate().update(investorindividual);
  }

  public Investorindividual findById(Long investorindividualId) {
    return (Investorindividual) super.getHibernateTemplate().get(
      Investorindividual.class,
      investorindividualId);
  }

  //~ Static fields/initializers -----------------------------------------------

  private static final Log logger =
    LogFactory.getLog(InvestorindividualDAO.class);
}
