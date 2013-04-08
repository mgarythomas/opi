package com.ubs.opi.domain;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.LockMode;
import org.springframework.context.ApplicationContext;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

/**
 * Data access object (DAO) for domain model class Authorities.
 * @see com.ubs.opi.domain.Authorities
 * @author MyEclipse - Hibernate Tools
 */
public class AuthoritiesDAO extends HibernateDaoSupport {

    private static final Log log = LogFactory.getLog(AuthoritiesDAO.class);

	//property constants

	protected void initDao() {
		//do nothing
	}

    public void save(Authorities transientInstance) {
        log.debug("saving Authorities instance");
        try {
            getHibernateTemplate().save(transientInstance);
            log.debug("save successful");
        } catch (RuntimeException re) {
            log.error("save failed", re);
            throw re;
        }
    }

	public void delete(Authorities persistentInstance) {
        log.debug("deleting Authorities instance");
        try {
            getHibernateTemplate().delete(persistentInstance);
            log.debug("delete successful");
        } catch (RuntimeException re) {
            log.error("delete failed", re);
            throw re;
        }
    }

    public Authorities findById( com.ubs.opi.domain.AuthoritiesId id) {
        log.debug("getting Authorities instance with id: " + id);
        try {
            Authorities instance = (Authorities) getHibernateTemplate()
                    .get("com.ubs.opi.domain.Authorities", id);
            return instance;
        } catch (RuntimeException re) {
            log.error("get failed", re);
            throw re;
        }
    }


    public List findByExample(Authorities instance) {
        log.debug("finding Authorities instance by example");
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
      log.debug("finding Authorities instance with property: " + propertyName
            + ", value: " + value);
      try {
         String queryString = "from Authorities as model where model."
         						+ propertyName + "= ?";
		 return getHibernateTemplate().find(queryString, value);
      } catch (RuntimeException re) {
         log.error("find by property name failed", re);
         throw re;
      }
	}

    public Authorities merge(Authorities detachedInstance) {
        log.debug("merging Authorities instance");
        try {
            Authorities result = (Authorities) getHibernateTemplate()
                    .merge(detachedInstance);
            log.debug("merge successful");
            return result;
        } catch (RuntimeException re) {
            log.error("merge failed", re);
            throw re;
        }
    }

    public void attachDirty(Authorities instance) {
        log.debug("attaching dirty Authorities instance");
        try {
            getHibernateTemplate().saveOrUpdate(instance);
            log.debug("attach successful");
        } catch (RuntimeException re) {
            log.error("attach failed", re);
            throw re;
        }
    }

    public void attachClean(Authorities instance) {
        log.debug("attaching clean Authorities instance");
        try {
            getHibernateTemplate().lock(instance, LockMode.NONE);
            log.debug("attach successful");
        } catch (RuntimeException re) {
            log.error("attach failed", re);
            throw re;
        }
    }

	public static AuthoritiesDAO getFromApplicationContext(ApplicationContext ctx) {
    	return (AuthoritiesDAO) ctx.getBean("AuthoritiesDAO");
	}
}