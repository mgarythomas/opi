package com.ubs.opi.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

import javax.servlet.ServletException;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.directwebremoting.WebContext;
import org.directwebremoting.WebContextFactory;
import org.springframework.dao.DataAccessException;
import org.springframework.util.StringUtils;
import org.springframework.web.util.WebUtils;

import com.ubs.opi.domain.Advisor;
import com.ubs.opi.domain.AdvisorComp;
import com.ubs.opi.domain.AdvisorDAO;
import com.ubs.opi.domain.Advisorfirm;
import com.ubs.opi.domain.AdvisorfirmDAO;
import com.ubs.opi.domain.Advisorprovider;
import com.ubs.opi.domain.AdvisorproviderDAO;
import com.ubs.opi.domain.Application;
import com.ubs.opi.domain.ApplicationComp;
import com.ubs.opi.domain.ApplicationDAO;
import com.ubs.opi.domain.Authorities;
import com.ubs.opi.domain.AuthoritiesDAO;
import com.ubs.opi.domain.AuthoritiesId;
import com.ubs.opi.domain.Bank;
import com.ubs.opi.domain.BankDAO;
import com.ubs.opi.domain.Company;
import com.ubs.opi.domain.CompanyDAO;
import com.ubs.opi.domain.Constants;
import com.ubs.opi.domain.Dealergroup;
import com.ubs.opi.domain.DealergroupDAO;
import com.ubs.opi.domain.Dwradvisor;
import com.ubs.opi.domain.Dwradvisorfirm;
import com.ubs.opi.domain.Dwrapplication;
import com.ubs.opi.domain.Dwrdealergroup;
import com.ubs.opi.domain.Individual;
import com.ubs.opi.domain.IndividualDAO;
import com.ubs.opi.domain.Investorindividual;
import com.ubs.opi.domain.InvestorindividualComp;
import com.ubs.opi.domain.InvestorindividualDAO;
import com.ubs.opi.domain.Product;
import com.ubs.opi.domain.ProductDAO;
import com.ubs.opi.domain.Superusers;
import com.ubs.opi.domain.TrustDAO;
import com.ubs.opi.domain.Users;
import com.ubs.opi.domain.UsersDAO;
import com.ubs.opi.domain.Utils;
import com.ubs.opi.support.AuthenticationManager;
import com.ubs.opi.support.MailManager;
import com.ubs.opi.support.SimpleAuthenticationManager;

/**
 * DAO implementation of the Opi interface.
 *
 * @author Paul McLachlan
 * @since 25.01.2007
 */
public class OpiDAO implements Opi {

   static final Log log = LogFactory.getLog(OpiDAO.class);

   private CompanyDAO companyDAO;

   private DealergroupDAO dealergroupDAO;

   private AdvisorfirmDAO advisorfirmDAO;

   AdvisorDAO advisorDAO; 

   private AdvisorproviderDAO advisorproviderDAO;

   // private AdvisorindividualDAO advisorindividualDAO;
   private AuthoritiesDAO authoritiesDAO;

   private IndividualDAO individualDAO;

   private UsersDAO usersDAO;

   private InvestorindividualDAO investorindividualDAO;

   private ApplicationDAO applicationDAO;

   private ProductDAO productDAO;

   private TrustDAO trustDAO;

   private BankDAO bankDAO;

   private MailManager mailManager;


   /*
    * Start Ajax methods
    */
    private Advisor loadTransientAdvisor(int id, Superusers superusers)
    {
      Long transadvisorId = new Long (id); //new Long (key);
      Advisor advisor;
      if (!transadvisorId.equals(superusers.getTransadvisorId()))
      {
         log.info("loading Advisor through Hibernate");
         advisor = this.loadAdvisor(transadvisorId); //  advisorDAO.findAdvisorApplicationsById(transadvisorId);
         advisor.setTransinvestortype("-1");
         Map<Long, String> investors = new LinkedHashMap<Long, String>(Utils.getInvestors());
         for (Application application : advisor.getApplications()) {
            investors.put(application.getId(), application.getAccountdesignation());
         }
         superusers.setInvestors(investors);
         superusers.setTransadvisorId(transadvisorId);
         superusers.setTransadvisor(advisor);
         WebUtils.setSessionAttribute(WebContextFactory.get().getHttpServletRequest(), "superusers", superusers);
      } else {
         advisor = superusers.getTransadvisor();
      }
      log.info("id="+id+", advisorId="+transadvisorId+", advisor.name="+advisor.getIndividual().getFullname()+", applications.size="+advisor.getApplications().size());
      return advisor;
    }

    private void resetTransientAdvisor(Superusers superusers)
    {
      if (!superusers.getTransadvisor().isNew())
      {
         log.info("reset transient Advisor");
         superusers.setTransadvisorId(new Long(1));
         superusers.setTransadvisor(new Advisor());
         superusers.setInvestors(Utils.getInvestors());         
         WebUtils.setSessionAttribute(WebContextFactory.get().getHttpServletRequest(), "superusers", superusers);
      }
    }

    public synchronized Superusers partialLoadAdvisor(int id) throws ServletException, IOException {
         WebContext wctx = WebContextFactory.get();

         // TODO : Correct way to use the Spring Form backing object outside the Spring lifecycle i.e Ajax
         // Superusers superusers = (Superusers)WebUtils.getSessionAttribute(request, "com.ubs.opi.web.AdvisorapplicationsForm.FORM.superusers");

         Superusers superusers = (Superusers)WebUtils.getSessionAttribute(WebContextFactory.get().getHttpServletRequest(), "superusers"); // setSessionAttribute(request, "superusers", superusers);
         if (id > 1) {
            Advisor advisor = loadTransientAdvisor(id, superusers);
         }
         else {
             resetTransientAdvisor(superusers);
         }
         return superusers;
       }
       
       public String getInclude(int id) throws ServletException, IOException {
         Superusers superusers = partialLoadAdvisor(id);
         WebContextFactory.get().getHttpServletRequest().setAttribute("investors", superusers.getInvestors());
         
         Set<Application> filteredApplications =  new TreeSet<Application>(new Comparator<Application>() {
           public int compare(Application o1,
                              Application o2) {
             int res = o1.getAccountdesignation().compareToIgnoreCase(
                 o2.getAccountdesignation());

             return res;
           }
         });
         
         Set<Application> applications = superusers.getTransadvisor().getApplications();
         for (Application application : applications) {
           if (application.getStatus() != Constants.CANCELLED_STATUS) {
             filteredApplications.add(application);
           }
         }
         
         WebContextFactory.get().getHttpServletRequest().setAttribute("filteredApplicationsUnique", filteredApplications);
         
         return WebContextFactory.get().forwardToString("/WEB-INF/jsp/investorselect.jsp"); //"Select Investor"; //
       }

       
       public String getApplicationTable(int id) throws ServletException, IOException {
         Superusers superusers = partialLoadAdvisor(id);
         WebContextFactory.get().getHttpServletRequest().setAttribute("superuser", superusers);
         return WebContextFactory.get().forwardToString("/WEB-INF/jsp/applicationtable.jsp"); //"Select Investor"; //
       }

       public String addIndividualToApp() throws ServletException, IOException {
          Application application = (Application)WebUtils.getSessionAttribute(WebContextFactory.get().getHttpServletRequest(), "application");          
          Investorindividual investorindividual = new Investorindividual();
          investorindividual.setIndividual(new Individual());
          String role = Constants.APPLICANT; 
          investorindividual.setIsapplicant(Constants.TRUE);
          if ((application.getType() == Constants.CORPORATE_TYPE) || (application.getType() == Constants.CORPORATE_TRUST_TYPE))
          {
             investorindividual.setIsdirector(Constants.TRUE);
             role = Constants.DIRECTOR;
          }
          else if (application.getType() == Constants.PRIVATE_TRUST_TYPE)
          {
             investorindividual.setIstrustee(Constants.TRUE);
             role = Constants.TRUSTEE;
          }
          // TODO for different types of Individual associations
          investorindividual.setRole(role);
          investorindividual.setApplication(application);
          application.addInvestorindividual(investorindividual);
          log.info("newApplicant Created");
          
          WebContextFactory.get().getHttpServletRequest().setAttribute("application", application);
          WebContextFactory.get().getHttpServletRequest().setAttribute("titles", Utils.getTitles());
          WebContextFactory.get().getHttpServletRequest().setAttribute("states", Utils.getStates());
          WebContextFactory.get().getHttpServletRequest().setAttribute("defaultcountries", Utils.getDefaultCountries());
          WebContextFactory.get().getHttpServletRequest().setAttribute("countries", Utils.getCountries()); 
          WebContextFactory.get().getHttpServletRequest().setAttribute("nationalities", Utils.getNationalities());

          WebUtils.setSessionAttribute(WebContextFactory.get().getHttpServletRequest(), "application", application);          

          return WebContextFactory.get().forwardToString("/WEB-INF/jsp/investorindividualtable.jsp");
       }
       
   public Bank fillAddress(String bsb, long id) { 
      String bsblocal = StringUtils.replace(bsb, "-", "");
      Bank bank = this.bankDAO.findById(bsblocal);
            
      if (bank == null) {
         log.info("Bank with BSB="+bsb+" NOT found");
         bank = new Bank(bsb);
         
         bank.setName("");
         bank.setAddress1("");
         bank.setPostcode("");
         bank.setState("");
         bank.setSuburb("");
         
         // the following will reset the values.
//         Application application = applicationDAO.findById(id);
//         if (StringUtils.hasText(application.getDdinstitution())) {
//            bank.setName(application.getDdinstitution());
//            bank.setAddress1(application.getDdinstitutionaddress());
//            bank.setPostcode(application.getDdinstitutionpostcode());
//            bank.setState(application.getDdinstitutionstate());
//            bank.setSuburb(application.getDdinstitutionsuburb());
//         }
         return bank;
      }
      else {
         log.info("Bank with BSB="+bsb+" found");
         bank.setAddress1(bank.getAddress1().replaceAll("&", "and"));
         bank.setName(bank.getName().replaceAll("&", "and"));
      }
      
      
      return bank;
   }
   
   public Bank findDirectCreditInstitution(String bsb, Long applicationId) { 
     String bsblocal = StringUtils.replace(bsb, "-", "");
     Bank bank = this.bankDAO.findById(bsblocal);
           
     if (bank == null) {
       if (log.isDebugEnabled()) {
         log.debug("Unknown BSB.  Defaulting to application's original values ...");
       }
       bank = new Bank(bsb);
       // the following will reset to original values.
//       Application application = applicationDAO.findById(applicationId);
//       if (application.getDirectCreditDetails() != null) {
//         bank.setName(application.getDirectCreditDetails().getInstitution());
//         bank.setAddress1(application.getDirectCreditDetails().getInstitutionAddress());
//         bank.setPostcode(application.getDirectCreditDetails().getInstitutionPostcode());
//         bank.setState(application.getDirectCreditDetails().getInstitutionState());
//         bank.setSuburb(application.getDirectCreditDetails().getInstitutionState());
//       }
       
       return bank;
     } else {
       if (log.isDebugEnabled()) {
         log.debug("BSB " + bsb + " found.");
       }
       bank.setAddress1(bank.getAddress1().replaceAll("&", "and"));
       bank.setName(bank.getName().replaceAll("&", "and"));
     }
     
     
     return bank;
   }
   
   public Dwrdealergroup fillDealergroup(String afsl) {
      Dealergroup dg = this.dealergroupDAO.findDgByAfsl(afsl.trim());
      if (dg != null) {
         log.debug("Found Dealergroup name="+dg.getCompany().getName());
         // get Comand object
//         Advisor advisor = (Advisor)WebUtils.getSessionAttribute(WebContextFactory.get().getHttpServletRequest(), "advisor");
//         advisor.getAdvisorfirm().setDealergroup(dg);
//         WebUtils.setSessionAttribute(WebContextFactory.get().getHttpServletRequest(), "advisor", advisor);          
         WebUtils.setSessionAttribute(WebContextFactory.get().getHttpServletRequest(), "dealergroup", dg);          
         return new Dwrdealergroup(dg);
      } else {
         WebUtils.setSessionAttribute(WebContextFactory.get().getHttpServletRequest(), "dealergroup", null);          
      }
         
      return new Dwrdealergroup(afsl);
   }

   public Dwradvisorfirm fillAdvisorfirm(String afsl, String abn) {
      Advisorfirm af = this.advisorfirmDAO.findByAbn(afsl.trim(), abn.trim());
      if (af != null) {
         WebUtils.setSessionAttribute(WebContextFactory.get().getHttpServletRequest(), "advisorfirm", af);          
         log.debug("Found Advisorfirm name="+af.getCompany().getName());
         return new Dwradvisorfirm(af);
      }
      return new Dwradvisorfirm(afsl, abn);
   }

   public List<Dwrdealergroup> getAllDwrdealergroups() throws DataAccessException {
      List<Dealergroup> dgs = this.dealergroupDAO.findAll();
      long idx = 1;
      List<Dwrdealergroup> dwrdgs = new ArrayList<Dwrdealergroup>(); // LinkedList<Dwrdealergroup>(new DwrdealergroupComp());
      Dwrdealergroup dwrdg = new Dwrdealergroup("999999");
      dwrdg.setId(0);
      dwrdgs.add(dwrdg);
      for (Dealergroup dg : dgs){
         dwrdg = new Dwrdealergroup(dg);
         dwrdg.setId(idx++);
         dwrdg.setDoesnothaveadvisorfirms(dealergroupDAO.doesNotAdvisorHaveAdvisorfirms(new Long(dg.getId())));
         dwrdgs.add(dwrdg);
         log.debug("IN getDwradvisorfirms id="+idx+" Name="+dwrdg.getName()+" Abn="+dwrdg.getAbn()+" Afsl="+dwrdg.getAfsl());
//         if (idx == 10)
//           break;
      }
//      Collections.sort(dwrdgs, new DwrdealergroupComp());
      log.debug("IN dwrdgs.size()="+dwrdgs.size());
      return dwrdgs;
   }

   public List<Dwradvisorfirm> getDwradvisorfirms(Long id) throws DataAccessException {
      List<Advisorfirm> afs = advisorfirmDAO.findByDealergroupId(id); //afsl);
      long idx = 1; 
      List<Dwradvisorfirm> dwrafs = new ArrayList<Dwradvisorfirm>(); // LinkedList<Dwrdealergroup>(new DwrdealergroupComp());
      Dwradvisorfirm dwraf = new Dwradvisorfirm("99999999999", "999999");
      dwraf.setId(0);
      dwrafs.add(dwraf);
      for (Advisorfirm af : afs){
         dwraf = new Dwradvisorfirm(af);
         log.debug("IN getDwradvisorfirms id="+idx+" Name="+dwraf.getAfname()+" Abn="+dwraf.getAfabn());
         dwraf.setDoesnothaveadvisors(advisorfirmDAO.doesNotAdvisorHaveAdvisors(new Long(af.getId())));
         dwraf.setId(idx++);
         dwrafs.add(dwraf);
      }
      log.debug("IN dwrafs.size()="+dwrafs.size());
      return dwrafs;
   }   
   
   public List<Dwradvisor> getDwradvisors(Long id) throws DataAccessException {
      List<Advisor> advs = advisorDAO.findByAdvisorfirmId(id);
      long idx = 1;
      List<Dwradvisor> dwradvs = new ArrayList<Dwradvisor>(); // LinkedList<Dwrdealergroup>(new DwrdealergroupComp());
      Dwradvisor dwradv = new Dwradvisor("");
      dwradv.setId(0);
      dwradvs.add(dwradv);
      log.debug("IN advs.size()="+advs.size());
      if (advs.size() > 0)
         for (Advisor adv : advs){
            dwradv = new Dwradvisor(adv);
            log.debug("IN getDwradvisors id="+idx+" Name="+dwradv.getFullname()+" Username="+dwradv.getUsername());
            dwradv.setDoesnothaveapplications(advisorDAO.doesNotAdvisorHaveApplications(new Long(adv.getId())));
            dwradv.setId(idx++);
            dwradvs.add(dwradv);
         }
      log.debug("IN dwradvs.size()="+dwradvs.size());
      return dwradvs;
   }   

   
   public List<Dwrapplication> getDwrapplications(Long id) throws DataAccessException {
      Advisor adv = this.advisorDAO.findAdvisorApplicationsById(id);
      Set<Application> apps = adv.getApplications();
      long idx = 1;
      List<Dwrapplication> dwrapps = new ArrayList<Dwrapplication>();
      Dwrapplication dwrapp = new Dwrapplication("");
      dwrapp.setId(0);
      dwrapps.add(dwrapp);
      log.debug("IN apps.size()="+apps.size());
      if (apps.size() > 0)
         for (Application app : apps){
            dwrapp = new Dwrapplication(app);
            log.debug("IN getDwradvisors id="+idx+" Name="+dwrapp.getName()+" Product="+dwrapp.getProduct());
            dwrapp.setId(idx++);
            dwrapps.add(dwrapp);
         }
      log.debug("IN dwrapps.size()="+dwrapps.size());
      return dwrapps;
   }

   public String storeDwradvisorfirm(Long dealergroupid, Dwradvisorfirm dwraf) { // afsl
      String errors = dwraf.validate();
      if (StringUtils.hasText(errors))
         return errors;

      Advisorfirm af = null;
      if (dwraf.getDbid() > 0) {
         af = (Advisorfirm)this.advisorfirmDAO.findById(dwraf.getDbid());
         dwraf.update(af);
         this.companyDAO.attachDirty(af.getCompany());
         this.advisorfirmDAO.attachDirty(af);
      } else {
         storeDwrnewadvisorfirm(dealergroupid, dwraf);
      }
      
      return null;
  }

   private void storeDwrnewadvisor(Long advisorfirmid, Dwradvisor dwradv) {
      Advisorfirm adf = (Advisorfirm)this.advisorfirmDAO.findById(advisorfirmid);
      Advisor adv = this.createNewAdvisor(adf, null);
      dwradv.update(adv);
      storeAdvisorComplete(adv);
      this.myMailManager().sendUserNameandPassword(adv);
      return;
   }

   private void storeDwrnewadvisorfirm(Long dealergroupid, Dwradvisorfirm dwraf) {
      Dealergroup dg = (Dealergroup)this.dealergroupDAO.findById(dealergroupid);
      Advisorfirm af = new Advisorfirm();
      af.setCompany(new Company());
      af.setDealergroup(dg);
      dwraf.update(af);
      this.companyDAO.merge(af.getCompany());
      this.advisorfirmDAO.merge(af);
      dg.addAdvisorfirm(af);
      this.dealergroupDAO.attachDirty(dg);
      return;
   }

   public String storeMoveDwradvisorfirm(Long dealergroupid, Dwradvisorfirm dwraf, Long toadvisorfirmid) {

      String errors = dwraf.validate();
      if (StringUtils.hasText(errors))
         return errors;

      if (dwraf.getDbid() < 0)
         storeDwrnewadvisorfirm(dealergroupid, dwraf);
      else {
         Advisorfirm af = (Advisorfirm)this.advisorfirmDAO.findAdvisorsById(dwraf.getDbid());
         if (af != null) {
            dwraf.update(af);
            Advisorfirm toAf = (Advisorfirm)this.advisorfirmDAO.findAdvisorsById(toadvisorfirmid);
            for (Advisor advisor : af.getAdvisors()) {
               advisor.setAdvisorfirm(toAf);
               this.advisorDAO.attachDirty(advisor);
            }
            this.companyDAO.attachDirty(af.getCompany());
            this.advisorfirmDAO.attachDirty(af);
         } 
      }
      return null;
   }
   
   public String storeMoveDwradvisor(Long advisorfirmid, Dwradvisor dwradv, Long toadvisorid) {

      String errors = dwradv.validate();
      if (StringUtils.hasText(errors))
         return errors;

      if (dwradv.getDbid() < 0) {
         storeDwrnewadvisor(advisorfirmid, dwradv);
         return null;
      }

      Advisor adv = (Advisor)this.advisorDAO.findAdvisorApplicationsById(dwradv.getDbid());
      if (adv != null) {
         dwradv.update(adv);
         Advisor toAdv = (Advisor)this.advisorDAO.findAdvisorApplicationsById(toadvisorid);
         for (Application application : adv.getApplications()) {
            application.setAdvisor(toAdv);
            this.applicationDAO.attachDirty(application);
         }
         this.usersDAO.attachDirty(adv.getIndividual().getUsers());
         this.individualDAO.attachDirty(adv.getIndividual());
         this.advisorDAO.attachDirty(adv);
      } 
      
      return null;
   }

   public String storeMoveDwrapplication(Long advisorid, Dwrapplication dwrapp, Long toadvisorid) {

      String errors = dwrapp.validate();
      if (StringUtils.hasText(errors))
         return errors;

      Advisor adv = (Advisor)this.advisorDAO.findAdvisorApplicationsById(advisorid);
      if (adv != null) {
         Application app = this.applicationDAO.findById(dwrapp.getDbid());
         dwrapp.update(app);
         Advisor toAdv = (Advisor)this.advisorDAO.findById(toadvisorid);
         app.setAdvisor(toAdv);
         this.applicationDAO.attachDirty(app);
         toAdv.addApplications(app);
         this.advisorDAO.attachDirty(toAdv);
      } else
         log.error("Shouldn't get here!");
      
      return null;
   }

   public String storeDwradvisor(Long advisorfirmid, Dwradvisor dwradv) {
      String errors = dwradv.validate();
      if (StringUtils.hasText(errors))
         return errors;

      if (dwradv.getDbid() < 0) {
         storeDwrnewadvisor(advisorfirmid, dwradv);
         return null;
      }

      Advisor adv = (Advisor)this.advisorDAO.findIndividualAndUserById(dwradv.getDbid());
      if (adv != null) {
         dwradv.update(adv);
         this.usersDAO.attachDirty(adv.getIndividual().getUsers());
         this.individualDAO.attachDirty(adv.getIndividual());
         this.advisorDAO.attachDirty(adv);
      } 
      
      return null;
   }

   public String storeDwrapplication(Long advisorid, Dwrapplication dwrapp) {
      String errors = dwrapp.validate();
      if (StringUtils.hasText(errors))
         return errors;

      Application app = (Application)this.applicationDAO.findById(dwrapp.getDbid());
      if (app != null) {
         dwrapp.update(app);
         this.applicationDAO.attachDirty(app);
      } 
      
      return null;
   }

   public String storeDwrdealergroup(Dwrdealergroup dwrdg) {

      String errors = dwrdg.validate();
      if (StringUtils.hasText(errors))
         return errors;

      Dealergroup dg = null;
      List<Dealergroup> dgs = this.dealergroupDAO.findByAfsl(dwrdg.getAfsl());
      if ((dgs != null) && dgs.size() > 0) {
         dg = dgs.get(0);
//         if (dg != null) {
         dwrdg.update(dg);
         this.companyDAO.attachDirty(dg.getCompany());
         this.dealergroupDAO.attachDirty(dg);
      } else {
         dg = new Dealergroup();
         dg.setCompany(new Company());
         dwrdg.update(dg);
         this.companyDAO.merge(dg.getCompany());
         this.dealergroupDAO.merge(dg);
      }
      
      return null;
  }
   
   
//   public void deleteDwrdealergroup(Dwrdealergroup dwrdg) {
//      Dealergroup dg = (Dealergroup)this.dealergroupDAO.findByAfsl(dwrdg.getAfsl()).toArray()[0];
  public void removeDwrdealergroup(String afsl) {
     Dealergroup dg = (Dealergroup)this.dealergroupDAO.findByAfsl(afsl).toArray()[0];
     
     /* 
      * TODO DELETE all the advisorfirms and advisors before deleting the Dealergroup
      */
     this.companyDAO.delete(dg.getCompany());
     this.dealergroupDAO.delete(dg);
  }

  public void removeDwradvisor(Long id) {
     Advisor adv = (Advisor)this.advisorDAO.findIndividualAndUserById(id);
     log.info("Remove Advisor="+adv.getIndividual().getFullname());
     this.usersDAO.delete(adv.getIndividual().getUsers());
     this.individualDAO.delete(adv.getIndividual());
     for (Advisorprovider advisorprovider : adv.getAdvisorproviders())
        this.advisorproviderDAO.delete(advisorprovider);
     this.advisorDAO.delete(adv);
  }

  public void removeDwradvisorfirm(Long id) {
     Advisorfirm af = (Advisorfirm)this.advisorfirmDAO.findById(id);
     log.info("Remove Advisorfirm="+af.getCompany().getName());
     this.companyDAO.delete(af.getCompany());
     this.advisorfirmDAO.delete(af);
  }

  /*
   * End Ajax methods
   */
   public Advisor findByAbnAndFullname(Object abn, Object lastname, Object firstname) {
      return this.advisorDAO.findByAbnAndFullname(abn, lastname, firstname);
   }
      
   public Map<Long, String> loadInvestors(Superusers superusers) throws DataAccessException {
      
     Map<Long, String> investors = new LinkedHashMap<Long, String>(Utils.getInvestors());

      if (!superusers.getTransadvisorId().equals(new Long(1L))) {
         Set<Application> applications = superusers.getTransadvisor().getApplications();
         
         Set<Application> sortedApps = new TreeSet<Application>(new ApplicationComp());
         sortedApps.addAll(applications);
         
         for (Application application : sortedApps) {
            investors.put(application.getId(), application.getAccountdesignation());
         }

      } else {
         superusers.setTransadvisor(new Advisor());
      }
      
      return investors;
   }

   public List loadProviders() throws DataAccessException {
      return this.companyDAO.findProviders();
   }
   
   public Company loadProviderSimple(String name) throws DataAccessException {
      return this.companyDAO.findProviderSimple(name); //.toArray()[0];
   }

   public List loadDealergroups() throws DataAccessException {
      return this.dealergroupDAO.findAll();
   }
   
   public Collection findDealergroups(String afsl) throws DataAccessException {
      // return getHibernateTemplate().find("from Dealergroup dealergroup
      // where dealergroup.afsl like ?", afsl);
      return this.dealergroupDAO.findByAfsl(afsl);
   }

   public Users findUsers(String username, String pwd) throws DataAccessException {
      // revisit
      Users instance = this.usersDAO.findById(username);
      return instance;
      // return (Logon)this.logonDAO.findByEmail(username).toArray()[0];
   }

   public Individual findIndividual(String key, String value) {
      return this.individualDAO.findIndividual(key, value);
   }

   public Dealergroup loadDealergroup(Long id) throws DataAccessException {
      Dealergroup dealergroup = this.dealergroupDAO.findById(id);
      log.info("dealergroup.name=" + dealergroup.getCompany().getName()+ ", dealergroup.advisorfirms="+ dealergroup.getAdvisorfirms().size());
      return dealergroup; // this.dealergroupDAO.findById(id);
   }


   public Map<Long, String> loadInvestors(Advisor advisor) throws DataAccessException {

      Map<Long, String> investors = new LinkedHashMap<Long, String>(Utils.getInvestors());
      Set<Application> applications = advisor.getApplications();

      Set<Application> sortedApps = new TreeSet<Application>(new ApplicationComp());
      sortedApps.addAll(applications);

      for (Application application : sortedApps) {
         investors.put(application.getId(), application.getAccountdesignation());
      }

      return investors;
   }

   /*
    * (non-Javadoc)
    * @see com.ubs.opi.service.Opi#loadAdvisors(com.ubs.opi.domain.Superusers)
    */
   public Map<String, String> loadAdvisors(Superusers superusers) throws DataAccessException {

      List<Advisor> advisorList = advisorDAO.findAll();
      Collections.sort(advisorList, new AdvisorComp());
      Map<String,String> advisors =  new LinkedHashMap<String,String>();

      advisors.put("1", "New Advisor");

      Iterator<Advisor> iter = advisorList.iterator();

      while (iter.hasNext()) {
         Advisor advisor = iter.next();
         advisors.put(""+advisor.getId(), advisor.getIndividual().getFullname());
      }
      superusers.setAdvisors(advisors);
      return advisors;
   }

   public Advisorfirm loadAdvisorfirm(Long id) throws DataAccessException {
      // return (Advisorfirm) getHibernateTemplate().load(Advisorfirm.class,
      // new Integer(id));
      return this.advisorfirmDAO.findById(id);
   }

   public Advisor loadAdvisorByUsername(String username) throws DataAccessException {
//    Users users = this.usersDAO.findById(username);
      Advisor advisor = null;
      Users users = this.usersDAO.findByUsername(username);
      if (users != null) {
         Individual individual = users.getIndividuals().iterator().next();
         advisor = (Advisor)individual.getAdvisors().toArray()[0];
         log.debug("advisor.getApplications().size()="+advisor.getApplications().size());
//       int size = advisor.getApplications().size();
//       Object[] arr = advisor.getApplications().toArray();
//       for (int i = 0; i < size; i++)
//          log.debug("Product name="+((Application) arr[0]).getProduct().getName());
      }

      return advisor;
   }

   public Advisor loadAdvisorSimple(Long id) throws DataAccessException {
      Advisor advisor = this.advisorDAO.findById(id);
      log.info("advisor.lastname=" + advisor.getIndividual().getLastname()); // paulmac
      return advisor;
   }

   public Set findApplications(Advisor advisor) throws DataAccessException {
      return this.loadAdvisor(advisor.getId()).getApplications();
   }

   public Advisor loadAdvisor(Long id) throws DataAccessException {
      Advisor instance = this.advisorDAO.findAdvisorApplicationsById(id); //findById(id);
      log.info("instance.getApplications().size()="+ instance.getApplications().size()); // paulmac - force load
      Iterator itr = instance.getApplications().iterator();
      while (itr.hasNext()) {
         log.debug("Product name="+ ((Application) itr.next()).getProduct().getName());
      }
      return instance;
   }

   public Individual loadIndividual(Long id) throws DataAccessException {
      return this.individualDAO.findById(id);
   }

   public Product findProduct(String name) throws DataAccessException {
      return (Product) this.productDAO.findByName(name).toArray()[0]; // Name is unique
   }

   public Advisor findAdvisorByFullname(String lastname, String firstname) throws DataAccessException {
      List<Individual> individuals = this.individualDAO.findByFullname(lastname, firstname);
      Advisor advisor = null;
      
      if (individuals.size() > 1)
      {
         Advisorfirm advisorfirm;
         Dealergroup dealergroup;
         for (Individual individual : individuals) {
            Advisor advisor1 = (Advisor)individual.getAdvisors().toArray()[0];
            Advisorfirm advisorfirm1 = advisor1.getAdvisorfirm();
            if (advisor == null)
               advisor = advisor1;
            else
               advisor.getAdvisorfirm();
         }
      }
//      individual.getAdvisors().size();
//      Advisor instance = (Advisor) individual.getAdvisors().iterator().next();
      return advisor;
   }
   
   // TODO
   public Advisor findAdvisor(Individual individual, int index) throws DataAccessException {
      individual.getAdvisors().size();
      Advisor instance = (Advisor) individual.getAdvisors().iterator().next();
      return instance;
   }

   public String loadIsDaApproved(Advisor advisor) throws DataAccessException {
      // org.hibernate.classic.Session session =
      // this.applicationDAO.getHibernateTemplate().getSessionFactory().openSession();
      Dealergroup dealergroup = this.advisorDAO.findById(advisor.getId()).getAdvisorfirm().getDealergroup(); // .getIsdaapproved();
      String isdaapproved = dealergroup.getIsdaapproved();
      // session.close();
      return isdaapproved;
   }

   public Advisor loadAdvisorDeep(long id) throws DataAccessException {
      Advisor instance = advisorDAO.findAdvisorByIdDeep(id); //  findById
      log.info("advisor.lastname=" + instance.getIndividual().getLastname()); // TODO
      // revisit for nullable af.company.
      log.info("advisor.advisorfirm.id=" + instance.getAdvisorfirm().getId()); // paulmac
      log.info("advisor.advisorfirm.companyname=" + instance.getAdvisorfirm().getCompany().getName()); // paulmac
      log.info("dealergroup.name.id=" + instance.getAdvisorfirm().getDealergroup().getId()); // paulmac
      return instance;
   }

   public Advisor loadAdvisorByIndividualId(long id) throws DataAccessException {
      Individual instance = this.individualDAO.findById(id);
      Advisor advisor = (Advisor) instance.getAdvisors().toArray()[0];
      log.info("advisor.applications.size="+ advisor.getApplications().size());
      log.info("individual.users.username="+ instance.getUsers().getUsername());
      Iterator itr = advisor.getApplications().iterator();
      while (itr.hasNext()) {
         Application application = (Application) itr.next();
         log.info("application.product.name="+ application.getProduct().getName());
      }
      return advisor;
   }

   public Advisor loadAdvisorSimple(long id) throws DataAccessException {
      Advisor instance = advisorDAO.findById(id);
      log.info("advisor.lastname=" + instance.getIndividual().getLastname()); // paulmac
      log.info("advisor.individual.username="+ instance.getIndividual().getUsers().getUsername()); // paulmac
      return instance;
   }

   public Application loadApplication(Application application) throws DataAccessException {
      log.info("application.product.name="+ application.getProduct().getName());
      if (application.getCompany() != null) {
         log.info("application.company.name"+ application.getCompany().getName());
      }
      if (application.getTrust() != null) {
         log.info("application.trust.companyByCompanyid.name="+ application.getTrust().getCompanyByCompanyid().getName());
      }
      log.info("application.getInvestorindividuals().size()="+ application.getInvestorindividuals().size());
      Iterator itr = application.getInvestorindividuals().iterator();
      while (itr.hasNext()) {
         Investorindividual investorindividual = (Investorindividual) itr.next();
         log.info("investorindividual.individual.lastname="+ investorindividual.getIndividual().getLastname());
      }
      return application;
   }

   public Application loadApplication(Long id) throws DataAccessException {
      Application application = this.applicationDAO.findById(id);
      if (application == null)
         return null;
      
      log.info("application.product.name="+ application.getProduct().getName());
      if (application.getCompany() != null) {
         log.info("application.company.name"+ application.getCompany().getName());
      }
      if (application.getTrust() != null) {
         log.info("application.trust.companyByCompanyid.name"+ application.getTrust().getCompanyByCompanyid().getName());
      }
      log.info("application.getInvestorindividuals().size()"+ application.getInvestorindividuals().size());
      Iterator itr = application.getInvestorindividuals().iterator();
      while (itr.hasNext()) {
         Investorindividual investorindividual = (Investorindividual) itr.next();
         log.info("investorindividual.role=" + investorindividual.getRole());
         if (investorindividual.getIndividual() == null) {
            log.warn("Investorindividual exists without associated Individual");
         } else {
            log.info("investorindividual.individual.lastname="+ investorindividual.getIndividual().getLastname());
         }
      }
      return application;
   }

   public Application loadApplicationSimple(Long id)
         throws DataAccessException {
      Application application = this.applicationDAO.findById(id);
      log.info("application.product.name="+ application.getProduct().getName());
      return application;
   }

   public void storeUsers(Users users) throws DataAccessException {
      usersDAO.merge(users);
   }

   public void storeCompany(Company company) throws DataAccessException {
      companyDAO.merge(company);
   }

   public void storeAdvisorSimple(Advisor advisor) throws DataAccessException {
      this.individualDAO.attachDirty(advisor.getIndividual());
      this.advisorDAO.update(advisor);
   }

   public void storeAdvisorValidated(Advisor advisor)
         throws DataAccessException {
      advisor.getIndividual().getUsers().setEnabled("true");
      advisor.setIsactivated(Constants.TRUE);
      this.usersDAO.update(advisor.getIndividual().getUsers());
      this.advisorDAO.update(advisor);
   }

   public void storeDealergroup(Dealergroup dealergroup)
         throws DataAccessException {
      this.companyDAO.merge(dealergroup.getCompany());
      this.dealergroupDAO.merge(dealergroup);
   }

   @SuppressWarnings("unchecked")
   public void storeAdvisorComplete(Advisor advisor) throws DataAccessException {
      if (advisor.getAdvisorfirm().getDealergroup().isNew()) {
         this.companyDAO.merge(advisor.getAdvisorfirm().getDealergroup().getCompany());
         this.dealergroupDAO.merge(advisor.getAdvisorfirm().getDealergroup());
      }

      if (advisor.getAdvisorfirm().isNew()) {
         this.companyDAO.merge(advisor.getAdvisorfirm().getCompany());
         this.advisorfirmDAO.merge(advisor.getAdvisorfirm());
      } 
//      else {
//         this.companyDAO.attachDirty(advisor.getAdvisorfirm().getCompany());
//         this.advisorfirmDAO.attachDirty(advisor.getAdvisorfirm());
//      }
      if (advisor.isNew()) {
         String lastname = advisor.getIndividual().getLastname();
         String firstname = advisor.getIndividual().getFirstname();
         List users = this.usersDAO.findByEnabled("true");
         AuthenticationManager auth = new SimpleAuthenticationManager();

         String pwd = auth.generatePwd(8);
         String username = auth.generateUserName(firstname, lastname, users);

         advisor.getIndividual().getUsers().setUsername(username);
         advisor.getIndividual().getUsers().setPassword(pwd);
         advisor.getAuthorities().getId().setUsername(username);
         advisor.getIndividual().getUsers().setEnabled("true");
         // advisor.setIsactivated(Constants.TRUE);
         this.usersDAO.merge(advisor.getIndividual().getUsers());
         advisor.getAuthorities().setUsers(advisor.getIndividual().getUsers());
         this.authoritiesDAO.merge(advisor.getAuthorities());
         this.individualDAO.merge(advisor.getIndividual());
         Set<Advisorprovider> advisorproviders = advisor.getAdvisorproviders();
         advisor.setAdvisorproviders(null);
         this.advisorDAO.merge(advisor);
         if (advisorproviders.size() > 0) {
            for (Advisorprovider advisorprovider : advisorproviders ) {
               this.advisorproviderDAO.merge(advisorprovider);               
            }
         }
      } 
//      else {
//         this.usersDAO.attachDirty(advisor.getIndividual().getUsers());
//         this.authoritiesDAO.attachDirty(advisor.getAuthorities());
//         this.individualDAO.attachDirty(advisor.getIndividual());
//         this.advisorDAO.attachDirty(advisor);
//         Set<Advisorprovider> advisorproviders = advisor.getAdvisorproviders();
//         if (advisorproviders.size() > 0) {
//            for (Advisorprovider advisorprovider : advisorproviders ) {
//               this.advisorproviderDAO.merge(advisorprovider);               
//            }
//         }
//      }
      // need to add advisorFirm to DealerGroup at this point?
   }

   public Investorindividual loadIndividualToApplication(Long id, String role) throws DataAccessException {
      Application existingApplication = this.applicationDAO.findById(id);
      Individual individual = new Individual();
      Investorindividual investorindividual = new Investorindividual();
      investorindividual.setRole(role); // revisit
      investorindividual.setIndividual(individual);
      log.info("application.investorindividuals.size="+ existingApplication.getInvestorindividuals().size());
      existingApplication.addInvestorindividual(investorindividual);
      // individual.setTransInvestorindividual(investorindividual);
      return investorindividual;
   }

   public Application findApplicationByName(String name, long id) throws DataAccessException {
      // modify to only get the latest application as the individuals may have
      // changed
      List applications = this.applicationDAO.findByAccountdesignation(name);
      Application application = null;
      Iterator itr = applications.iterator();
      while (itr.hasNext()) {
         application = (Application) itr.next();
         log.info("application.advisor.id="+ application.getAdvisor().getId());
         if (application.getIslatest().equals(Constants.TRUE) && (application.getAdvisor().getId() == id)) {
            log.info("Clone accountdesignation="+ application.getAccountdesignation() + " Id="+ application.getId()+ application.getType());
            Set iiSet = application.getInvestorindividuals();
            log.info("investorindividuals size=" + iiSet.size());
            Iterator itrII = application.getInvestorindividuals().iterator();
            while (itrII.hasNext()) {
               Investorindividual investorindividual = (Investorindividual) itrII.next();
               log.info("investorindividual.individual.lastname="+ investorindividual.getIndividual().getLastname());
            }
            if (application.getCompany() != null) {
               log.info("application.company.name="+ application.getCompany().getName());
            }
            if (application.getTrust() != null) {
               log.info("application.trust.companyByCompanyid.name="+ application.getTrust().getCompanyByCompanyid().getName());
            }
            log.info("application.product"+ application.getProduct().getName());
            log.info("application.advisor.individual.lastname"+ application.getAdvisor().getIndividual().getLastname());
            return application;
         }
      }
      return null;
   }

   public void storeApplicationDirty(Application application)
         throws DataAccessException {
      application.setModifiedby(Utils.getUser().getUsername());
      application.setRecordModified(new Date()); // i.e now
      this.applicationDAO.update(application);
   }

   public void storeBeneficiary(Application application) throws DataAccessException {
      if (application.getBeneficiary().getIndividual().isNew()) {
         this.individualDAO.merge(application.getBeneficiary().getIndividual());
      } else {
         this.individualDAO.attachDirty(application.getBeneficiary().getIndividual());
      }
      if (application.getBeneficiary().isNew()) {
         this.investorindividualDAO.merge(application.getBeneficiary());
      } else {
         this.investorindividualDAO.attachDirty(application.getBeneficiary());
      }
      application.addInvestorindividual(application.getBeneficiary());
      application.setModifiedby(Utils.getUser().getUsername());
      application.setRecordModified(new Date()); // i.e now
      this.applicationDAO.attachDirty(application);
   }

   private void storeIndividualinvestors(Application application) throws DataAccessException {
      Set investorindividuals = application.getInvestorindividuals();
      log.info("investorindividuals.size()=" + investorindividuals.size());
      application.setInvestorindividuals(new TreeSet<Investorindividual>(new InvestorindividualComp()));
      if (application.isNew())
      {
         application.setCreatedby(Utils.getUser().getUsername());
         application.setRecordCreated(new Date());
         this.applicationDAO.merge(application);
      }
      else
      {
         application.setModifiedby(Utils.getUser().getUsername());
         application.setRecordModified(new Date());
         this.applicationDAO.update(application);
      }
      Iterator iterator = investorindividuals.iterator();
      while (iterator.hasNext()) {
         Investorindividual investorindividual = (Investorindividual) iterator.next();
         if (!StringUtils.hasText(investorindividual.getIndividual().getLastname())) {
            continue;
         }
         Individual individual = investorindividual.getIndividual();
         if (individual.isNew()) {
            this.individualDAO.merge(individual);
         } else {
            this.individualDAO.attachDirty(individual);
         }
         investorindividual.setApplication(application);
         if (investorindividual.isNew()) {
            this.investorindividualDAO.merge(investorindividual);
         } else {
            this.investorindividualDAO.attachDirty(investorindividual);
         }

         application.addInvestorindividual(investorindividual);
      }
   }

   public void removeApplication(long id) throws DataAccessException {
      Application persistentInstance = this.applicationDAO.findById(id);
      if (persistentInstance.getCompany() != null) {
         this.companyDAO.delete(persistentInstance.getCompany());
      }
      if (persistentInstance.getTrust() != null) {
         this.companyDAO.delete(persistentInstance.getTrust().getCompanyByCompanyid());
         this.trustDAO.delete(persistentInstance.getTrust());
      }
      Iterator itr = persistentInstance.getInvestorindividuals().iterator();
      while (itr.hasNext()) {
         Investorindividual investorindividual = (Investorindividual) itr.next();
         if (investorindividual.getIndividual() != null) {
            this.individualDAO.delete(investorindividual.getIndividual());
         } else {
            log.warn("Investorindividual exists with no asociated Individual!");
         }
         this.investorindividualDAO.delete(investorindividual);
      }
      this.applicationDAO.delete(persistentInstance);
   }

   public void removeInvestor(Application application, int index) throws DataAccessException {

      Investorindividual investorindividual = application.getInvestorindividualsarray()[index];
      // this.individualDAO.getHibernateTemplate().getSessionFactory().openSession();
      Individual individual = this.individualDAO.findById(investorindividual.getIndividual().getId());
      // int size = individual.getInvestorindividuals().size();

      if (investorindividual.isNew()) // application.isNew() ||
      {
         application.getInvestorindividuals().remove(investorindividual);
      } else {
         // if (investorindividual.isNew()) {
         // application.getInvestorindividuals().remove(investorindividual);
         // }
         // else {
         //
         // if (size <= 1)
         // this.individualDAO.delete(individual);
         application.getInvestorindividuals().remove(investorindividual);
         this.individualDAO.delete(individual);
         this.investorindividualDAO.delete(investorindividual);
         application.setModifiedby(Utils.getUser().getUsername());
         application.setRecordModified(new Date()); // i.e now
         this.applicationDAO.attachDirty(application);
         // }
      }
      // this.individualDAO.getHibernateTemplate().getSessionFactory().close();
   }

   public void storeApplication(Application application) throws DataAccessException {
      if (application.getCompany() != null) {
         if (application.getCompany().isNew()) {
            this.companyDAO.merge(application.getCompany());
         } else {
            this.companyDAO.attachDirty(application.getCompany());
         }
      }
      if (application.getTrust() != null) {
         if (application.getTrust().isNew()) {
            this.companyDAO.merge(application.getTrust().getCompanyByCompanyid());
            this.trustDAO.merge(application.getTrust());
         } else {
            this.companyDAO.attachDirty(application.getTrust().getCompanyByCompanyid());
            this.trustDAO.attachDirty(application.getTrust());
         }
         // application.setTrust(null);
      }

      storeIndividualinvestors(application);
   }

   public void storeBdm(Individual bdm) throws DataAccessException {
      this.individualDAO.merge(bdm);
   }

   public void storeIndividual(Individual individual) throws DataAccessException {
      // this.roleDAO.merge((Role)((HashSet<Role>)individual.getLogon().getRoles()).toArray()[0]);
      if (individual.isNew()) {
         this.individualDAO.merge(individual);
         // merge also newly instantiated investorindividuals
         if (individual.getTransInvestorindividual().isNew()) {
            ;
         }
         investorindividualDAO.merge(individual.getTransInvestorindividual());
      } else {
         this.individualDAO.attachDirty(individual);
         if (individual.getTransInvestorindividual() != null) {
            this.investorindividualDAO.attachDirty(individual.getTransInvestorindividual());
         }
      }
      // individual.getInvestorindividuals().
   }

   public Individual loadNewIndividual(Long id) throws DataAccessException {
      Individual existingIndividual = this.individualDAO.findById(id);
      Set investorindividuals = existingIndividual.getInvestorindividuals();
      Investorindividual ii = null;
      log.info("investorindividuals.size()=" + investorindividuals.size());
      Iterator itr = investorindividuals.iterator();
      while (itr.hasNext()) {
         ii = (Investorindividual) itr.next();
         if (ii.isNew()) {
            existingIndividual.getInvestorindividuals().remove(ii);
            break;
         }
      }

      // Application application = ii.getApplication();
      Individual individual = new Individual();
      ii.setIndividual(individual);
      // ii.setApplication(application);
      // get the Dealergroup referred to by id in the request
      // return
      // getOpi().loadIndividual(ServletRequestUtils.getRequiredLongParameter(request,
      // "individualId"));
      return individual;
   }

   
   public Advisor createNewAdvisor(Advisorfirm advisorfirm, String theme) {

      Advisor advisor = new Advisor();
   
      //Users users = Utils.getUser();
      Individual individual = new Individual(); 
   //   String theme = this.getThemeParam(request);
      if (theme != null) {
         log.info("associating advisor with="+theme);
         Company provider = this.loadProviderSimple(theme); // 'dealer' must have a provider         
         Advisorprovider advisorprovider = new Advisorprovider();
         advisorprovider.setCompany(provider);
         advisorprovider.setAdvisor(advisor);
         advisor.addAdvisorproviders(advisorprovider);
      }
      else { // associate all Products with the new Advisor
         log.info("associating advisor with all Providers");
         List<Company> providers = this.loadProviders();
         for (Company provider : providers) {
            Advisorprovider advisorprovider = new Advisorprovider();
            advisorprovider.setCompany(provider);
            advisorprovider.setAdvisor(advisor);
            advisor.addAdvisorproviders(advisorprovider);
         }
      }
      Users users = new Users();
      AuthoritiesId authoritiesId = new AuthoritiesId();
      authoritiesId.setAuthority(Constants.ADVISOR);
      Authorities authorities = new Authorities();
      authorities.setId(authoritiesId); 
      advisor.setAuthorities(authorities);
   //   Individual individual = new Individual();
      individual.setUsers(users);
   //   Users.setIndividual(individual);
   //   Users.setRole(role);
   //   advisorfirm.setUsers(Users);
      //dealergroup.addAdvisorfirm(advisorfirm);
      advisor.setIndividual(individual);
      advisor.setAdvisorfirm(advisorfirm);
      //advisorfirm.getUsers().addIndividual(individual);
      return advisor;
   }

   public MailManager myMailManager() {
      return mailManager;
   }

   public void setMailManager(MailManager mailManager) {
      this.mailManager = mailManager;
   }

   public void setAdvisorfirmDAO(AdvisorfirmDAO advisorfirmDAO) {
      this.advisorfirmDAO = advisorfirmDAO;
   }

   public void setAdvisorDAO(AdvisorDAO advisorDAO) {
      this.advisorDAO = advisorDAO;
   }

   public void setCompanyDAO(CompanyDAO companyDAO) {
      this.companyDAO = companyDAO;
   }

   public void setDealergroupDAO(DealergroupDAO dealergroupDAO) {
      this.dealergroupDAO = dealergroupDAO;
   }

   public void setIndividualDAO(IndividualDAO individualDAO) {
      this.individualDAO = individualDAO;
   }

   public void setApplicationDAO(ApplicationDAO applicationDAO) {
      this.applicationDAO = applicationDAO;
   }

   public void setInvestorindividualDAO(InvestorindividualDAO investorindividualDAO) {
      this.investorindividualDAO = investorindividualDAO;
   }

   public void setProductDAO(ProductDAO productDAO) {
      this.productDAO = productDAO;
   }

   public void setTrustDAO(TrustDAO trustDAO) {
      this.trustDAO = trustDAO;
   }

   public void setAuthoritiesDAO(AuthoritiesDAO authoritiesDAO) {
      this.authoritiesDAO = authoritiesDAO;
   }

   public void setUsersDAO(UsersDAO usersDAO) {
      this.usersDAO = usersDAO;
   }

   public void setAdvisorproviderDAO(AdvisorproviderDAO advisorproviderDAO) {
      this.advisorproviderDAO = advisorproviderDAO;
   }


   public void setBankDAO(BankDAO bankDAO) {
      this.bankDAO = bankDAO;
   }

}
