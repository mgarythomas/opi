package com.ubs.opi.domain;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.LockMode;
import org.springframework.context.ApplicationContext;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

/**
 * Data access object (DAO) for domain model class Advisorprovider.
 * @see com.ubs.opi.domain.Advisorprovider
 * @author MyEclipse - Hibernate Tools
 */
public class AdvisorproviderDAO extends HibernateDaoSupport {

    private static final Log log = LogFactory.getLog(AdvisorproviderDAO.class);

	//property constants
	public static final String ADVISORNUMBER = "advisornumber";

	protected void initDao() {
		//do nothing
	}

    public void save(Advisorprovider transientInstance) {
        log.debug("saving Advisorprovider instance");
        try {
            getHibernateTemplate().save(transientInstance);
            log.debug("save successful");
        } catch (RuntimeException re) {
            log.error("save failed", re);
            throw re;
        }
    }

	public void delete(Advisorprovider persistentInstance) {
        log.debug("deleting Advisorprovider instance");
        try {
            getHibernateTemplate().delete(persistentInstance);
            log.debug("delete successful");
        } catch (RuntimeException re) {
            log.error("delete failed", re);
            throw re;
        }
    }

    public Advisorprovider findById( Long id) {
        log.debug("getting Advisorprovider instance with id: " + id);
        try {
            Advisorprovider instance = (Advisorprovider) getHibernateTemplate()
                    .get("com.ubs.opi.domain.Advisorprovider", id);
            return instance;
        } catch (RuntimeException re) {
            log.error("get failed", re);
            throw re;
        }
    }


    public List findByExample(Advisorprovider instance) {
        log.debug("finding Advisorprovider instance by example");
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
      log.debug("finding Advisorprovider instance with property: " + propertyName
            + ", value: " + value);
      try {
         String queryString = "from Advisorprovider as model where model."
         						+ propertyName + "= ?";
		 return getHibernateTemplate().find(queryString, value);
      } catch (RuntimeException re) {
         log.error("find by property name failed", re);
         throw re;
      }
	}

	public List findByAdvisornumber(Object advisornumber) {
		return findByProperty(ADVISORNUMBER, advisornumber);
	}

    public Advisorprovider merge(Advisorprovider detachedInstance) {
        log.debug("merging Advisorprovider instance");
        try {
            Advisorprovider result = (Advisorprovider) getHibernateTemplate()
                    .merge(detachedInstance);
            log.debug("merge successful");
            return result;
        } catch (RuntimeException re) {
            log.error("merge failed", re);
            throw re;
        }
    }

    public void attachDirty(Advisorprovider instance) {
        log.debug("attaching dirty Advisorprovider instance");
        try {
            getHibernateTemplate().saveOrUpdate(instance);
            log.debug("attach successful");
        } catch (RuntimeException re) {
            log.error("attach failed", re);
            throw re;
        }
    }

    public void attachClean(Advisorprovider instance) {
        log.debug("attaching clean Advisorprovider instance");
        try {
            getHibernateTemplate().lock(instance, LockMode.NONE);
            log.debug("attach successful");
        } catch (RuntimeException re) {
            log.error("attach failed", re);
            throw re;
        }
    }

	public static AdvisorproviderDAO getFromApplicationContext(ApplicationContext ctx) {
    	return (AdvisorproviderDAO) ctx.getBean("AdvisorproviderDAO");
	}

  public void update(Advisorprovider advisorprovider) {
    super.getHibernateTemplate().update(advisorprovider);
    
  }
}