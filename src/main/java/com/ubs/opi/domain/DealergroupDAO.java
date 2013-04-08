package com.ubs.opi.domain;

import java.util.ArrayList;
import java.util.List;
//import java.util.Set;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.LockMode;
import org.springframework.context.ApplicationContext;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

/**
 * Data access object (DAO) for domain model class Dealergroup.
 * @see com.ubs.opi.domain.Dealergroup
 * @author MyEclipse - Hibernate Tools
 */
public class DealergroupDAO extends HibernateDaoSupport {

    private static final Log log = LogFactory.getLog(DealergroupDAO.class);

   //property constants
   public static final String AFSL = "afsl";
   public static final String ISDAAPPROVED = "isdaapproved";

   protected void initDao() {
      //do nothing
   }

   public boolean doesNotAdvisorHaveAdvisorfirms(Long id) {
      List values = super.getHibernateTemplate().find("select count(*) from Dealergroup as dg where dg.id = ? and dg.advisorfirms is empty", id);
      
      Number count = (Number) values.iterator().next();
      
      return count.intValue() != 0;
    }

   public void save(Dealergroup transientInstance) {
        log.debug("saving Dealergroup instance");
        try {
            getHibernateTemplate().save(transientInstance);
            log.debug("save successful");
        } catch (RuntimeException re) {
            log.error("save failed", re);
            throw re;
        }
    }

   public void delete(Dealergroup persistentInstance) {
        log.debug("deleting Dealergroup instance");
        try {
            getHibernateTemplate().delete(persistentInstance);
            log.debug("delete successful");
        } catch (RuntimeException re) {
            log.error("delete failed", re);
            throw re;
        }
    }

    public Dealergroup findById(Long id) {
        log.debug("getting Dealergroup instance with id: " + id);
        try {
           String queryString = "from Dealergroup as dg, Company as dgc where (dg.id = ?) and (dgc = dg.company)";
           List list = getHibernateTemplate().find(queryString, id);
           if (list.size() > 0) {
              log.info("Found Dealergroup with id="+id);
              Object[] objs = (Object[])list.get(0);
              return (Dealergroup)objs[0]; 
           }
           else
              return null;
        } catch (RuntimeException re) {
           log.error("find by property name failed", re);
           throw re;
        }
    }

    public List findByExample(Dealergroup instance) {
        log.debug("finding Dealergroup instance by example");
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
      log.debug("finding Dealergroup instance with property: " + propertyName
            + ", value: " + value);
      try {
         String queryString = "from Dealergroup as model where model."+ propertyName + "= ?";
       return getHibernateTemplate().find(queryString, value);
      } catch (RuntimeException re) {
         log.error("find by property name failed", re);
         throw re;
      }
   }

   public List<Dealergroup> findByAfsl(Object afsl) {
      return findByProperty(AFSL, afsl);
   }

      public Dealergroup findDgByAfsl(Object afsl) {
      log.debug("getting Dealergroup, Company with instance with afsl: " + afsl);
       try {
          String queryString = "from Dealergroup as dg, Company as dgc where (dg.afsl = ?) and (dgc = dg.company)";
          List list = getHibernateTemplate().find(queryString, afsl);
          if (list.size() > 0) {
             log.info("Found Dealergroup with afsl="+afsl);
             Object[] objs = (Object[])list.get(0);
             return (Dealergroup)objs[0]; 
          }
          else
             return new Dealergroup(new Company(), (String)afsl);
       } catch (RuntimeException re) {
          log.error("find by property name failed", re);
          throw re;
       }
   }

      public Dealergroup findDgAndAfsByAfsl(Object afsl) {
         log.debug("getting Dealergroup, Advisorfirm, Company with instance with afsl: " + afsl);
          try {
             String queryString = "from Dealergroup as dg, Advisorfirm as adf, Company as afc where (dg.afsl = ?) and (dg = adf.dealergroup) and (afc = adf.company) order by upper(afc.name)";
             List list = getHibernateTemplate().find(queryString, afsl);
             if (list.size() > 0) {
                log.info("Found Dealergroup with afsl="+afsl);
                Object[] objs = (Object[])list.get(0);
                return (Dealergroup)objs[0]; 
             }
             else
                return new Dealergroup(new Company(), (String)afsl);
          } catch (RuntimeException re) {
             log.error("find by property name failed", re);
             throw re;
          }
      }

      public List<Dealergroup> findAll() {
         log.debug("finding all Dealergroups");
         try {
            String queryString = "from Dealergroup as dg, Company as com where (com = dg.company) order by upper(com.name)";
            List<Object[]> objects = getHibernateTemplate().find(queryString);
            List<Dealergroup> dgs = new ArrayList<Dealergroup>();
            for ( Object[] object : objects)
               dgs.add((Dealergroup)object[0]);
            return dgs;
         } catch (RuntimeException re) {
            log.error("find by property name failed", re);
            throw re;
         }
     }
      
   public List findByIsdaapproved(Object isdaapproved) {
      return findByProperty(ISDAAPPROVED, isdaapproved);
   }

    public Dealergroup merge(Dealergroup detachedInstance) {
        log.debug("merging Dealergroup instance");
        try {
            Dealergroup result = (Dealergroup) getHibernateTemplate().merge(detachedInstance);
            log.debug("merge successful");
            return result;
        } catch (RuntimeException re) {
            log.error("merge failed", re);
            throw re;
        }
    }

    public void attachDirty(Dealergroup instance) {
        log.debug("attaching dirty Dealergroup instance");
        try {
            getHibernateTemplate().saveOrUpdate(instance);
            log.debug("attach successful");
        } catch (RuntimeException re) {
            log.error("attach failed", re);
            throw re;
        }
    }

    public void attachClean(Dealergroup instance) {
        log.debug("attaching clean Dealergroup instance");
        try {
            getHibernateTemplate().lock(instance, LockMode.NONE);
            log.debug("attach successful");
        } catch (RuntimeException re) {
            log.error("attach failed", re);
            throw re;
        }
    }

   public static DealergroupDAO getFromApplicationContext(ApplicationContext ctx) {
      return (DealergroupDAO) ctx.getBean("DealergroupDAO");
   }
}