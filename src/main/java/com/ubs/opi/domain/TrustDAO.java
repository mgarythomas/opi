package com.ubs.opi.domain;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.LockMode;
import org.springframework.context.ApplicationContext;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

/**
 * Data access object (DAO) for domain model class Trust.
 * @see com.ubs.opi.domain.Trust
 * @author MyEclipse - Hibernate Tools
 */
public class TrustDAO extends HibernateDaoSupport {

    private static final Log log = LogFactory.getLog(TrustDAO.class);

	//property constants
	public static final String SOLICITORNAME = "solicitorname";
	public static final String ISSUPERFUND = "issuperfund";
	public static final String REVIEWDEEDS = "reviewdeeds";
	public static final String WEALTHBYEMPLOYMENT = "wealthbyemployment";
	public static final String WEALTHBYINVESTMENTS = "wealthbyinvestments";
	public static final String WEALTHBYOTHER = "wealthbyother";
	public static final String WEALTHBYOTHERINFO = "wealthbyotherinfo";

	protected void initDao() {
		//do nothing
	}

    public void save(Trust transientInstance) {
        log.debug("saving Trust instance");
        try {
            getHibernateTemplate().save(transientInstance);
            log.debug("save successful");
        } catch (RuntimeException re) {
            log.error("save failed", re);
            throw re;
        }
    }

	public void delete(Trust persistentInstance) {
        log.debug("deleting Trust instance");
        try {
            getHibernateTemplate().delete(persistentInstance);
            log.debug("delete successful");
        } catch (RuntimeException re) {
            log.error("delete failed", re);
            throw re;
        }
    }

    public Trust findById( Long id) {
        log.debug("getting Trust instance with id: " + id);
        try {
            Trust instance = (Trust) getHibernateTemplate()
                    .get("com.ubs.opi.domain.Trust", id);
            return instance;
        } catch (RuntimeException re) {
            log.error("get failed", re);
            throw re;
        }
    }


    public List findByExample(Trust instance) {
        log.debug("finding Trust instance by example");
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
      log.debug("finding Trust instance with property: " + propertyName
            + ", value: " + value);
      try {
         String queryString = "from Trust as model where model."
         						+ propertyName + "= ?";
		 return getHibernateTemplate().find(queryString, value);
      } catch (RuntimeException re) {
         log.error("find by property name failed", re);
         throw re;
      }
	}

	public List findBySolicitorname(Object solicitorname) {
		return findByProperty(SOLICITORNAME, solicitorname);
	}

	public List findByIssuperfund(Object issuperfund) {
		return findByProperty(ISSUPERFUND, issuperfund);
	}

	public List findByReviewdeeds(Object reviewdeeds) {
		return findByProperty(REVIEWDEEDS, reviewdeeds);
	}

	public List findByWealthbyemployment(Object wealthbyemployment) {
		return findByProperty(WEALTHBYEMPLOYMENT, wealthbyemployment);
	}

	public List findByWealthbyinvestments(Object wealthbyinvestments) {
		return findByProperty(WEALTHBYINVESTMENTS, wealthbyinvestments);
	}

	public List findByWealthbyother(Object wealthbyother) {
		return findByProperty(WEALTHBYOTHER, wealthbyother);
	}

	public List findByWealthbyotherinfo(Object wealthbyotherinfo) {
		return findByProperty(WEALTHBYOTHERINFO, wealthbyotherinfo);
	}

    public Trust merge(Trust detachedInstance) {
        log.debug("merging Trust instance");
        try {
            Trust result = (Trust) getHibernateTemplate()
                    .merge(detachedInstance);
            log.debug("merge successful");
            return result;
        } catch (RuntimeException re) {
            log.error("merge failed", re);
            throw re;
        }
    }

    public void attachDirty(Trust instance) {
        log.debug("attaching dirty Trust instance");
        try {
            getHibernateTemplate().saveOrUpdate(instance);
            log.debug("attach successful");
        } catch (RuntimeException re) {
            log.error("attach failed", re);
            throw re;
        }
    }

    public void attachClean(Trust instance) {
        log.debug("attaching clean Trust instance");
        try {
            getHibernateTemplate().lock(instance, LockMode.NONE);
            log.debug("attach successful");
        } catch (RuntimeException re) {
            log.error("attach failed", re);
            throw re;
        }
    }

	public static TrustDAO getFromApplicationContext(ApplicationContext ctx) {
    	return (TrustDAO) ctx.getBean("TrustDAO");
	}
}