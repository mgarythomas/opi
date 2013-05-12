package org.opi.domain;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.LockMode;
import org.springframework.context.ApplicationContext;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

/**
 * Data access object (DAO) for domain model class AclPermission.
 * @see org.opi.domain.AclPermission
 * @author MyEclipse - Hibernate Tools
 */
public class AclPermissionDAO extends HibernateDaoSupport {

    private static final Log log = LogFactory.getLog(AclPermissionDAO.class);

	//property constants
	public static final String RECIPIENT = "recipient";
	public static final String MASK = "mask";

	protected void initDao() {
		//do nothing
	}

    public void save(AclPermission transientInstance) {
        log.debug("saving AclPermission instance");
        try {
            getHibernateTemplate().save(transientInstance);
            log.debug("save successful");
        } catch (RuntimeException re) {
            log.error("save failed", re);
            throw re;
        }
    }

	public void delete(AclPermission persistentInstance) {
        log.debug("deleting AclPermission instance");
        try {
            getHibernateTemplate().delete(persistentInstance);
            log.debug("delete successful");
        } catch (RuntimeException re) {
            log.error("delete failed", re);
            throw re;
        }
    }

    public AclPermission findById( Long id) {
        log.debug("getting AclPermission instance with id: " + id);
        try {
            AclPermission instance = (AclPermission) getHibernateTemplate()
                    .get("org.opi.domain.AclPermission", id);
            return instance;
        } catch (RuntimeException re) {
            log.error("get failed", re);
            throw re;
        }
    }


    public List findByExample(AclPermission instance) {
        log.debug("finding AclPermission instance by example");
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
      log.debug("finding AclPermission instance with property: " + propertyName
            + ", value: " + value);
      try {
         String queryString = "from AclPermission as model where model."
         						+ propertyName + "= ?";
		 return getHibernateTemplate().find(queryString, value);
      } catch (RuntimeException re) {
         log.error("find by property name failed", re);
         throw re;
      }
	}

	public List findByRecipient(Object recipient) {
		return findByProperty(RECIPIENT, recipient);
	}

	public List findByMask(Object mask) {
		return findByProperty(MASK, mask);
	}

    public AclPermission merge(AclPermission detachedInstance) {
        log.debug("merging AclPermission instance");
        try {
            AclPermission result = (AclPermission) getHibernateTemplate()
                    .merge(detachedInstance);
            log.debug("merge successful");
            return result;
        } catch (RuntimeException re) {
            log.error("merge failed", re);
            throw re;
        }
    }

    public void attachDirty(AclPermission instance) {
        log.debug("attaching dirty AclPermission instance");
        try {
            getHibernateTemplate().saveOrUpdate(instance);
            log.debug("attach successful");
        } catch (RuntimeException re) {
            log.error("attach failed", re);
            throw re;
        }
    }

    public void attachClean(AclPermission instance) {
        log.debug("attaching clean AclPermission instance");
        try {
            getHibernateTemplate().lock(instance, LockMode.NONE);
            log.debug("attach successful");
        } catch (RuntimeException re) {
            log.error("attach failed", re);
            throw re;
        }
    }

	public static AclPermissionDAO getFromApplicationContext(ApplicationContext ctx) {
    	return (AclPermissionDAO) ctx.getBean("AclPermissionDAO");
	}
}