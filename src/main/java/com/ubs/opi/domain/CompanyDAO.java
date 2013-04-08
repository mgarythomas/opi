package com.ubs.opi.domain;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.FetchMode;
import org.hibernate.LockMode;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Expression;
import org.springframework.context.ApplicationContext;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

/**
 * Data access object (DAO) for domain model class Company.
 * @see com.ubs.opi.domain.Company
 * @author MyEclipse - Hibernate Tools
 */
public class CompanyDAO extends HibernateDaoSupport {

    private static final Log log = LogFactory.getLog(CompanyDAO.class);

	//property constants
	public static final String TYPE = "type";
	public static final String NAME = "name";
	public static final String TRADINGNAME = "tradingname";
	public static final String ADDRESS1 = "address1";
	public static final String ADDRESS2 = "address2";
	public static final String SUBURB = "suburb";
	public static final String STATE = "state";
	public static final String POSTCODE = "postcode";
	public static final String TELEPHONE = "telephone";
	public static final String TFN = "tfn";
	public static final String ABN = "abn";
	public static final String ACN = "acn";
	public static final String ARBN = "arbn";
	public static final String INCORPORATIONCOUNTRY = "incorporationcountry";

	protected void initDao() {
		//do nothing
	}

    public void save(Company transientInstance) {
        log.debug("saving Company instance");
        try {
            getHibernateTemplate().save(transientInstance);
            log.debug("save successful");
        } catch (RuntimeException re) {
            log.error("save failed", re);
            throw re;
        }
    }

	public void delete(Company persistentInstance) {
        log.debug("deleting Company instance");
        try {
            getHibernateTemplate().delete(persistentInstance);
            log.debug("delete successful");
        } catch (RuntimeException re) {
            log.error("delete failed", re);
            throw re;
        }
    }

    public Company findById( Long id) {
        log.debug("getting Company instance with id: " + id);
        try {
            Company instance = (Company) getHibernateTemplate()
                    .get("com.ubs.opi.domain.Company", id);
            return instance;
        } catch (RuntimeException re) {
            log.error("get failed", re);
            throw re;
        }
    }


    public List findByExample(Company instance) {
        log.debug("finding Company instance by example");
        try {
            List results = getHibernateTemplate().findByExample(instance);
            log.debug("find by example successful, result size: " + results.size());
            return results;
        } catch (RuntimeException re) {
            log.error("find by example failed", re);
            throw re;
        }
    }

    public List findByProperty(String propertyName, Object value) {
      log.debug("finding Company instance with property: " + propertyName
            + ", value: " + value);
      try {
         String queryString = "from Company as model where model."
         						+ propertyName + "= ?";
		 return getHibernateTemplate().find(queryString, value);
      } catch (RuntimeException re) {
         log.error("find by property name failed", re);
         throw re;
      }
	}


    public List findProviders() {
       log.debug("finding all Companys with type:  PROVIDER");
       try {
          String queryString = "from Company as pro where pro.type = 'PROVIDER'";
          return getHibernateTemplate().find(queryString);
       } catch (RuntimeException re) {
          log.error("find by property name failed", re);
          throw re;
       }
   }

    public Company findProviderSimple(String name) {
       log.debug("finding Company instance with name:  " + name);
       try {
          String queryString = "from Company as pro where upper(pro.name) = ? and (pro.type = 'PROVIDER')";
          List providers = getHibernateTemplate().find(queryString, name.toUpperCase());
          return providers.size() > 0 ? (Company)providers.get(0) : null;
       } catch (RuntimeException re) {
          log.error("find by property name failed", re);
          throw re;
       }
   }

//  select pro.name, apc.name, dgc.name, ind.* 
//  from 
//  Company pro, Advisorprovider adp, Advisor adv, 
//  Individual ind, Advisorfirm adf, Company apc, Dealergroup dg, Company dgc 
//  where 
//  (pro.name = 'HFA') and (pro.id = adp.providerid) and (adp.advisorid = adv.id) and 
//  (adv.individualid = ind.id) and (adv.advisorfirmid = adf.id) and (adf.companyid = apc.id) and 
//  (dg.id = adf.dealergroupid) and (dg.companyid = dgc.id);
    public Company findProvider(String name) {
       log.debug("finding Company instance with name:  " + name);
       try {
          String queryString = "from Company as pro, Advisorprovider as adp, Individual as bdm, Advisor as adv, Individual as ind, Advisorfirm as adf, Company as afc, Dealergroup as dg, Company as dgc where " +
             "upper(pro.name) = ? and (pro = adp.company) and (bdm = adp.individual) and (adv = adp.advisor) and (ind = adv.individual) and (adf = adv.advisorfirm) and (afc = adf.company) and (dg = adf.dealergroup) and (dgc = dg.company) and (pro.type = 'PROVIDER')";
//          String queryString = "from Company as pro, Advisor as adv, Individual as ind, Advisorfirm as adf, Company as afc, Dealergroup as dg, Company as dgc left join fetch pro.advisorproviders as advisorproviders where " +
//          "upper(pro.name) = ? and (pro = adp.company) and and (adv = adp.advisor) and (ind = adv.individual) and (adf = adv.advisorfirm) and (afc = adf.company) and (dg = adf.dealergroup) and (dgc = dg.company)";
          List providers = getHibernateTemplate().find(queryString, name.toUpperCase());
          if (providers.size() > 0)
          {
             Object[] objs = (Object[])providers.get(0);          
             return (Company)objs[0];
          } else {
             return findProviderSimple(name);
          }
       } catch (RuntimeException re) {
          log.error("find by property name failed", re);
          throw re;
       }
   }
    
    public Company findProviderUsingCriterias(String companyName) {
      /*
        from Company as pro,  -
             Advisorprovider as adp,  -
             Individual as bdm, 
             Advisor as adv, 
             Individual as ind, 
             Advisorfirm as adf, 
             Company as afc, 
             Dealergroup as dg, 
             Company as dgc 
       where upper(pro.name) = ? 
         and (pro = adp.company) 
         and (bdm = adp.individual) 
         and (adv = adp.advisor) 
         
         and (ind = adv.individual) 
         and (adf = adv.advisorfirm)
          
         and (afc = adf.company) 
         and (dg  = adf.dealergroup)
          
         and (dgc = dg.company) 
         and (pro.type = 'PROVIDER')
       * 
       */
      DetachedCriteria criteria = DetachedCriteria.forClass(Company.class);

      criteria.add(Expression.eq("name", companyName).ignoreCase());
      criteria.add(Expression.eq("type", "PROVIDER"));
      
      criteria.setFetchMode("advisorproviders", FetchMode.JOIN);
      criteria.setFetchMode("advisorproviders.individual", FetchMode.JOIN);
      criteria.setFetchMode("advisorproviders.advisor", FetchMode.JOIN);
      
      criteria.setFetchMode("advisorproviders.advisor.individual", FetchMode.JOIN);
      criteria.setFetchMode("advisorproviders.advisor.advisorfirm", FetchMode.JOIN);
      
      criteria.setFetchMode("advisorproviders.advisor.advisorfirm.company", FetchMode.JOIN);
      criteria.setFetchMode("advisorproviders.advisor.advisorfirm.dealergroup", FetchMode.JOIN);
      
      criteria.setFetchMode("advisorproviders.advisor.advisorfirm.dealergroup.company", FetchMode.JOIN);
      
      
      List companies = super.getHibernateTemplate().findByCriteria(criteria);
      
      Company company;
      if (companies.size() > 0) {
        if (companies.size() > 1) {
          logger.error("More than 1 provider company found with name " + companyName 
              + ".  Using first value ...");
        }
        
        company = (Company) companies.iterator().next();
      } else {
        company = null;
      }
      
      return company;
    }
       
    public List findByType(Object type) {
		return findByProperty(TYPE, type);
	}

	public List findByName(Object name) {
		return findByProperty(NAME, name);
	}

	public List findByTradingname(Object tradingname) {
		return findByProperty(TRADINGNAME, tradingname);
	}

	public List findByAddress1(Object address1) {
		return findByProperty(ADDRESS1, address1);
	}

	public List findByAddress2(Object address2) {
		return findByProperty(ADDRESS2, address2);
	}

	public List findBySuburb(Object suburb) {
		return findByProperty(SUBURB, suburb);
	}

	public List findByState(Object state) {
		return findByProperty(STATE, state);
	}

	public List findByPostcode(Object postcode) {
		return findByProperty(POSTCODE, postcode);
	}

	public List findByTelephone(Object telephone) {
		return findByProperty(TELEPHONE, telephone);
	}

	public List findByTfn(Object tfn) {
		return findByProperty(TFN, tfn);
	}

	public List findByAbn(Object abn) {
		return findByProperty(ABN, abn);
	}

	public List findByAcn(Object acn) {
		return findByProperty(ACN, acn);
	}

	public List findByArbn(Object arbn) {
		return findByProperty(ARBN, arbn);
	}

	public List findByIncorporationcountry(Object incorporationcountry) {
		return findByProperty(INCORPORATIONCOUNTRY, incorporationcountry);
	}

    public Company merge(Company detachedInstance) {
        log.debug("merging Company instance");
        try {
            Company result = (Company) getHibernateTemplate()
                    .merge(detachedInstance);
            log.debug("merge successful");
            return result;
        } catch (RuntimeException re) {
            log.error("merge failed", re);
            throw re;
        }
    }

    public void attachDirty(Company instance) {
        log.debug("attaching dirty Company instance");
        try {
            getHibernateTemplate().saveOrUpdate(instance);
            log.debug("attach successful");
        } catch (RuntimeException re) {
            log.error("attach failed", re);
            throw re;
        }
    }

    public void attachClean(Company instance) {
        log.debug("attaching clean Company instance");
        try {
            getHibernateTemplate().lock(instance, LockMode.NONE);
            log.debug("attach successful");
        } catch (RuntimeException re) {
            log.error("attach failed", re);
            throw re;
        }
    }

	public static CompanyDAO getFromApplicationContext(ApplicationContext ctx) {
    	return (CompanyDAO) ctx.getBean("CompanyDAO");
	}

  /**
   * Initialise company's immediate properties to be used outside a session.
   * 
   * @param company The company object.
   */
  public void initialize(Company company) {
    super.getHibernateTemplate().initialize(company);
  }
  
  public void refresh(Company company) {
    if (!super.getSession().isDirty()) {
      super.getHibernateTemplate().refresh(company);
    }
  }

  /**
   * Find company by the given name.  If more than one company exists with this
   * name then only return the first company.
   * 
   * This method ignores case.
   * 
   * @param companyName The company name.
   * 
   * @return The company, or <code>null</code> if none found.
   */
  public Company findFirstCompanyWithName(String companyName) {
    DetachedCriteria criteria = DetachedCriteria.forClass(Company.class);
    
    criteria.add(Expression.eq("name", companyName).ignoreCase());
    criteria.add(Expression.eq("type", "provider").ignoreCase());
    
    List companies = super.getHibernateTemplate().findByCriteria(criteria);
    
    Company company;
    if (companies.size() != 0) {
      company = (Company) companies.iterator().next();
    } else {
      company = null;
    }
    
    return company;
  }
}