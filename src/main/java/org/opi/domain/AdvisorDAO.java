package org.opi.domain;

import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.Criteria;
import org.hibernate.FetchMode;
import org.hibernate.LockMode;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

/**
 * Data access object (DAO) for domain model class Advisor.
 * @see org.opi.domain.Advisor
 * @author MyEclipse - Hibernate Tools
 */
public class AdvisorDAO extends HibernateDaoSupport {

    private static final Log log = LogFactory.getLog(AdvisorDAO.class);

   //property constants
   public static final String ISACTIVATED = "isactivated";
   public static final String ASSISTANTNAME = "assistantname";
   public static final String ASSISTANTEMAIL = "assistantemail";
   
   private JdbcTemplate jdbcTemplate;
   
   public void setDataSource(DataSource dataSource) {
     this.jdbcTemplate = new JdbcTemplate(dataSource);
   }
   
// The Jdbc equivilant:
   public boolean doesNotAdvisorHaveApplications(Long advisorId) {
     int count = this.jdbcTemplate.queryForInt(
         "select count(*) as total from advisor where id not in " +
         "(select distinct advisorId from application where " +
         "advisorid is not null) and id = ?", 
         new Object[] { advisorId });
     
     return count != 0;
   }
   
   protected void initDao() {
      //do nothing
   }

    public void save(Advisor transientInstance) {
        log.debug("saving Advisor instance");
        try {
            getHibernateTemplate().save(transientInstance);
            log.debug("save successful");
        } catch (RuntimeException re) {
            log.error("save failed", re);
            throw re;
        }
    }

   public void delete(Advisor persistentInstance) {
        log.debug("deleting Advisor instance");
        try {
            getHibernateTemplate().delete(persistentInstance);
            log.debug("delete successful");
        } catch (RuntimeException re) {
            log.error("delete failed", re);
            throw re;
        }
    }

    public Advisor findById(Long id) {
        log.debug("getting Advisor instance with id: " + id);
        try {
            Advisor instance = (Advisor) getHibernateTemplate().get("org.opi.domain.Advisor", id);
            return instance;
        } catch (RuntimeException re) {
            log.error("get failed", re);
            throw re;
        }
    }

    public Advisor findIndividualAndUserById(Long id) {
       log.debug("getting Advisor instance with id: " + id);
       try {
          String queryString = "from Advisor as adv, Advisorprovider as adp, Individual as ind, Users as usr where (adv.id = ?) and (adv = adp.advisor) and (ind = adv.individual) and (usr = ind.users)";
          List advisors = getHibernateTemplate().find(queryString, id);
          Object[] objs = (Object[])advisors.get(0);
          return (Advisor)objs[0];
       } catch (RuntimeException re) {
          log.error("find by property name failed", re);
          throw re;
       }
   }

    public Advisor findAdvisorByIdDeep(Long id) {
       log.debug("getting Advisor, Advisorfirm and Dealergroup with instance with id: " + id);
        try {
           String queryString = "from Advisor as adv, Individual as ind, Advisorfirm as adf, Dealergroup as dg where (adv.id = ?) and (ind = adv.individual) and (adf = adv.advisorfirm) and (dg = adf.dealergroup)";
           List advisors = getHibernateTemplate().find(queryString, id);
           Object[] objs = (Object[])advisors.get(0);
           return (Advisor)objs[0];
        } catch (RuntimeException re) {
           log.error("find by property name failed", re);
           throw re;
        }
    }

    public Advisor findAdvisorApplicationsById(Long id) {
       log.debug("getting Advisor and Applications with instance with id: " + id);
       try {
          String queryString = "from Advisor as adv left join fetch adv.applications as applications, Individual as ind, Users as usr where (adv.id = ?) and (ind = adv.individual) and (usr = ind.users)";
          List objectList = getHibernateTemplate().find(queryString, id);
          Object[] objarray = (Object[])objectList.get(0);
          return (Advisor)objarray[0];
       } catch (RuntimeException re) {
          log.error("find by property name failed", re);
          throw re;
       }
    }

    public List findByExample(Advisor instance) {
        log.debug("finding Advisor instance by example");
        try {
            List results = getHibernateTemplate().findByExample(instance);
            log.debug("find by example successful, result size: " + results.size());
            return results;
        } catch (RuntimeException re) {
            log.error("find by example failed", re);
            throw re;
        }
    }

    public List findAll() {
       log.debug("finding all Advisors");
       try {
          String queryString = "from Advisor as adv, Individual as ind where (ind = adv.individual)";
          List<Object[]> objects = getHibernateTemplate().find(queryString);
          List<Advisor> advisors2 = new ArrayList<Advisor>();
          for ( Object[] object : objects)
             advisors2.add((Advisor)object[0]);
          return advisors2;
       } catch (RuntimeException re) {
          log.error("find by property name failed", re);
          throw re;
       }
   }

    public Advisor findByAbnAndFullname(Object abn, Object lastname, Object firstname) {
       try {
          String queryString = "from Advisor as adv, Advisorfirm as adf, Company afc, Individual as ind where adv.advisorfirm = adf and adf.company = afc and afc.abn = ? and adv.individual = ind and ind.lastname= ? and ind.firstname= ?";

          List list = getHibernateTemplate().find(queryString, new Object[] {abn, lastname, firstname});
          if (list.size() > 0) {
//             log.info("Found Advisorfirm with abn="+abn +" and Dealergroup with afsl="+afsl);
             Object[] objs = (Object[])list.get(0);
             return (Advisor)objs[0];
          }
          else
             return new Advisor(new Individual());

       } catch (RuntimeException re) {
          log.error("find by property name failed", re);
          throw re;
       }
    }

    public List<Advisor> findByAdvisorfirmId(Object advisorfirmid) {
       log.debug("getting Advisor, Advisorfirm, Individual with instance with advisorfirm.id: " + advisorfirmid);
       List<Advisor> advs = new ArrayList<Advisor>();
        try {
           String queryString = "from Advisor as adv, Advisorfirm as adf, Individual as ind, Users as usr where (adf.id = ?) and (adf = adv.advisorfirm) and (ind = adv.individual) and (usr = ind.users) order by upper(ind.lastname)";
           List<Object[]> list = getHibernateTemplate().find(queryString, advisorfirmid);
           if (list.size() > 0) {
              log.info("Found Advisors with advisorfirm.id="+advisorfirmid);
              for (Object[] obj: list) {
//                 log.debug(arg0)
                 advs.add((Advisor)obj[0]);
              }              
           }
        } catch (RuntimeException re) {
           log.error("find by property name failed", re);
           throw re;
        }
        
        return advs; 
    }
    
    public List findByProperty(String propertyName, Object value) {
      log.debug("finding Advisor instance with property: " + propertyName
            + ", value: " + value);
      try {
         String queryString = "from Advisor as model where model."
                           + propertyName + "= ?";
       return getHibernateTemplate().find(queryString, value);
      } catch (RuntimeException re) {
         log.error("find by property name failed", re);
         throw re;
      }
   }

   public List findByIsactivated(Object isactivated) {
      return findByProperty(ISACTIVATED, isactivated);
   }

   public List findByAssistantname(Object assistantname) {
      return findByProperty(ASSISTANTNAME, assistantname);
   }

   public List findByAssistantemail(Object assistantemail) {
      return findByProperty(ASSISTANTEMAIL, assistantemail);
   }

    public Advisor merge(Advisor detachedInstance) {
        log.debug("merging Advisor instance");
        try {
            Advisor result = (Advisor) getHibernateTemplate()
                    .merge(detachedInstance);
            log.debug("merge successful");
            return result;
        } catch (RuntimeException re) {
            log.error("merge failed", re);
            throw re;
        }
    }

    // added by paulmac
    public void update(Advisor instance) {
       log.debug("updating Application instance");
       try {
           getHibernateTemplate().update(instance);
           log.debug("update successful");
       } catch (RuntimeException re) {
           log.error("update failed", re);
           throw re;
       }
   }

    public void attachDirty(Advisor instance) {
        log.debug("attaching dirty Advisor instance");
        try {
            getHibernateTemplate().saveOrUpdate(instance);
            log.debug("attach successful");
        } catch (RuntimeException re) {
            log.error("attach failed", re);
            throw re;
        }
    }

    public void attachClean(Advisor instance) {
        log.debug("attaching clean Advisor instance");
        try {
            getHibernateTemplate().lock(instance, LockMode.NONE);
            log.debug("attach successful");
        } catch (RuntimeException re) {
            log.error("attach failed", re);
            throw re;
        }
    }

   public static AdvisorDAO getFromApplicationContext(ApplicationContext ctx) {
      return (AdvisorDAO) ctx.getBean("AdvisorDAO");
   }

  public Advisor findByIndividualId(Long individualId) {
    List advisors = super.getHibernateTemplate().find("from Advisor advisor where advisor.individual.id = ?", individualId);
    
    Advisor advisor;
    if (advisors.size() > 0) {
      if (advisors.size() > 1) {
        logger.warn("More than 1 advisor found with individualId = " + individualId + ".  Using first value.");
      }
      advisor = (Advisor) advisors.iterator().next();
    } else {
      advisor = null;
    }
    
    return advisor;
  }

  /**
   * @param advisor
   */
  public void refresh(Advisor advisor) {
    if (!super.getSession().isDirty()) {
      super.getHibernateTemplate().refresh(advisor);
      super.getHibernateTemplate().initialize(advisor.getApplications());
      super.getHibernateTemplate().refresh(advisor.getIndividual());
    }
    
  }

  /**
   * Updates advisor details passed in.
   * 
   * @param persistentAdvisor The advisor updated.
   */
  public void updateAdvisorDetails(Advisor persistentAdvisor) {
    super.getHibernateTemplate().update(persistentAdvisor);
    
  }

  public Advisor findByIdWithEditableDependencies(long advisorId) {
    DetachedCriteria criteria = DetachedCriteria.forClass(Advisor.class);
    
    criteria.add(Restrictions.idEq(advisorId));
    criteria.setFetchMode("individual", FetchMode.JOIN);
    criteria.setFetchMode("advisorfirm", FetchMode.JOIN);
    criteria.setFetchMode("advisorfirm.company", FetchMode.JOIN);
    
    List results = super.getHibernateTemplate().findByCriteria(criteria);
    
    return !results.isEmpty() ? (Advisor) results.iterator().next() : null; 
  }
}