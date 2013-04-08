package com.ubs.opi.domain;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.LockMode;
import org.springframework.context.ApplicationContext;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

/**
 * Data access object (DAO) for domain model class Advisorindividual.
 * @see com.ubs.opi.domain.Advisorindividual
 * @author MyEclipse - Hibernate Tools
 */
public class AdvisorindividualDAO extends HibernateDaoSupport {

    private static final Log log = LogFactory.getLog(AdvisorindividualDAO.class);

	//property constants

	protected void initDao() {
		//do nothing
	}
    
    public void save(Advisorindividual transientInstance) {
        log.debug("saving Advisorindividual instance");
        try {
            getHibernateTemplate().save(transientInstance);
            log.debug("save successful");
        } catch (RuntimeException re) {
            log.error("save failed", re);
            throw re;
        }
    }
    
	public void delete(Advisorindividual persistentInstance) {
        log.debug("deleting Advisorindividual instance");
        try {
            getHibernateTemplate().delete(persistentInstance);
            log.debug("delete successful");
        } catch (RuntimeException re) {
            log.error("delete failed", re);
            throw re;
        }
    }
    
    public Advisorindividual findById( Long id) {
        log.debug("getting Advisorindividual instance with id: " + id);
        try {
            Advisorindividual instance = (Advisorindividual) getHibernateTemplate()
                    .get("com.ubs.opi.domain.Advisorindividual", id);
            return instance;
        } catch (RuntimeException re) {
            log.error("get failed", re);
            throw re;
        }
    }
    
    
    public List findByExample(Advisorindividual instance) {
        log.debug("finding Advisorindividual instance by example");
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
      log.debug("finding Advisorindividual instance with property: " + propertyName
            + ", value: " + value);
      try {
         String queryString = "from Advisorindividual as model where model." 
         						+ propertyName + "= ?";
		 return getHibernateTemplate().find(queryString, value);
      } catch (RuntimeException re) {
         log.error("find by property name failed", re);
         throw re;
      }
	}

    public Advisorindividual merge(Advisorindividual detachedInstance) {
        log.debug("merging Advisorindividual instance");
        try {
            Advisorindividual result = (Advisorindividual) getHibernateTemplate()
                    .merge(detachedInstance);
            log.debug("merge successful");
            return result;
        } catch (RuntimeException re) {
            log.error("merge failed", re);
            throw re;
        }
    }

    public void attachDirty(Advisorindividual instance) {
        log.debug("attaching dirty Advisorindividual instance");
        try {
            getHibernateTemplate().saveOrUpdate(instance);
            log.debug("attach successful");
        } catch (RuntimeException re) {
            log.error("attach failed", re);
            throw re;
        }
    }
    
    public void attachClean(Advisorindividual instance) {
        log.debug("attaching clean Advisorindividual instance");
        try {
            getHibernateTemplate().lock(instance, LockMode.NONE);
            log.debug("attach successful");
        } catch (RuntimeException re) {
            log.error("attach failed", re);
            throw re;
        }
    }

	public static AdvisorindividualDAO getFromApplicationContext(ApplicationContext ctx) {
    	return (AdvisorindividualDAO) ctx.getBean("AdvisorindividualDAO");
	}
}