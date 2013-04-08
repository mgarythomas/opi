package com.ubs.opi.domain;

//import java.util.Date;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.LockMode;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.context.ApplicationContext;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

/**
 * Data access object (DAO) for domain model class Individual.
 * @see com.ubs.opi.domain.Individual
 * @author MyEclipse - Hibernate Tools
 */
public class IndividualDAO extends HibernateDaoSupport {

    private static final Log log = LogFactory.getLog(IndividualDAO.class);

   //property constants
   public static final String TITLE = "title";
   public static final String FIRSTNAME = "firstname";
   public static final String MIDDLENAME = "middlename";
   public static final String LASTNAME = "lastname";
   public static final String ADDRESS1 = "address1";
   public static final String ADDRESS2 = "address2";
   public static final String SUBURB = "suburb";
   public static final String STATE = "state";
   public static final String POSTCODE = "postcode";
   public static final String COUNTRY = "country";
   public static final String TFN = "tfn";
   public static final String ABN = "abn";
   public static final String HOMEPHONE = "homephone";
   public static final String WORKPHONE = "workphone";
   public static final String MOBILEPHONE = "mobilephone";
   public static final String PERSONALFAX = "personalfax";
   public static final String WORKFAX = "workfax";
   public static final String PERSONALEMAIL = "personalemail";
   public static final String WORKEMAIL = "workemail";
   public static final String TOWNOFBIRTH = "townofbirth";
   public static final String COUNTRYOFBIRTH = "countryofbirth";
   public static final String PASSPORTNO = "passportno";
   public static final String NATIONALITY = "nationality";
   public static final String DRIVERSLICENCENO = "driverslicenceno";
   public static final String OCCUPATION = "occupation";
   public static final String EMPLOYER = "employer";

   protected void initDao() {
      //do nothing
   }

    public void save(Individual transientInstance) {
        log.debug("saving Individual instance");
        try {
            getHibernateTemplate().save(transientInstance);
            log.debug("save successful");
        } catch (RuntimeException re) {
            log.error("save failed", re);
            throw re;
        }
    }

   public void delete(Individual persistentInstance) {
     getHibernateTemplate().delete(persistentInstance);
   }

    public Individual findById( Long id) {
        log.debug("getting Individual instance with id: " + id);
        try {
            Individual instance = (Individual) getHibernateTemplate()
                    .get("com.ubs.opi.domain.Individual", id);
            return instance;
        } catch (RuntimeException re) {
            log.error("get failed", re);
            throw re;
        }
    }


    public List findByExample(Individual instance) {
        log.debug("finding Individual instance by example");
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
      log.debug("finding Individual instance with property: " + propertyName
            + ", value: " + value);
      try {
         String queryString = "from Individual as model where model."
                           + propertyName + "= ?";
       return getHibernateTemplate().find(queryString, value);
      } catch (RuntimeException re) {
         log.error("find by property name failed", re);
         throw re;
      }
   }

   public List findByTitle(Object title) {
      return findByProperty(TITLE, title);
   }

   public List findByFirstname(Object firstname) {
      return findByProperty(FIRSTNAME, firstname);
   }

   public List findByMiddlename(Object middlename) {
      return findByProperty(MIDDLENAME, middlename);
   }

   public List findByLastname(Object lastname) {
      return findByProperty(LASTNAME, lastname);
   }

   public List findByAddress1(Object address1) {
      return findByProperty(ADDRESS1, address1);
   }

   public List findByAddress2(Object address2) {
      return findByProperty(ADDRESS2, address2);
   }

   public List findBySuburb(Object suburb) {
      return findByProperty(SUBURB, suburb);
   }

   public List findByState(Object state) {
      return findByProperty(STATE, state);
   }

   public List findByPostcode(Object postcode) {
      return findByProperty(POSTCODE, postcode);
   }

   public List findByCountry(Object country) {
      return findByProperty(COUNTRY, country);
   }

   public List findByTfn(Object tfn) {
      return findByProperty(TFN, tfn);
   }

   public List findByAbn(Object abn) {
      return findByProperty(ABN, abn);
   }

   public List findByHomephone(Object homephone) {
      return findByProperty(HOMEPHONE, homephone);
   }

   public List findByWorkphone(Object workphone) {
      return findByProperty(WORKPHONE, workphone);
   }

   public List findByMobilephone(Object mobilephone) {
      return findByProperty(MOBILEPHONE, mobilephone);
   }

   public List findByPersonalfax(Object personalfax) {
      return findByProperty(PERSONALFAX, personalfax);
   }

   public List findByWorkfax(Object workfax) {
      return findByProperty(WORKFAX, workfax);
   }

   public List findByPersonalemail(Object personalemail) {
      return findByProperty(PERSONALEMAIL, personalemail);
   }

   public List findByWorkemail(Object workemail) {
      return findByProperty(WORKEMAIL, workemail);
   }

   public List findByTownofbirth(Object townofbirth) {
      return findByProperty(TOWNOFBIRTH, townofbirth);
   }

   public List findByCountryofbirth(Object countryofbirth) {
      return findByProperty(COUNTRYOFBIRTH, countryofbirth);
   }

   public List findByPassportno(Object passportno) {
      return findByProperty(PASSPORTNO, passportno);
   }

   public List findByNationality(Object nationality) {
      return findByProperty(NATIONALITY, nationality);
   }

   public List findByDriverslicenceno(Object driverslicenceno) {
      return findByProperty(DRIVERSLICENCENO, driverslicenceno);
   }

   public List findByOccupation(Object occupation) {
      return findByProperty(OCCUPATION, occupation);
   }

   public Individual findIndividual(String key, String value) {
      try {
         String queryString;
         if (key.equals("0"))
            queryString = "from Individual as ind, Users as usr where ind.users = usr and usr.username = ?"; 
         else
            queryString = "from Individual as ind, Users as usr where ind.users = usr and ind.workemail = ?"; 
         List list = getHibernateTemplate().find(queryString, value);
         if (list.size() > 0) {
            Object[] objs = (Object[])list.get(0);
            return (Individual)objs[0];
         }
         else
            return null;
      } catch (RuntimeException re) {
         log.error("find by property name failed", re);
         throw re;
      }
   }
   
   public List<Individual> findByFullname(Object lastname, Object firstname) {
      try {
         String queryString = "from Individual as model where model.lastname= ? and model.firstname= ?"; 
         Object[] values = new Object[] {lastname, firstname};
         return (List<Individual>)getHibernateTemplate().find(queryString, values);
      } catch (RuntimeException re) {
         log.error("find by property name failed", re);
         throw re;
      }
   }

   public List<Individual> findByOccupationAndEmployer(Object occupation, Object employer) {
      try {
         String queryString = "from Individual as model where model.occupation= ? and model.employer= ?"; 
         Object[] values = new Object[] {occupation, employer};
         return (List<Individual>)getHibernateTemplate().find(queryString, values);
      } catch (RuntimeException re) {
         log.error("find by property name failed", re);
         throw re;
      }
   }

   public List findByEmployer(Object employer) {
      return findByProperty(EMPLOYER, employer);
   }

    public Individual merge(Individual detachedInstance) {
        log.debug("merging Individual instance");
        try {
            Individual result = (Individual) getHibernateTemplate()
                    .merge(detachedInstance);
            log.debug("merge successful");
            return result;
        } catch (RuntimeException re) {
            log.error("merge failed", re);
            throw re;
        }
    }

    public void attachDirty(Individual instance) {
        log.debug("attaching dirty Individual instance");
        try {
            getHibernateTemplate().saveOrUpdate(instance);
            log.debug("attach successful");
        } catch (RuntimeException re) {
            log.error("attach failed", re);
            throw re;
        }
    }

    public void attachClean(Individual instance) {
        log.debug("attaching clean Individual instance");
        try {
            getHibernateTemplate().lock(instance, LockMode.NONE);
            log.debug("attach successful");
        } catch (RuntimeException re) {
            log.error("attach failed", re);
            throw re;
        }
    }

   public static IndividualDAO getFromApplicationContext(ApplicationContext ctx) {
      return (IndividualDAO) ctx.getBean("IndividualDAO");
   }

  /**
   * Finds a BDM user based on the given username.
   * 
   * @param username The username.
   * 
   * @return The BDM Admin.
   */
  public Individual findBdmAdminByUsername(String username) {
    DetachedCriteria detachedCriteria = DetachedCriteria.forClass(Individual.class);
    
    detachedCriteria.add(Restrictions.eq("users.username", username));
    detachedCriteria.add(Restrictions.isNotNull("employer"));
    
    List results = super.getHibernateTemplate().findByCriteria(detachedCriteria);
    
    Individual individual;
    if (results.size() > 0) {
      if (results.size() > 1) {
        throw new RuntimeException("More than 1 BDM Admin found with username = " + username);
      }
      individual = (Individual) results.iterator().next();
    } else {
      individual = null;
    }
    
    return individual;
  }

  /**
   * Finds BDMs with the given employer name.
   * 
   * @param employer The employer.
   * 
   * @return The BDMs.
   */
  @SuppressWarnings("unchecked")
  public List<Individual> findBdmsByEmployer(String employer) {
    DetachedCriteria detachedCriteria = DetachedCriteria.forClass(Individual.class);
    
    detachedCriteria.add(Restrictions.eq("occupation", "BDM"));
    detachedCriteria.add(Restrictions.eq("employer", employer));
    
    List results = super.getHibernateTemplate().findByCriteria(detachedCriteria);
    
    return results;
  }

  public void update(Individual individual) {
    super.getHibernateTemplate().update(individual);
    
  }

  public void refresh(Individual individual) {
    if (!super.getSession().isDirty()) {
      super.getHibernateTemplate().refresh(individual);
    }
    
  }
}