package com.ubs.opi.domain;

import java.util.List;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.LockMode;
import org.springframework.context.ApplicationContext;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

/**
 * Data access object (DAO) for domain model class Users.
 * @see com.ubs.opi.domain.Users
 * @author MyEclipse - Hibernate Tools
 */
public class UsersDAO extends HibernateDaoSupport {

    private static final Log log = LogFactory.getLog(UsersDAO.class);

	//property constants
	public static final String PASSWORD = "password";
	public static final String PASSWORDCONFIRMED = "passwordconfirmed";
	public static final String ENABLED = "enabled";

	protected void initDao() {
		//do nothing
	}

    public void save(Users transientInstance) {
        log.debug("saving Users instance");
        try {
            getHibernateTemplate().save(transientInstance);
            log.debug("save successful");
        } catch (RuntimeException re) {
            log.error("save failed", re);
            throw re;
        }
    }

	public void delete(Users persistentInstance) {
        log.debug("deleting Users instance");
        try {
            getHibernateTemplate().delete(persistentInstance);
            log.debug("delete successful");
        } catch (RuntimeException re) {
            log.error("delete failed", re);
            throw re;
        }
    }

    public Users findById( java.lang.String id) {
        log.debug("getting Users instance with id: " + id);
        try {
            Users instance = (Users) getHibernateTemplate()
                    .get("com.ubs.opi.domain.Users", id);
            return instance;
        } catch (RuntimeException re) {
            log.error("get failed", re);
            throw re;
        }
    }


    public List findByExample(Users instance) {
        log.debug("finding Users instance by example");
        try {
            List results = getHibernateTemplate().findByExample(instance);
            log.debug("find by example successful, result size: " + results.size());
            return results;
        } catch (RuntimeException re) {
            log.error("find by example failed", re);
            throw re;
        }
    }

//    select usr.username, ind.lastname, adv.id, app.accountdesignation, pro.name 
//    from Users usr, Individual ind, Advisor adv, Application app, Product pro
//    where (usr.username = 'KhannKa') and (usr.username = ind.username) and (adv.individualid = ind.id)
//    and (app.advisorid = adv.id) and (pro.id = app.productid);
  public Users findByUsername(String name) {
     log.debug("finding Company instance with name:  " + name);
     try {
//        String queryString = "from Users as usr, Individual as ind, Advisor as adv, Application as app, Product as pro where " +
//        "(usr.username = ?) and (usr = ind.users) and (ind = adv.individual) and (adv = app.advisor) and (pro = app.product)";
        String queryString = "from Users as usr, Individual as ind, Advisor as adv left join fetch adv.applications as applications where " +
          "(usr.username = ?) and (usr = ind.users) and (ind = adv.individual)";
        List users = getHibernateTemplate().find(queryString, name);
        if (users.size() > 0)
        {
           Object[] objs = (Object[])users.get(0);
           return (Users)objs[0];
        }
        else
           return null;
     } catch (RuntimeException re) {
        log.error("find by property name failed", re);
        throw re; 
     }
 }
    
    public List findByProperty(String propertyName, Object value) {
      log.debug("finding Users instance with property: " + propertyName
            + ", value: " + value);
      try {
         String queryString = "from Users as model where model."
         						+ propertyName + "= ?";
		 return getHibernateTemplate().find(queryString, value);
      } catch (RuntimeException re) {
         log.error("find by property name failed", re);
         throw re;
      }
	}

	public List findByPassword(Object password) {
		return findByProperty(PASSWORD, password);
	}

	public List findByPasswordconfirmed(Object passwordconfirmed) {
		return findByProperty(PASSWORDCONFIRMED, passwordconfirmed);
	}

	public List findByEnabled(Object enabled) {
		return findByProperty(ENABLED, enabled);
	}

    public Users merge(Users detachedInstance) {
        log.debug("merging Users instance");
        try {
            Users result = (Users) getHibernateTemplate()
                    .merge(detachedInstance);
            log.debug("merge successful");
            return result;
        } catch (RuntimeException re) {
            log.error("merge failed", re);
            throw re;
        }
    }

    // added by paulmac
    public void update(Users instance) {
       log.debug("updating Application instance");
       try {
           getHibernateTemplate().update(instance);
           log.debug("update successful");
       } catch (RuntimeException re) {
           log.error("update failed", re);
           throw re;
       }
   }

    public void attachDirty(Users instance) {
        log.debug("attaching dirty Users instance");
        try {
            getHibernateTemplate().saveOrUpdate(instance);
            log.debug("attach successful");
        } catch (RuntimeException re) {
            log.error("attach failed", re);
            throw re;
        }
    }

    public void attachClean(Users instance) {
        log.debug("attaching clean Users instance");
        try {
            getHibernateTemplate().lock(instance, LockMode.NONE);
            log.debug("attach successful");
        } catch (RuntimeException re) {
            log.error("attach failed", re);
            throw re;
        }
    }

	public static UsersDAO getFromApplicationContext(ApplicationContext ctx) {
    	return (UsersDAO) ctx.getBean("UsersDAO");
	}

  /**
   * Refresh the state of a user domain model.
   * 
   * @param user The domain model.
   */
  public void refresh(Users user) {
    if (!super.getSession().isDirty()) {
      super.getHibernateTemplate().refresh(user);
    }
  }
}