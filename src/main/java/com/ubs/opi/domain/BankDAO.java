package com.ubs.opi.domain;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.LockMode;
import org.springframework.context.ApplicationContext;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

/**
 * Data access object (DAO) for domain model class Bank.
 * @see com.ubs.opi.domain.Bank
 * @author MyEclipse - Hibernate Tools
 */
public class BankDAO extends HibernateDaoSupport {

    private static final Log log = LogFactory.getLog(BankDAO.class);

	//property constants
	public static final String TYPE = "type";
	public static final String NAME = "name";
	public static final String ADDRESS1 = "address1";
	public static final String SUBURB = "suburb";
	public static final String STATE = "state";
	public static final String POSTCODE = "postcode";
	public static final String TELEPHONE = "telephone";

	protected void initDao() {
		//do nothing
	}
    
    public void save(Bank transientInstance) {
        log.debug("saving Bank instance");
        try {
            getHibernateTemplate().save(transientInstance);
            log.debug("save successful");
        } catch (RuntimeException re) {
            log.error("save failed", re);
            throw re;
        }
    }
    
	public void delete(Bank persistentInstance) {
        log.debug("deleting Bank instance");
        try {
            getHibernateTemplate().delete(persistentInstance);
            log.debug("delete successful");
        } catch (RuntimeException re) {
            log.error("delete failed", re);
            throw re;
        }
    }
    
    public Bank findById( java.lang.String id) {
        log.debug("getting Bank instance with id: " + id);
        try {
            Bank instance = (Bank) getHibernateTemplate()
                    .get("com.ubs.opi.domain.Bank", id);
            return instance;
        } catch (RuntimeException re) {
            log.error("get failed", re);
            throw re;
        }
    }
    
    
    public List findByExample(Bank instance) {
        log.debug("finding Bank instance by example");
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
      log.debug("finding Bank instance with property: " + propertyName
            + ", value: " + value);
      try {
         String queryString = "from Bank as model where model." 
         						+ propertyName + "= ?";
		 return getHibernateTemplate().find(queryString, value);
      } catch (RuntimeException re) {
         log.error("find by property name failed", re);
         throw re;
      }
	}

	public List findByType(Object type) {
		return findByProperty(TYPE, type);
	}
	
	public List findByName(Object name) {
		return findByProperty(NAME, name);
	}
	
	public List findByAddress1(Object address1) {
		return findByProperty(ADDRESS1, address1);
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
	
    public Bank merge(Bank detachedInstance) {
        log.debug("merging Bank instance");
        try {
            Bank result = (Bank) getHibernateTemplate()
                    .merge(detachedInstance);
            log.debug("merge successful");
            return result;
        } catch (RuntimeException re) {
            log.error("merge failed", re);
            throw re;
        }
    }

    public void attachDirty(Bank instance) {
        log.debug("attaching dirty Bank instance");
        try {
            getHibernateTemplate().saveOrUpdate(instance);
            log.debug("attach successful");
        } catch (RuntimeException re) {
            log.error("attach failed", re);
            throw re;
        }
    }
    
    public void attachClean(Bank instance) {
        log.debug("attaching clean Bank instance");
        try {
            getHibernateTemplate().lock(instance, LockMode.NONE);
            log.debug("attach successful");
        } catch (RuntimeException re) {
            log.error("attach failed", re);
            throw re;
        }
    }

	public static BankDAO getFromApplicationContext(ApplicationContext ctx) {
    	return (BankDAO) ctx.getBean("BankDAO");
	}
}