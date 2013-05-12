package org.opi.domain;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.LockMode;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.orm.hibernate3.SessionFactoryUtils;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

//import net.sf.hibernate.Session;

/**
 * Data access object (DAO) for domain model class Logon.
 * @see org.opi.domain.Logon
 * @author MyEclipse - Hibernate Tools
 */
public class LogonDAO extends HibernateDaoSupport {

    private static final Log log = LogFactory.getLog(LogonDAO.class);

	//property constants
	public static final String USERNAME = "username";
	public static final String PWD = "pwd";
	public static final String EMAIL = "email";

	protected void initDao() {
		//do nothing
	}
    
    public void save(Logon transientInstance) {
        log.debug("saving Logon instance");
        try {
            getHibernateTemplate().save(transientInstance);
            log.debug("save successful");
        } catch (RuntimeException re) {
            log.error("save failed", re);
            throw re;
        }
    }
    
	public void delete(Logon persistentInstance) {
        log.debug("deleting Logon instance");
        try {
            getHibernateTemplate().delete(persistentInstance);
            log.debug("delete successful");
        } catch (RuntimeException re) {
            log.error("delete failed", re);
            throw re;
        }
    }
    
    public Logon findById( Long id) {
        log.debug("getting Logon instance with id: " + id);
        try {
            Logon instance = (Logon) getHibernateTemplate()
                    .get("org.opi.domain.Logon", id);
            return instance;
        } catch (RuntimeException re) {
            log.error("get failed", re);
            throw re;
        }
    }
    
    
    public List findByExample(Logon instance) {
        log.debug("finding Logon instance by example");
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
      log.debug("finding Logon instance with property: " + propertyName
            + ", value: " + value);
      try {
         String queryString = "from Logon as model where model." 
         						+ propertyName + "= ?";
         SessionFactory sessionFactory = this.getSessionFactory();
         Session session = SessionFactoryUtils.getSession(sessionFactory, true);
//         TransactionSynchronizationManager.bindResource(sessionFactory, new SessionHolder(session));

		 List result = getHibernateTemplate().find(queryString, value);

//       TransactionSynchronizationManager.unbindResource(sessionFactory);
//       SessionFactoryUtils.releaseSession(session, sessionFactory); 

      return result;

      } catch (RuntimeException re) {
         log.error("find by property name failed", re);
         throw re;
      }
	}

	public List findByUsername(Object username) {
		return findByProperty(USERNAME, username);
	}
	
	public List findByPwd(Object pwd) {
		return findByProperty(PWD, pwd);
	}
	
	public List findByEmail(Object email) {
      
		return findByProperty(EMAIL, email);
	}
	
    public Logon merge(Logon detachedInstance) {
        log.debug("merging Logon instance");
        try {
            Logon result = (Logon) getHibernateTemplate()
                    .merge(detachedInstance);
            log.debug("merge successful");
            return result;
        } catch (RuntimeException re) {
            log.error("merge failed", re);
            throw re;
        }
    }

    public void attachDirty(Logon instance) {
        log.debug("attaching dirty Logon instance");
        try {
            getHibernateTemplate().saveOrUpdate(instance);
            log.debug("attach successful");
        } catch (RuntimeException re) {
            log.error("attach failed", re);
            throw re;
        }
    }
    
    public void attachClean(Logon instance) {
        log.debug("attaching clean Logon instance");
        try {
            getHibernateTemplate().lock(instance, LockMode.NONE);
            log.debug("attach successful");
        } catch (RuntimeException re) {
            log.error("attach failed", re);
            throw re;
        }
    }

	public static LogonDAO getFromApplicationContext(ApplicationContext ctx) {
    	return (LogonDAO) ctx.getBean("LogonDAO");
	}
}