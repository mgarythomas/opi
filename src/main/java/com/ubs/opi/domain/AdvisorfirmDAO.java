package com.ubs.opi.domain;

import java.util.List;
import java.util.ArrayList;

import javax.sql.DataSource;
//import java.util.Set;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.LockMode;
import org.springframework.context.ApplicationContext;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

/**
 * Data access object (DAO) for domain model class Advisorfirm.
 * @see com.ubs.opi.domain.Advisorfirm
 * @author MyEclipse - Hibernate Tools
 */
public class AdvisorfirmDAO extends HibernateDaoSupport {

    private static final Log log = LogFactory.getLog(AdvisorfirmDAO.class);

   //property constants

   protected void initDao() {
      //do nothing
   }
   private JdbcTemplate jdbcTemplate;
   
   public void setDataSource(DataSource dataSource) {
     this.jdbcTemplate = new JdbcTemplate(dataSource);
   }
   

// The Jdbc equivilant:
//   public boolean doesNotAdvisorHaveApplications(Long advisorId) {
//     int count = this.jdbcTemplate.queryForInt(
//         "select count(*) as total from advisor where id not in " +
//         "(select distinct advisorId from application where " +
//         "advisorid is not null) and id = ?", 
//         new Object[] { advisorId });
//     
//     return count != 0;
//   }
   
//    The Hibernate equivilant:
   public boolean doesNotAdvisorHaveAdvisors(Long advisorfirmId) {
     List values = super.getHibernateTemplate().find("select count(*) from Advisorfirm as advisorfirm where advisorfirm.id = ? and advisorfirm.advisors is empty", advisorfirmId);
     
     Number count = (Number) values.iterator().next();
     
     return count.intValue() != 0;
   }
   
   public Advisorfirm findAdvisorsById(Long id) {
      log.debug("getting Advisorfirm and Advisors with instance with id: " + id);
      try {
         String queryString = "from Advisorfirm as af, Company as afc left join fetch af.advisors as advisors where (af.id = ?) and (af.company = afc)";
         List objectList = getHibernateTemplate().find(queryString, id);
         Object[] objarray = (Object[])objectList.get(0);
         return (Advisorfirm)objarray[0];
      } catch (RuntimeException re) {
         log.error("find by property name failed", re);
         throw re;
      }
   }


   public Advisorfirm findByAbn(Object afsl, Object abn) {
     log.debug("getting Advisorfirm, Company with instance with abn: " + abn);
     String queryString = "from Advisorfirm as adf, Dealergroup as dg, Company as afc where adf.dealergroup = dg and afc = adf.company and dg.afsl = ? and afc.abn = ?";
     List afs = getHibernateTemplate().find(queryString, new Object[]{afsl,abn});
     
     Advisorfirm advisorfirm;
     if (afs.size() > 0) {
       log.info("Found Advisorfirm with abn="+abn +" and Dealergroup with afsl="+afsl);
       Object[] objs = (Object[])afs.get(0);
       advisorfirm = (Advisorfirm) objs[0]; 
     }
     else {
       advisorfirm = null;
     }
     
     return advisorfirm;
   }


    public void save(Advisorfirm transientInstance) {
        log.debug("saving Advisorfirm instance");
        try {
            getHibernateTemplate().save(transientInstance);
            log.debug("save successful");
        } catch (RuntimeException re) {
            log.error("save failed", re);
            throw re;
        }
    }
    
   public void delete(Advisorfirm persistentInstance) {
        log.debug("deleting Advisorfirm instance");
        try {
            getHibernateTemplate().delete(persistentInstance);
            log.debug("delete successful");
        } catch (RuntimeException re) {
            log.error("delete failed", re);
            throw re;
        }
    }
    
    public Advisorfirm findById( Long id) {
        log.debug("getting Advisorfirm instance with id: " + id);
        try {
//            Advisorfirm instance = (Advisorfirm) getHibernateTemplate()
//                    .get("com.ubs.opi.domain.Advisorfirm", id);
//            return instance;
//
            String queryString = "from Advisorfirm as adf, Company as afc where afc = adf.company and adf.id = ?";
            List afs = getHibernateTemplate().find(queryString, id);
            if (afs.size() > 0) {
               log.info("Found Advisorfirm with id="+id);
               Object[] objs = (Object[])afs.get(0);
               return (Advisorfirm)objs[0]; 
            }
            else
               return null;
        } catch (RuntimeException re) {
            log.error("get failed", re);
            throw re;
        }
    }
    
    public List<Advisorfirm> findByDealergroupId(Object id) {
       log.debug("getting Dealergroup, Advisorfirm, Company with instance with Dealergroup.id: " + id);
       List<Advisorfirm> afs = new ArrayList<Advisorfirm>();
        try {
           String queryString = "from Advisorfirm as adf, Company as afc, Dealergroup as dg where (dg.id = ?) and (dg = adf.dealergroup) and (afc = adf.company) order by upper(afc.name)";

           List<Object[]> list = getHibernateTemplate().find(queryString, id);
           if (list.size() > 0) {
              log.info("Found Dealergroup with id="+id);
              for (Object[] obj: list) {
//                 log.debug(arg0)
                 afs.add((Advisorfirm)obj[0]);
              }              
           }
        } catch (RuntimeException re) {
           log.error("find by property name failed", re);
           throw re;
        }
        return afs; 
    }
    
    public List findByExample(Advisorfirm instance) {
        log.debug("finding Advisorfirm instance by example");
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
      log.debug("finding Advisorfirm instance with property: " + propertyName
            + ", value: " + value);
      try {
         String queryString = "from Advisorfirm as model where model." 
                           + propertyName + "= ?";
       return getHibernateTemplate().find(queryString, value);
      } catch (RuntimeException re) {
         log.error("find by property name failed", re);
         throw re;
      }
   }

    public Advisorfirm merge(Advisorfirm detachedInstance) {
        log.debug("merging Advisorfirm instance");
        try {
            Advisorfirm result = (Advisorfirm) getHibernateTemplate()
                    .merge(detachedInstance);
            log.debug("merge successful");
            return result;
        } catch (RuntimeException re) {
            log.error("merge failed", re);
            throw re;
        }
    }

    public void attachDirty(Advisorfirm instance) {
        log.debug("attaching dirty Advisorfirm instance");
        try {
            getHibernateTemplate().saveOrUpdate(instance);
            log.debug("attach successful");
        } catch (RuntimeException re) {
            log.error("attach failed", re);
            throw re;
        }
    }
    
    public void attachClean(Advisorfirm instance) {
        log.debug("attaching clean Advisorfirm instance");
        try {
            getHibernateTemplate().lock(instance, LockMode.NONE);
            log.debug("attach successful");
        } catch (RuntimeException re) {
            log.error("attach failed", re);
            throw re;
        }
    }

   public static AdvisorfirmDAO getFromApplicationContext(ApplicationContext ctx) {
      return (AdvisorfirmDAO) ctx.getBean("AdvisorfirmDAO");
   }
}