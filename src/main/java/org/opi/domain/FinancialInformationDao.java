package org.opi.domain;

import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

public class FinancialInformationDao extends HibernateDaoSupport {

  public void save(FinancialInformation newFinancialInformation) {
    super.getHibernateTemplate().save(newFinancialInformation);
  }

  public void update(FinancialInformation existingFinancialInformation) {
    super.getHibernateTemplate().update(existingFinancialInformation);
  }

  public void delete(FinancialInformation financialInformation) {
    super.getHibernateTemplate().delete(financialInformation);
  }
  
}
