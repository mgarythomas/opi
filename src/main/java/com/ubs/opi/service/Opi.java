package com.ubs.opi.service;

import java.io.IOException;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletException;

import org.springframework.dao.DataAccessException;

import com.ubs.opi.domain.Advisor;
import com.ubs.opi.domain.Advisorfirm;
import com.ubs.opi.domain.Application;
import com.ubs.opi.domain.Bank;
import com.ubs.opi.domain.Company;
import com.ubs.opi.domain.Dealergroup;
import com.ubs.opi.domain.Dwradvisor;
import com.ubs.opi.domain.Dwradvisorfirm;
import com.ubs.opi.domain.Dwrapplication;
import com.ubs.opi.domain.Dwrdealergroup;
import com.ubs.opi.domain.Individual;
import com.ubs.opi.domain.Investorindividual;
import com.ubs.opi.domain.Product;
import com.ubs.opi.domain.Superusers;
import com.ubs.opi.domain.Users;
import com.ubs.opi.support.MailManager;

/**
 * The high-level Opi business interface.
 *
 * <p>
 * This is basically a data access object, as Opi doesn't have dedicated
 * business logic.
 *
 * @author Paul McLachlan
 */
public interface Opi {
    public String addIndividualToApp() throws ServletException, IOException;

    public String getApplicationTable(int id) throws ServletException, IOException;

    public String getInclude(int id) throws ServletException, IOException;

    public Bank fillAddress(String bsb, long id);
    
    public Bank findDirectCreditInstitution(String bsb, Long applicationId);

    public Dwrdealergroup fillDealergroup(String afsl);

    public Dwradvisorfirm fillAdvisorfirm(String afsl, String abn);

    public List<Dwrdealergroup> getAllDwrdealergroups() throws DataAccessException;
    
    public List<Dwradvisorfirm> getDwradvisorfirms(Long id) throws DataAccessException;

    public List<Dwradvisor> getDwradvisors(Long id) throws DataAccessException;

    public String storeDwrdealergroup(Dwrdealergroup dwrdg);

    public String storeDwradvisorfirm(Long dealergroupid, Dwradvisorfirm dwraf); // { afsl

    public String storeMoveDwradvisorfirm(Long dealergroupid, Dwradvisorfirm dwraf, Long toadvisorfirmid);

    public String storeMoveDwradvisor(Long advisorfirmid, Dwradvisor dwradv, Long toadvisorid);

    public String storeDwradvisor(Long advisorfirmid, Dwradvisor dwradv);

    public List<Dwrapplication> getDwrapplications(Long id) throws DataAccessException;
    public String storeDwrapplication(Long advisorid, Dwrapplication dwrapp);
    public String storeMoveDwrapplication(Long advisorid, Dwrapplication dwrapp, Long toadvisorid);
    
    public void removeDwrdealergroup(String afsl);

    public void removeDwradvisor(Long id);

    public void removeDwradvisorfirm(Long id);

    public Advisor findByAbnAndFullname(Object abn, Object lastname, Object firstname);

    public Individual findIndividual(String key, String value);
    
    public Map<Long, String> loadInvestors(Superusers superusers) throws DataAccessException;
      
    /**
    * Retrieve <code>Dealergroup</code>s from the datastore by afsl,
    * returning all dealergroups whose afsl <i>equals</i> afsl.
    *
    * @param afsl
    *            Value to search for
    * @return a <code>Collection</code> of matching <code>Dealergroup</code>s
    *         (or an empty <code>Collection</code> if none found)
    */
    public Collection findDealergroups(String afsl) throws DataAccessException;

   /**
    * Retrieve an <code>Dealergroup</code> from the datastore by id.
    *
    * @param id
    *            the id to search for
    * @return the <code>Dealergroup</code> if found
    * @throws org.springframework.dao.DataRetrievalFailureException
    *             if not found
    */
   public Users findUsers(String username, String pwd) throws DataAccessException;

   /**
    * Retrieve an <code>Dealergroup</code> from the datastore by id.
    *
    * @param id
    *            the id to search for
    * @return the <code>Dealergroup</code> if found
    * @throws org.springframework.dao.DataRetrievalFailureException
    *             if not found
    */
   public String loadIsDaApproved(Advisor advisor) throws DataAccessException;

   public Dealergroup loadDealergroup(Long id) throws DataAccessException;

   public List<Dealergroup> loadDealergroups() throws DataAccessException;

   public abstract Map<Long, String> loadInvestors(Advisor advisor) throws DataAccessException;

   public abstract Map<String, String> loadAdvisors(Superusers superusers) throws DataAccessException;

      /**
    * Retrieve a <code>Advisorfirm</code> from the datastore by id.
    *
    * @param id
    *            the id to search for
    * @return the <code>Advisorfirm</code> if found
    * @throws org.springframework.dao.DataRetrievalFailureException
    *             if not found
    */
   Advisorfirm loadAdvisorfirm(Long id) throws DataAccessException;

   /**
    * Retrieve a <code>Advisor</code> from the datastore by id.
    *
    * @param id
    *            the id to search for
    * @return the <code>Advisorfirm</code> if found
    * @throws org.springframework.dao.DataRetrievalFailureException
    *             if not found
    */
   Advisor loadAdvisor(Long id) throws DataAccessException;

   // just the advisor and it's individual
   Advisor loadAdvisorSimple(Long id) throws DataAccessException;

   List loadProviders() throws DataAccessException;

   Company loadProviderSimple(String name) throws DataAccessException;

   Individual loadIndividual(Long id) throws DataAccessException;

   Advisor loadAdvisorByIndividualId(long id) throws DataAccessException;

   Advisor loadAdvisorSimple(long id) throws DataAccessException;

   Set findApplications(Advisor advisor) throws DataAccessException;
   
   Application loadApplicationSimple(Long id) throws DataAccessException;

   Application loadApplication(Long id) throws DataAccessException;

   Application loadApplication(Application application) throws DataAccessException;

   Product findProduct(String name) throws DataAccessException;

   Advisor findAdvisor(Individual individual, int index) throws DataAccessException;

   Advisor loadAdvisorByUsername(String username) throws DataAccessException;

   Individual loadNewIndividual(Long id) throws DataAccessException;

   Investorindividual loadIndividualToApplication(Long id, String Authorities) throws DataAccessException;

   Application findApplicationByName(String name, long id) throws DataAccessException;

   void storeAdvisorSimple(Advisor advisor) throws DataAccessException;

   void removeApplication(long id) throws DataAccessException;

   void removeInvestor(Application application, int index) throws DataAccessException;

   void storeApplicationDirty(Application application) throws DataAccessException;

   void storeApplication(Application application) throws DataAccessException;

   void storeAdvisorValidated(Advisor advisor) throws DataAccessException;

   public void storeBeneficiary(Application application) throws DataAccessException;

   public void storeUsers(Users users) throws DataAccessException;

   void storeCompany(Company company) throws DataAccessException;

   void storeDealergroup(Dealergroup dealergroup) throws DataAccessException;

   void storeBdm(Individual bdm) throws DataAccessException;

   void storeIndividual(Individual individual) throws DataAccessException;

   void storeAdvisorComplete(Advisor advisor) throws DataAccessException;

   MailManager myMailManager();

   public Advisor loadAdvisorDeep(long id) throws DataAccessException;

   public Advisor createNewAdvisor(Advisorfirm advisorfirm, String theme);
}
