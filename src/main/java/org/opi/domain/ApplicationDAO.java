package org.opi.domain;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.FetchMode;
import org.hibernate.LockMode;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.context.ApplicationContext;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

/**
 * Data access object (DAO) for domain model class Application.
 * @see org.opi.domain.Application
 * @author MyEclipse - Hibernate Tools
 */
public class ApplicationDAO extends HibernateDaoSupport {

    private static final Log log = LogFactory.getLog(ApplicationDAO.class);

	//property constants
	public static final String COMMISSION = "commission";
	public static final String APPLICATIONNUMBER = "applicationnumber";
	public static final String CLIENTNUMBER = "clientnumber";
	public static final String ACCOUNTDESIGNATION = "accountdesignation";
	public static final String FIRSTNAME = "firstname";
	public static final String MIDDLENAME = "middlename";
	public static final String LASTNAME = "lastname";
	public static final String HOMEPHONE = "homephone";
	public static final String WORKPHONE = "workphone";
	public static final String EMAIL = "email";
	public static final String FAX = "fax";
	public static final String ADDRESS1 = "address1";
	public static final String ADDRESS2 = "address2";
	public static final String SUBURB = "suburb";
	public static final String STATE = "state";
	public static final String POSTCODE = "postcode";
	public static final String COUNTRY = "country";
	public static final String TYPE = "type";
	public static final String APPLICATIONAMOUNT01 = "applicationamount01";
	public static final String APPLICATIONAMOUNT02 = "applicationamount02";
	public static final String APPLICATIONAMOUNT03 = "applicationamount03";
	public static final String APPLICATIONAMOUNT04 = "applicationamount04";
	public static final String APPLICATIONAMOUNT05 = "applicationamount05";
	public static final String APPROVEDAMOUNT01 = "approvedamount01";
	public static final String APPROVEDAMOUNT02 = "approvedamount02";
	public static final String APPROVEDAMOUNT03 = "approvedamount03";
	public static final String APPROVEDAMOUNT04 = "approvedamount04";
	public static final String APPROVEDAMOUNT05 = "approvedamount05";
	public static final String STATUS = "status";
	public static final String PAYMENTSTATUS = "paymentstatus";
	public static final String ISBORROWINGFROMUBS = "isborrowingfromubs";
	public static final String ISPURCHASINGPUTFROMUBS = "ispurchasingputfromubs";
	public static final String ISIAL = "isial";
	public static final String ISEITHERTOSIGN = "iseithertosign";
	public static final String ISPAPERCOPYWANTED = "ispapercopywanted";
	public static final String ISPROVIDERCUSTOMER = "isprovidercustomer";
	public static final String ISLATEST = "islatest";
	public static final String REINVESTDISTRIBUTION = "reinvestdistribution";
	public static final String DIRECTCREDITDISTRIBUTION = "directcreditdistribution";
	public static final String PROVIDERUNITHOLDERNUMBER = "providerunitholdernumber";
	public static final String PROVIDERFUNDNAME = "providerfundname";
	public static final String ISUBSCUSTOMER = "isubscustomer";
	public static final String UBSUNITHOLDERNUMBER = "ubsunitholdernumber";
	public static final String UBSFUNDNAME = "ubsfundname";
	public static final String DDAPPLICANT = "ddapplicant";
	public static final String DDABN = "ddabn";
	public static final String DDINSTITUTION = "ddinstitution";
	public static final String DDINSTITUTIONADDRESS = "ddinstitutionaddress";
	public static final String DDINSTITUTIONPOSTCODE = "ddinstitutionpostcode";
	public static final String DDINSTITUTIONSTATE = "ddinstitutionstate";
	public static final String DDINSTITUTIONSUBURB = "ddinstitutionsuburb";
	public static final String DDACCOUNTNAME = "ddaccountname";
	public static final String DDBSB = "ddbsb";
	public static final String DDACCOUNTNO = "ddaccountno";
	public static final String ICASH = "icash";
	public static final String ISHARES = "ishares";
	public static final String IOTHERLIQUID = "iotherliquid";
	public static final String IRESIDENTIALPROPERTY = "iresidentialproperty";
	public static final String IINVESTMENTPROPERTY = "iinvestmentproperty";
	public static final String IOTHERASSETS = "iotherassets";
	public static final String IOTHERASSETSDETAILS = "iotherassetsdetails";
	public static final String IOTHERLOANSSECURED = "iotherloanssecured";
	public static final String ILOANSRESIDENTIALPROPERTY = "iloansresidentialproperty";
	public static final String ILOANSINVESTMENTPROPERTY = "iloansinvestmentproperty";
	public static final String ILOANSPERSONALUNSECURED = "iloanspersonalunsecured";
	public static final String IGUARANTEESGRANTED = "iguaranteesgranted";
	public static final String IOTHERLIABILITIES = "iotherliabilities";
	public static final String IOTHERLIABILITIESDETAILS = "iotherliabilitiesdetails";
	public static final String ISALARY = "isalary";
	public static final String IRENTALANDDIVIDEND = "irentalanddividend";
	public static final String IOTHERINCOME = "iotherincome";
	public static final String IOTHERINCOMEDETAILS = "iotherincomedetails";
	public static final String ITAXPAYABLE = "itaxpayable";
	public static final String IINTERESTONSECUREDLOANS = "iinterestonsecuredloans";
	public static final String IINTERESTONUNSECUREDLOANS = "iinterestonunsecuredloans";
	public static final String ILIVINGEXPENSES = "ilivingexpenses";
	public static final String IOTHEREXPENSES = "iotherexpenses";
	public static final String IOTHEREXPENSESDETAILS = "iotherexpensesdetails";
	public static final String GCASH = "gcash";
	public static final String GSHARES = "gshares";
	public static final String GOTHERLIQUID = "gotherliquid";
	public static final String GRESIDENTIALPROPERTY = "gresidentialproperty";
	public static final String GINVESTMENTPROPERTY = "ginvestmentproperty";
	public static final String GOTHERASSETS = "gotherassets";
	public static final String GOTHERASSETSDETAILS = "gotherassetsdetails";
	public static final String GOTHERLOANSSECURED = "gotherloanssecured";
	public static final String GLOANSRESIDENTIALPROPERTY = "gloansresidentialproperty";
	public static final String GLOANSINVESTMENTPROPERTY = "gloansinvestmentproperty";
	public static final String GLOANSPERSONALUNSECURED = "gloanspersonalunsecured";
	public static final String GGUARANTEESGRANTED = "gguaranteesgranted";
	public static final String GOTHERLIABILITIES = "gotherliabilities";
	public static final String GOTHERLIABILITIESDETAILS = "gotherliabilitiesdetails";
	public static final String GSALARY = "gsalary";
	public static final String GRENTALANDDIVIDEND = "grentalanddividend";
	public static final String GOTHERINCOME = "gotherincome";
	public static final String GOTHERINCOMEDETAILS = "gotherincomedetails";
	public static final String GTAXPAYABLE = "gtaxpayable";
	public static final String GINTERESTONSECUREDLOANS = "ginterestonsecuredloans";
	public static final String GINTERESTONUNSECUREDLOANS = "ginterestonunsecuredloans";
	public static final String GLIVINGEXPENSES = "glivingexpenses";
	public static final String GOTHEREXPENSES = "gotherexpenses";
	public static final String GOTHEREXPENSESDETAILS = "gotherexpensesdetails";
	public static final String ONBOARDINGSTATUS = "onboardingstatus";
	public static final String ONBOARDINGLASTUSER = "onboardinglastuser";
	public static final String ONBOARDINGCOMMENTS = "onboardingcomments";
	public static final String ONBOARDINGHARDCOPYSIGHTED = "onboardinghardcopysighted";
	public static final String DADEALERGROUP = "dadealergroup";
	public static final String CREDITSTATUS = "creditstatus";
	public static final String CREDITLASTUSER = "creditlastuser";
	public static final String CREDITCOMMENTS = "creditcomments";
	public static final String CASAPPROVED = "casapproved";
	public static final String BAYCORPSAPPROVED = "baycorpsapproved";
	public static final String AMLSTATUS = "amlstatus";
	public static final String AMLLASTUSER = "amllastuser";
	public static final String AMLCOMMENTS = "amlcomments";
	public static final String AMLHARDCOPYSIGHTED = "amlhardcopysighted";
	public static final String CREDITCHECKVERIFIED = "creditcheckverified";
	public static final String GRIDCHECKVERIFIED = "gridcheckverified";
	public static final String WORLDCHECKVERIFIED = "worldcheckverified";
	public static final String GOOGLECHECKVERIFIED = "googlecheckverified";
	public static final String CORPORATECHECKSVERIFIED = "corporatechecksverified";
	public static final String TRUSTCHECKSVERIFIED = "trustchecksverified";
	public static final String OPERATIONSCOMMENTS = "operationscomments";
	public static final String BANK3RDPARTYAUTHORISATION = "bank3rdpartyauthorisation";
	public static final String BILLINGAPPROVED = "billingapproved";
	public static final String RECONCILEDBILLINGDATA = "reconciledbillingdata";
	public static final String GENERATEDBILLINGDATA = "generatedbillingdata";
	public static final String AMOUNTDUEPAID = "amountduepaid";
	public static final String DDPAYMENTSUCCESSFUL = "ddpaymentsuccessful";
	public static final String DDUNSUCCESSFULREASON = "ddunsuccessfulreason";
	public static final String INITIALPAYMENTBYCHEQUE = "initialpaymentbycheque";
	public static final String PAYMENTBYALTERNATIVEMEANS = "paymentbyalternativemeans";
	public static final String CONDUCTEDBILLING = "conductedbilling";
	public static final String GENERATEDAPPROVALLETTER = "generatedapprovalletter";
	public static final String GENERATEDREJECTIONLETTER = "generatedrejectionletter";
	public static final String ADMINISTRATIONCOMMENTS = "administrationcomments";
	public static final String ONBOARDINGINFO1SATISFIED = "onboardinginfo1satisfied";
	public static final String ONBOARDINGINFO1COMMENTARY = "onboardinginfo1commentary";
	public static final String ONBOARDINGINFO2SATISFIED = "onboardinginfo2satisfied";
	public static final String ONBOARDINGINFO2COMMENTARY = "onboardinginfo2commentary";
	public static final String ONBOARDINGINFO3SATISFIED = "onboardinginfo3satisfied";
	public static final String ONBOARDINGINFO3COMMENTARY = "onboardinginfo3commentary";
	public static final String CREDITINFO1SATISFIED = "creditinfo1satisfied";
	public static final String CREDITINFO1COMMENTARY = "creditinfo1commentary";
	public static final String CREDITINFO2SATISFIED = "creditinfo2satisfied";
	public static final String CREDITINFO2COMMENTARY = "creditinfo2commentary";
	public static final String CREDITINFO3SATISFIED = "creditinfo3satisfied";
	public static final String CREDITINFO3COMMENTARY = "creditinfo3commentary";
	public static final String AMLINFO1SATISFIED = "amlinfo1satisfied";
	public static final String AMLINFO1COMMENTARY = "amlinfo1commentary";
	public static final String AMLINFO2SATISFIED = "amlinfo2satisfied";
	public static final String AMLINFO2COMMENTARY = "amlinfo2commentary";
	public static final String AMLINFO3SATISFIED = "amlinfo3satisfied";
	public static final String AMLINFO3COMMENTARY = "amlinfo3commentary";
	public static final String ONBOARDINGINFONOTYETCHECKED = "onboardinginfonotyetchecked";
	public static final String CREDITINFONOTYETCHECKED = "creditinfonotyetchecked";
	public static final String AMLINFONOTYETCHECKED = "amlinfonotyetchecked";
	public static final String BAYCORPRECORDCREATED = "baycorprecordcreated";
	public static final String ASICCOMPANYSEARCH = "asiccompanysearch";
	public static final String ATOREGISTRATION = "atoregistration";
	public static final String TRUSTDEEDAPPROVED = "trustdeedapproved";
	public static final String APPLICANT1APPROVED = "applicant1approved";
	public static final String APPLICANT1MATERIAL = "applicant1material";
	public static final String APPLICANT1IMMATERIAL = "applicant1immaterial";
	public static final String APPLICANT1NOHIT = "applicant1nohit";
	public static final String APPLICANT1NOTAPPLICABLE = "applicant1notapplicable";
	public static final String APPLICANT2APPROVED = "applicant2approved";
	public static final String APPLICANT2MATERIAL = "applicant2material";
	public static final String APPLICANT2IMMATERIAL = "applicant2immaterial";
	public static final String APPLICANT2NOHIT = "applicant2nohit";
	public static final String APPLICANT2NOTAPPLICABLE = "applicant2notapplicable";
	public static final String COMPANYAPPROVED = "companyapproved";
	public static final String COMPANYMATERIAL = "companymaterial";
	public static final String COMPANYIMMATERIAL = "companyimmaterial";
	public static final String COMPANYNOHIT = "companynohit";
	public static final String COMPANYNOTAPPLICABLE = "companynotapplicable";
	public static final String OTHERPERSONSAPPROVED = "otherpersonsapproved";
	public static final String OTHERPERSONSMATERIAL = "otherpersonsmaterial";
	public static final String OTHERPERSONSIMMATERIAL = "otherpersonsimmaterial";
	public static final String OTHERPERSONSNOHIT = "otherpersonsnohit";
	public static final String OTHERPERSONSNOTAPPLICABLE = "otherpersonsnotapplicable";
	public static final String APPLICATIONWITHDRAWN = "applicationwithdrawn";
	public static final String APPLICATIONDELETED = "applicationdeleted";
	public static final String BAYCORP1FILECREATED = "baycorp1filecreated";
	public static final String GRIDCHECK1APPROVED = "gridcheck1approved";
	public static final String WORLDCHECK1APPROVED = "worldcheck1approved";
	public static final String GOOGLECHECK1APPROVED = "googlecheck1approved";
	public static final String ASICDIRECTOR1CHECK = "asicdirector1check";
	public static final String ASICBENEFICIARY1CHECK = "asicbeneficiary1check";
	public static final String BAYCORP2FILECREATED = "baycorp2filecreated";
	public static final String GRIDCHECK2APPROVED = "gridcheck2approved";
	public static final String WORLDCHECK2APPROVED = "worldcheck2approved";
	public static final String GOOGLECHECK2APPROVED = "googlecheck2approved";
	public static final String ASICDIRECTOR2CHECK = "asicdirector2check";
	public static final String ASICBENEFICIARY2CHECK = "asicbeneficiary2check";
	public static final String SUPERFUNDREGISTRATIONCHECK = "superfundregistrationcheck";
	public static final String ONBOARDINGLOCK = "onboardinglock";
	public static final String CREDITLOCK = "creditlock";
	public static final String AMLLOCK = "amllock";
	public static final String MAINLOCK = "mainlock";
	public static final String CREATEDBY = "createdby";
	public static final String MODIFIEDBY = "modifiedby";
	public static final String CHEQUEFORUBSATTACHED = "chequeforubsattached";
	public static final String CHEQUEAMOUNT = "chequeamount";
	public static final String CHEQUERETURNED = "chequereturned";
	public static final String CHEQUEACCEPTED = "chequeaccepted";
	public static final String ISREFERREDTOCRC = "isreferredtocrc";
	public static final String FIRSTDDSTATUSFAILED = "firstddstatusfailed";
	public static final String FIRSTDDSTATUSSUCCEEDED = "firstddstatussucceeded";
	public static final String ISSECONDDD = "isseconddd";
	public static final String SECONDDDSTATUSFAILED = "secondddstatusfailed";
	public static final String SECONDDDSTATUSSUCCEEDED = "secondddstatussucceeded";
	public static final String ISBPAY = "isbpay";
	public static final String BPAYREFERENCE = "bpayreference";
	public static final String BPAYSTATUSFAILED = "bpaystatusfailed";
	public static final String BPAYSTATUSSUCCEEDED = "bpaystatussucceeded";
	public static final String ISDIRECTCREDIT = "isdirectcredit";
	public static final String DIRECTCREDITSTATUSFAILED = "directcreditstatusfailed";
	public static final String DIRECTCREDITSTATUSSUCCEEDED = "directcreditstatussucceeded";
	public static final String OPSISSUERAISEDTICKED = "opsissueraisedticked";
	public static final String OPSISSUERAISEDUSERID = "opsissueraiseduserid";
	public static final String OPSISSUERESOLVEDTICKED = "opsissueresolvedticked";
	public static final String OPSISSUERESOLVEDUSERID = "opsissueresolveduserid";
	public static final String OPERATIONSCOMMENTS1 = "operationscomments1";
	public static final String OPERATIONSCOMMENTS2 = "operationscomments2";
	public static final String OPERATIONSCOMMENTS3 = "operationscomments3";
	public static final String OPERATIONSCOMMENTS4 = "operationscomments4";
	public static final String OPERATIONSCOMMENTS5 = "operationscomments5";
	public static final String OPERATIONSCOMMENTS6 = "operationscomments6";
	public static final String OPERATIONSCOMMENTS7 = "operationscomments7";
	public static final String OPERATIONSCOMMENTS8 = "operationscomments8";
	public static final String OPERATIONSCOMMENTS9 = "operationscomments9";
	public static final String OPERATIONSLASTUSER = "operationslastuser";
	public static final String ADMINISTRATIONLASTUSER = "administrationlastuser";
	public static final String MASTERLASTUSER = "masterlastuser";
	public static final String AMOUNTDUE = "amountdue";
	public static final String NEWAMOUNTDUE = "newamountdue";
	public static final String ADVISERBONAFIDESCHECKED = "adviserbonafideschecked";
	public static final String AUTOMATICDIRECTDEBITSUPPRESSED = "automaticdirectdebitsuppressed";
	public static final String FIRSTAMOUNTRECEIVED = "firstamountreceived";
	public static final String AMENDEDPAYMENTAMOUNT = "amendedpaymentamount";
	public static final String INHOUSEAMOUNT = "inhouseamount";

	protected void initDao() {
		//do nothing
	}

   // added by paulmac
   public void update(Application instance) {
      getHibernateTemplate().update(instance);
   }

    public void save(Application transientInstance) {
        log.debug("saving Application instance");
        try {
            getHibernateTemplate().save(transientInstance);
            log.debug("save successful");
        } catch (RuntimeException re) {
            log.error("save failed", re);
            throw re;
        }
    }

	public void delete(Application persistentInstance) {
        log.debug("deleting Application instance");
        try {
            getHibernateTemplate().delete(persistentInstance);
            log.debug("delete successful");
        } catch (RuntimeException re) {
            log.error("delete failed", re);
            throw re;
        }
    }

    public Application findById(Long applicationId) {
      Application application = 
        (Application) super.getHibernateTemplate().get(Application.class, applicationId);
      
      if (logger.isDebugEnabled()) {
        logger.debug("Returning application: " + application);
      }
      
      return application;
    }


    public List findByExample(Application instance) {
        log.debug("finding Application instance by example");
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
      log.debug("finding Application instance with property: " + propertyName
            + ", value: " + value);
      try {
         String queryString = "from Application as model where model."
         						+ propertyName + "= ?";
		 return getHibernateTemplate().find(queryString, value);
      } catch (RuntimeException re) {
         log.error("find by property name failed", re);
         throw re;
      }
	}

	public List findByCommission(Object commission) {
		return findByProperty(COMMISSION, commission);
	}

	public List findByApplicationnumber(Object applicationnumber) {
		return findByProperty(APPLICATIONNUMBER, applicationnumber);
	}

	public List findByClientnumber(Object clientnumber) {
		return findByProperty(CLIENTNUMBER, clientnumber);
	}

	public List findByAccountdesignation(Object accountdesignation) {
		return findByProperty(ACCOUNTDESIGNATION, accountdesignation);
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

	public List findByHomephone(Object homephone) {
		return findByProperty(HOMEPHONE, homephone);
	}

	public List findByWorkphone(Object workphone) {
		return findByProperty(WORKPHONE, workphone);
	}

	public List findByEmail(Object email) {
		return findByProperty(EMAIL, email);
	}

	public List findByFax(Object fax) {
		return findByProperty(FAX, fax);
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

	public List findByType(Object type) {
		return findByProperty(TYPE, type);
	}

	public List findByApplicationamount01(Object applicationamount01) {
		return findByProperty(APPLICATIONAMOUNT01, applicationamount01);
	}

	public List findByApplicationamount02(Object applicationamount02) {
		return findByProperty(APPLICATIONAMOUNT02, applicationamount02);
	}

	public List findByApplicationamount03(Object applicationamount03) {
		return findByProperty(APPLICATIONAMOUNT03, applicationamount03);
	}

	public List findByApplicationamount04(Object applicationamount04) {
		return findByProperty(APPLICATIONAMOUNT04, applicationamount04);
	}

	public List findByApplicationamount05(Object applicationamount05) {
		return findByProperty(APPLICATIONAMOUNT05, applicationamount05);
	}

	public List findByApprovedamount01(Object approvedamount01) {
		return findByProperty(APPROVEDAMOUNT01, approvedamount01);
	}

	public List findByApprovedamount02(Object approvedamount02) {
		return findByProperty(APPROVEDAMOUNT02, approvedamount02);
	}

	public List findByApprovedamount03(Object approvedamount03) {
		return findByProperty(APPROVEDAMOUNT03, approvedamount03);
	}

	public List findByApprovedamount04(Object approvedamount04) {
		return findByProperty(APPROVEDAMOUNT04, approvedamount04);
	}

	public List findByApprovedamount05(Object approvedamount05) {
		return findByProperty(APPROVEDAMOUNT05, approvedamount05);
	}

	public List findByStatus(Object status) {
		return findByProperty(STATUS, status);
	}

	public List findByPaymentstatus(Object paymentstatus) {
		return findByProperty(PAYMENTSTATUS, paymentstatus);
	}

	public List findByIsborrowingfromubs(Object isborrowingfromubs) {
		return findByProperty(ISBORROWINGFROMUBS, isborrowingfromubs);
	}

	public List findByIspurchasingputfromubs(Object ispurchasingputfromubs) {
		return findByProperty(ISPURCHASINGPUTFROMUBS, ispurchasingputfromubs);
	}

	public List findByIsial(Object isial) {
		return findByProperty(ISIAL, isial);
	}

	public List findByIseithertosign(Object iseithertosign) {
		return findByProperty(ISEITHERTOSIGN, iseithertosign);
	}

	public List findByIspapercopywanted(Object ispapercopywanted) {
		return findByProperty(ISPAPERCOPYWANTED, ispapercopywanted);
	}

	public List findByIsprovidercustomer(Object isprovidercustomer) {
		return findByProperty(ISPROVIDERCUSTOMER, isprovidercustomer);
	}

	public List findByIslatest(Object islatest) {
		return findByProperty(ISLATEST, islatest);
	}

	public List findByReinvestdistribution(Object reinvestdistribution) {
		return findByProperty(REINVESTDISTRIBUTION, reinvestdistribution);
	}

	public List findByDirectcreditdistribution(Object directcreditdistribution) {
		return findByProperty(DIRECTCREDITDISTRIBUTION, directcreditdistribution);
	}

	public List findByProviderunitholdernumber(Object providerunitholdernumber) {
		return findByProperty(PROVIDERUNITHOLDERNUMBER, providerunitholdernumber);
	}

	public List findByProviderfundname(Object providerfundname) {
		return findByProperty(PROVIDERFUNDNAME, providerfundname);
	}

	public List findByIsubscustomer(Object isubscustomer) {
		return findByProperty(ISUBSCUSTOMER, isubscustomer);
	}

	public List findByUbsunitholdernumber(Object ubsunitholdernumber) {
		return findByProperty(UBSUNITHOLDERNUMBER, ubsunitholdernumber);
	}

	public List findByUbsfundname(Object ubsfundname) {
		return findByProperty(UBSFUNDNAME, ubsfundname);
	}

	public List findByDdapplicant(Object ddapplicant) {
		return findByProperty(DDAPPLICANT, ddapplicant);
	}

	public List findByDdabn(Object ddabn) {
		return findByProperty(DDABN, ddabn);
	}

	public List findByDdinstitution(Object ddinstitution) {
		return findByProperty(DDINSTITUTION, ddinstitution);
	}

	public List findByDdinstitutionaddress(Object ddinstitutionaddress) {
		return findByProperty(DDINSTITUTIONADDRESS, ddinstitutionaddress);
	}

	public List findByDdinstitutionpostcode(Object ddinstitutionpostcode) {
		return findByProperty(DDINSTITUTIONPOSTCODE, ddinstitutionpostcode);
	}

	public List findByDdinstitutionstate(Object ddinstitutionstate) {
		return findByProperty(DDINSTITUTIONSTATE, ddinstitutionstate);
	}

	public List findByDdinstitutionsuburb(Object ddinstitutionsuburb) {
		return findByProperty(DDINSTITUTIONSUBURB, ddinstitutionsuburb);
	}

	public List findByDdaccountname(Object ddaccountname) {
		return findByProperty(DDACCOUNTNAME, ddaccountname);
	}

	public List findByDdbsb(Object ddbsb) {
		return findByProperty(DDBSB, ddbsb);
	}

	public List findByDdaccountno(Object ddaccountno) {
		return findByProperty(DDACCOUNTNO, ddaccountno);
	}

	public List findByIcash(Object icash) {
		return findByProperty(ICASH, icash);
	}

	public List findByIshares(Object ishares) {
		return findByProperty(ISHARES, ishares);
	}

	public List findByIotherliquid(Object iotherliquid) {
		return findByProperty(IOTHERLIQUID, iotherliquid);
	}

	public List findByIresidentialproperty(Object iresidentialproperty) {
		return findByProperty(IRESIDENTIALPROPERTY, iresidentialproperty);
	}

	public List findByIinvestmentproperty(Object iinvestmentproperty) {
		return findByProperty(IINVESTMENTPROPERTY, iinvestmentproperty);
	}

	public List findByIotherassets(Object iotherassets) {
		return findByProperty(IOTHERASSETS, iotherassets);
	}

	public List findByIotherassetsdetails(Object iotherassetsdetails) {
		return findByProperty(IOTHERASSETSDETAILS, iotherassetsdetails);
	}

	public List findByIotherloanssecured(Object iotherloanssecured) {
		return findByProperty(IOTHERLOANSSECURED, iotherloanssecured);
	}

	public List findByIloansresidentialproperty(Object iloansresidentialproperty) {
		return findByProperty(ILOANSRESIDENTIALPROPERTY, iloansresidentialproperty);
	}

	public List findByIloansinvestmentproperty(Object iloansinvestmentproperty) {
		return findByProperty(ILOANSINVESTMENTPROPERTY, iloansinvestmentproperty);
	}

	public List findByIloanspersonalunsecured(Object iloanspersonalunsecured) {
		return findByProperty(ILOANSPERSONALUNSECURED, iloanspersonalunsecured);
	}

	public List findByIguaranteesgranted(Object iguaranteesgranted) {
		return findByProperty(IGUARANTEESGRANTED, iguaranteesgranted);
	}

	public List findByIotherliabilities(Object iotherliabilities) {
		return findByProperty(IOTHERLIABILITIES, iotherliabilities);
	}

	public List findByIotherliabilitiesdetails(Object iotherliabilitiesdetails) {
		return findByProperty(IOTHERLIABILITIESDETAILS, iotherliabilitiesdetails);
	}

	public List findByIsalary(Object isalary) {
		return findByProperty(ISALARY, isalary);
	}

	public List findByIrentalanddividend(Object irentalanddividend) {
		return findByProperty(IRENTALANDDIVIDEND, irentalanddividend);
	}

	public List findByIotherincome(Object iotherincome) {
		return findByProperty(IOTHERINCOME, iotherincome);
	}

	public List findByIotherincomedetails(Object iotherincomedetails) {
		return findByProperty(IOTHERINCOMEDETAILS, iotherincomedetails);
	}

	public List findByItaxpayable(Object itaxpayable) {
		return findByProperty(ITAXPAYABLE, itaxpayable);
	}

	public List findByIinterestonsecuredloans(Object iinterestonsecuredloans) {
		return findByProperty(IINTERESTONSECUREDLOANS, iinterestonsecuredloans);
	}

	public List findByIinterestonunsecuredloans(Object iinterestonunsecuredloans) {
		return findByProperty(IINTERESTONUNSECUREDLOANS, iinterestonunsecuredloans);
	}

	public List findByIlivingexpenses(Object ilivingexpenses) {
		return findByProperty(ILIVINGEXPENSES, ilivingexpenses);
	}

	public List findByIotherexpenses(Object iotherexpenses) {
		return findByProperty(IOTHEREXPENSES, iotherexpenses);
	}

	public List findByIotherexpensesdetails(Object iotherexpensesdetails) {
		return findByProperty(IOTHEREXPENSESDETAILS, iotherexpensesdetails);
	}

	public List findByGcash(Object gcash) {
		return findByProperty(GCASH, gcash);
	}

	public List findByGshares(Object gshares) {
		return findByProperty(GSHARES, gshares);
	}

	public List findByGotherliquid(Object gotherliquid) {
		return findByProperty(GOTHERLIQUID, gotherliquid);
	}

	public List findByGresidentialproperty(Object gresidentialproperty) {
		return findByProperty(GRESIDENTIALPROPERTY, gresidentialproperty);
	}

	public List findByGinvestmentproperty(Object ginvestmentproperty) {
		return findByProperty(GINVESTMENTPROPERTY, ginvestmentproperty);
	}

	public List findByGotherassets(Object gotherassets) {
		return findByProperty(GOTHERASSETS, gotherassets);
	}

	public List findByGotherassetsdetails(Object gotherassetsdetails) {
		return findByProperty(GOTHERASSETSDETAILS, gotherassetsdetails);
	}

	public List findByGotherloanssecured(Object gotherloanssecured) {
		return findByProperty(GOTHERLOANSSECURED, gotherloanssecured);
	}

	public List findByGloansresidentialproperty(Object gloansresidentialproperty) {
		return findByProperty(GLOANSRESIDENTIALPROPERTY, gloansresidentialproperty);
	}

	public List findByGloansinvestmentproperty(Object gloansinvestmentproperty) {
		return findByProperty(GLOANSINVESTMENTPROPERTY, gloansinvestmentproperty);
	}

	public List findByGloanspersonalunsecured(Object gloanspersonalunsecured) {
		return findByProperty(GLOANSPERSONALUNSECURED, gloanspersonalunsecured);
	}

	public List findByGguaranteesgranted(Object gguaranteesgranted) {
		return findByProperty(GGUARANTEESGRANTED, gguaranteesgranted);
	}

	public List findByGotherliabilities(Object gotherliabilities) {
		return findByProperty(GOTHERLIABILITIES, gotherliabilities);
	}

	public List findByGotherliabilitiesdetails(Object gotherliabilitiesdetails) {
		return findByProperty(GOTHERLIABILITIESDETAILS, gotherliabilitiesdetails);
	}

	public List findByGsalary(Object gsalary) {
		return findByProperty(GSALARY, gsalary);
	}

	public List findByGrentalanddividend(Object grentalanddividend) {
		return findByProperty(GRENTALANDDIVIDEND, grentalanddividend);
	}

	public List findByGotherincome(Object gotherincome) {
		return findByProperty(GOTHERINCOME, gotherincome);
	}

	public List findByGotherincomedetails(Object gotherincomedetails) {
		return findByProperty(GOTHERINCOMEDETAILS, gotherincomedetails);
	}

	public List findByGtaxpayable(Object gtaxpayable) {
		return findByProperty(GTAXPAYABLE, gtaxpayable);
	}

	public List findByGinterestonsecuredloans(Object ginterestonsecuredloans) {
		return findByProperty(GINTERESTONSECUREDLOANS, ginterestonsecuredloans);
	}

	public List findByGinterestonunsecuredloans(Object ginterestonunsecuredloans) {
		return findByProperty(GINTERESTONUNSECUREDLOANS, ginterestonunsecuredloans);
	}

	public List findByGlivingexpenses(Object glivingexpenses) {
		return findByProperty(GLIVINGEXPENSES, glivingexpenses);
	}

	public List findByGotherexpenses(Object gotherexpenses) {
		return findByProperty(GOTHEREXPENSES, gotherexpenses);
	}

	public List findByGotherexpensesdetails(Object gotherexpensesdetails) {
		return findByProperty(GOTHEREXPENSESDETAILS, gotherexpensesdetails);
	}

	public List findByOnboardingstatus(Object onboardingstatus) {
		return findByProperty(ONBOARDINGSTATUS, onboardingstatus);
	}

	public List findByOnboardinglastuser(Object onboardinglastuser) {
		return findByProperty(ONBOARDINGLASTUSER, onboardinglastuser);
	}

	public List findByOnboardingcomments(Object onboardingcomments) {
		return findByProperty(ONBOARDINGCOMMENTS, onboardingcomments);
	}

	public List findByOnboardinghardcopysighted(Object onboardinghardcopysighted) {
		return findByProperty(ONBOARDINGHARDCOPYSIGHTED, onboardinghardcopysighted);
	}

	public List findByDadealergroup(Object dadealergroup) {
		return findByProperty(DADEALERGROUP, dadealergroup);
	}

	public List findByCreditstatus(Object creditstatus) {
		return findByProperty(CREDITSTATUS, creditstatus);
	}

	public List findByCreditlastuser(Object creditlastuser) {
		return findByProperty(CREDITLASTUSER, creditlastuser);
	}

	public List findByCreditcomments(Object creditcomments) {
		return findByProperty(CREDITCOMMENTS, creditcomments);
	}

	public List findByCasapproved(Object casapproved) {
		return findByProperty(CASAPPROVED, casapproved);
	}

	public List findByBaycorpsapproved(Object baycorpsapproved) {
		return findByProperty(BAYCORPSAPPROVED, baycorpsapproved);
	}

	public List findByAmlstatus(Object amlstatus) {
		return findByProperty(AMLSTATUS, amlstatus);
	}

	public List findByAmllastuser(Object amllastuser) {
		return findByProperty(AMLLASTUSER, amllastuser);
	}

	public List findByAmlcomments(Object amlcomments) {
		return findByProperty(AMLCOMMENTS, amlcomments);
	}

	public List findByAmlhardcopysighted(Object amlhardcopysighted) {
		return findByProperty(AMLHARDCOPYSIGHTED, amlhardcopysighted);
	}

	public List findByCreditcheckverified(Object creditcheckverified) {
		return findByProperty(CREDITCHECKVERIFIED, creditcheckverified);
	}

	public List findByGridcheckverified(Object gridcheckverified) {
		return findByProperty(GRIDCHECKVERIFIED, gridcheckverified);
	}

	public List findByWorldcheckverified(Object worldcheckverified) {
		return findByProperty(WORLDCHECKVERIFIED, worldcheckverified);
	}

	public List findByGooglecheckverified(Object googlecheckverified) {
		return findByProperty(GOOGLECHECKVERIFIED, googlecheckverified);
	}

	public List findByCorporatechecksverified(Object corporatechecksverified) {
		return findByProperty(CORPORATECHECKSVERIFIED, corporatechecksverified);
	}

	public List findByTrustchecksverified(Object trustchecksverified) {
		return findByProperty(TRUSTCHECKSVERIFIED, trustchecksverified);
	}

	public List findByOperationscomments(Object operationscomments) {
		return findByProperty(OPERATIONSCOMMENTS, operationscomments);
	}

	public List findByBank3rdpartyauthorisation(Object bank3rdpartyauthorisation) {
		return findByProperty(BANK3RDPARTYAUTHORISATION, bank3rdpartyauthorisation);
	}

	public List findByBillingapproved(Object billingapproved) {
		return findByProperty(BILLINGAPPROVED, billingapproved);
	}

	public List findByReconciledbillingdata(Object reconciledbillingdata) {
		return findByProperty(RECONCILEDBILLINGDATA, reconciledbillingdata);
	}

	public List findByGeneratedbillingdata(Object generatedbillingdata) {
		return findByProperty(GENERATEDBILLINGDATA, generatedbillingdata);
	}

	public List findByAmountduepaid(Object amountduepaid) {
		return findByProperty(AMOUNTDUEPAID, amountduepaid);
	}

	public List findByDdpaymentsuccessful(Object ddpaymentsuccessful) {
		return findByProperty(DDPAYMENTSUCCESSFUL, ddpaymentsuccessful);
	}

	public List findByDdunsuccessfulreason(Object ddunsuccessfulreason) {
		return findByProperty(DDUNSUCCESSFULREASON, ddunsuccessfulreason);
	}

	public List findByInitialpaymentbycheque(Object initialpaymentbycheque) {
		return findByProperty(INITIALPAYMENTBYCHEQUE, initialpaymentbycheque);
	}

	public List findByPaymentbyalternativemeans(Object paymentbyalternativemeans) {
		return findByProperty(PAYMENTBYALTERNATIVEMEANS, paymentbyalternativemeans);
	}

	public List findByConductedbilling(Object conductedbilling) {
		return findByProperty(CONDUCTEDBILLING, conductedbilling);
	}

	public List findByGeneratedapprovalletter(Object generatedapprovalletter) {
		return findByProperty(GENERATEDAPPROVALLETTER, generatedapprovalletter);
	}

	public List findByGeneratedrejectionletter(Object generatedrejectionletter) {
		return findByProperty(GENERATEDREJECTIONLETTER, generatedrejectionletter);
	}

	public List findByAdministrationcomments(Object administrationcomments) {
		return findByProperty(ADMINISTRATIONCOMMENTS, administrationcomments);
	}

	public List findByOnboardinginfo1satisfied(Object onboardinginfo1satisfied) {
		return findByProperty(ONBOARDINGINFO1SATISFIED, onboardinginfo1satisfied);
	}

	public List findByOnboardinginfo1commentary(Object onboardinginfo1commentary) {
		return findByProperty(ONBOARDINGINFO1COMMENTARY, onboardinginfo1commentary);
	}

	public List findByOnboardinginfo2satisfied(Object onboardinginfo2satisfied) {
		return findByProperty(ONBOARDINGINFO2SATISFIED, onboardinginfo2satisfied);
	}

	public List findByOnboardinginfo2commentary(Object onboardinginfo2commentary) {
		return findByProperty(ONBOARDINGINFO2COMMENTARY, onboardinginfo2commentary);
	}

	public List findByOnboardinginfo3satisfied(Object onboardinginfo3satisfied) {
		return findByProperty(ONBOARDINGINFO3SATISFIED, onboardinginfo3satisfied);
	}

	public List findByOnboardinginfo3commentary(Object onboardinginfo3commentary) {
		return findByProperty(ONBOARDINGINFO3COMMENTARY, onboardinginfo3commentary);
	}

	public List findByCreditinfo1satisfied(Object creditinfo1satisfied) {
		return findByProperty(CREDITINFO1SATISFIED, creditinfo1satisfied);
	}

	public List findByCreditinfo1commentary(Object creditinfo1commentary) {
		return findByProperty(CREDITINFO1COMMENTARY, creditinfo1commentary);
	}

	public List findByCreditinfo2satisfied(Object creditinfo2satisfied) {
		return findByProperty(CREDITINFO2SATISFIED, creditinfo2satisfied);
	}

	public List findByCreditinfo2commentary(Object creditinfo2commentary) {
		return findByProperty(CREDITINFO2COMMENTARY, creditinfo2commentary);
	}

	public List findByCreditinfo3satisfied(Object creditinfo3satisfied) {
		return findByProperty(CREDITINFO3SATISFIED, creditinfo3satisfied);
	}

	public List findByCreditinfo3commentary(Object creditinfo3commentary) {
		return findByProperty(CREDITINFO3COMMENTARY, creditinfo3commentary);
	}

	public List findByAmlinfo1satisfied(Object amlinfo1satisfied) {
		return findByProperty(AMLINFO1SATISFIED, amlinfo1satisfied);
	}

	public List findByAmlinfo1commentary(Object amlinfo1commentary) {
		return findByProperty(AMLINFO1COMMENTARY, amlinfo1commentary);
	}

	public List findByAmlinfo2satisfied(Object amlinfo2satisfied) {
		return findByProperty(AMLINFO2SATISFIED, amlinfo2satisfied);
	}

	public List findByAmlinfo2commentary(Object amlinfo2commentary) {
		return findByProperty(AMLINFO2COMMENTARY, amlinfo2commentary);
	}

	public List findByAmlinfo3satisfied(Object amlinfo3satisfied) {
		return findByProperty(AMLINFO3SATISFIED, amlinfo3satisfied);
	}

	public List findByAmlinfo3commentary(Object amlinfo3commentary) {
		return findByProperty(AMLINFO3COMMENTARY, amlinfo3commentary);
	}

	public List findByOnboardinginfonotyetchecked(Object onboardinginfonotyetchecked) {
		return findByProperty(ONBOARDINGINFONOTYETCHECKED, onboardinginfonotyetchecked);
	}

	public List findByCreditinfonotyetchecked(Object creditinfonotyetchecked) {
		return findByProperty(CREDITINFONOTYETCHECKED, creditinfonotyetchecked);
	}

	public List findByAmlinfonotyetchecked(Object amlinfonotyetchecked) {
		return findByProperty(AMLINFONOTYETCHECKED, amlinfonotyetchecked);
	}

	public List findByBaycorprecordcreated(Object baycorprecordcreated) {
		return findByProperty(BAYCORPRECORDCREATED, baycorprecordcreated);
	}

	public List findByAsiccompanysearch(Object asiccompanysearch) {
		return findByProperty(ASICCOMPANYSEARCH, asiccompanysearch);
	}

	public List findByAtoregistration(Object atoregistration) {
		return findByProperty(ATOREGISTRATION, atoregistration);
	}

	public List findByTrustdeedapproved(Object trustdeedapproved) {
		return findByProperty(TRUSTDEEDAPPROVED, trustdeedapproved);
	}

	public List findByApplicant1approved(Object applicant1approved) {
		return findByProperty(APPLICANT1APPROVED, applicant1approved);
	}

	public List findByApplicant1material(Object applicant1material) {
		return findByProperty(APPLICANT1MATERIAL, applicant1material);
	}

	public List findByApplicant1immaterial(Object applicant1immaterial) {
		return findByProperty(APPLICANT1IMMATERIAL, applicant1immaterial);
	}

	public List findByApplicant1nohit(Object applicant1nohit) {
		return findByProperty(APPLICANT1NOHIT, applicant1nohit);
	}

	public List findByApplicant1notapplicable(Object applicant1notapplicable) {
		return findByProperty(APPLICANT1NOTAPPLICABLE, applicant1notapplicable);
	}

	public List findByApplicant2approved(Object applicant2approved) {
		return findByProperty(APPLICANT2APPROVED, applicant2approved);
	}

	public List findByApplicant2material(Object applicant2material) {
		return findByProperty(APPLICANT2MATERIAL, applicant2material);
	}

	public List findByApplicant2immaterial(Object applicant2immaterial) {
		return findByProperty(APPLICANT2IMMATERIAL, applicant2immaterial);
	}

	public List findByApplicant2nohit(Object applicant2nohit) {
		return findByProperty(APPLICANT2NOHIT, applicant2nohit);
	}

	public List findByApplicant2notapplicable(Object applicant2notapplicable) {
		return findByProperty(APPLICANT2NOTAPPLICABLE, applicant2notapplicable);
	}

	public List findByCompanyapproved(Object companyapproved) {
		return findByProperty(COMPANYAPPROVED, companyapproved);
	}

	public List findByCompanymaterial(Object companymaterial) {
		return findByProperty(COMPANYMATERIAL, companymaterial);
	}

	public List findByCompanyimmaterial(Object companyimmaterial) {
		return findByProperty(COMPANYIMMATERIAL, companyimmaterial);
	}

	public List findByCompanynohit(Object companynohit) {
		return findByProperty(COMPANYNOHIT, companynohit);
	}

	public List findByCompanynotapplicable(Object companynotapplicable) {
		return findByProperty(COMPANYNOTAPPLICABLE, companynotapplicable);
	}

	public List findByOtherpersonsapproved(Object otherpersonsapproved) {
		return findByProperty(OTHERPERSONSAPPROVED, otherpersonsapproved);
	}

	public List findByOtherpersonsmaterial(Object otherpersonsmaterial) {
		return findByProperty(OTHERPERSONSMATERIAL, otherpersonsmaterial);
	}

	public List findByOtherpersonsimmaterial(Object otherpersonsimmaterial) {
		return findByProperty(OTHERPERSONSIMMATERIAL, otherpersonsimmaterial);
	}

	public List findByOtherpersonsnohit(Object otherpersonsnohit) {
		return findByProperty(OTHERPERSONSNOHIT, otherpersonsnohit);
	}

	public List findByOtherpersonsnotapplicable(Object otherpersonsnotapplicable) {
		return findByProperty(OTHERPERSONSNOTAPPLICABLE, otherpersonsnotapplicable);
	}

	public List findByApplicationwithdrawn(Object applicationwithdrawn) {
		return findByProperty(APPLICATIONWITHDRAWN, applicationwithdrawn);
	}

	public List findByApplicationdeleted(Object applicationdeleted) {
		return findByProperty(APPLICATIONDELETED, applicationdeleted);
	}

	public List findByBaycorp1filecreated(Object baycorp1filecreated) {
		return findByProperty(BAYCORP1FILECREATED, baycorp1filecreated);
	}

	public List findByGridcheck1approved(Object gridcheck1approved) {
		return findByProperty(GRIDCHECK1APPROVED, gridcheck1approved);
	}

	public List findByWorldcheck1approved(Object worldcheck1approved) {
		return findByProperty(WORLDCHECK1APPROVED, worldcheck1approved);
	}

	public List findByGooglecheck1approved(Object googlecheck1approved) {
		return findByProperty(GOOGLECHECK1APPROVED, googlecheck1approved);
	}

	public List findByAsicdirector1check(Object asicdirector1check) {
		return findByProperty(ASICDIRECTOR1CHECK, asicdirector1check);
	}

	public List findByAsicbeneficiary1check(Object asicbeneficiary1check) {
		return findByProperty(ASICBENEFICIARY1CHECK, asicbeneficiary1check);
	}

	public List findByBaycorp2filecreated(Object baycorp2filecreated) {
		return findByProperty(BAYCORP2FILECREATED, baycorp2filecreated);
	}

	public List findByGridcheck2approved(Object gridcheck2approved) {
		return findByProperty(GRIDCHECK2APPROVED, gridcheck2approved);
	}

	public List findByWorldcheck2approved(Object worldcheck2approved) {
		return findByProperty(WORLDCHECK2APPROVED, worldcheck2approved);
	}

	public List findByGooglecheck2approved(Object googlecheck2approved) {
		return findByProperty(GOOGLECHECK2APPROVED, googlecheck2approved);
	}

	public List findByAsicdirector2check(Object asicdirector2check) {
		return findByProperty(ASICDIRECTOR2CHECK, asicdirector2check);
	}

	public List findByAsicbeneficiary2check(Object asicbeneficiary2check) {
		return findByProperty(ASICBENEFICIARY2CHECK, asicbeneficiary2check);
	}

	public List findBySuperfundregistrationcheck(Object superfundregistrationcheck) {
		return findByProperty(SUPERFUNDREGISTRATIONCHECK, superfundregistrationcheck);
	}

	public List findByOnboardinglock(Object onboardinglock) {
		return findByProperty(ONBOARDINGLOCK, onboardinglock);
	}

	public List findByCreditlock(Object creditlock) {
		return findByProperty(CREDITLOCK, creditlock);
	}

	public List findByAmllock(Object amllock) {
		return findByProperty(AMLLOCK, amllock);
	}

	public List findByMainlock(Object mainlock) {
		return findByProperty(MAINLOCK, mainlock);
	}

	public List findByCreatedby(Object createdby) {
		return findByProperty(CREATEDBY, createdby);
	}

	public List findByModifiedby(Object modifiedby) {
		return findByProperty(MODIFIEDBY, modifiedby);
	}

	public List findByChequeforubsattached(Object chequeforubsattached) {
		return findByProperty(CHEQUEFORUBSATTACHED, chequeforubsattached);
	}

	public List findByChequeamount(Object chequeamount) {
		return findByProperty(CHEQUEAMOUNT, chequeamount);
	}

	public List findByChequereturned(Object chequereturned) {
		return findByProperty(CHEQUERETURNED, chequereturned);
	}

	public List findByChequeaccepted(Object chequeaccepted) {
		return findByProperty(CHEQUEACCEPTED, chequeaccepted);
	}

	public List findByIsreferredtocrc(Object isreferredtocrc) {
		return findByProperty(ISREFERREDTOCRC, isreferredtocrc);
	}

	public List findByFirstddstatusfailed(Object firstddstatusfailed) {
		return findByProperty(FIRSTDDSTATUSFAILED, firstddstatusfailed);
	}

	public List findByFirstddstatussucceeded(Object firstddstatussucceeded) {
		return findByProperty(FIRSTDDSTATUSSUCCEEDED, firstddstatussucceeded);
	}

	public List findByIsseconddd(Object isseconddd) {
		return findByProperty(ISSECONDDD, isseconddd);
	}

	public List findBySecondddstatusfailed(Object secondddstatusfailed) {
		return findByProperty(SECONDDDSTATUSFAILED, secondddstatusfailed);
	}

	public List findBySecondddstatussucceeded(Object secondddstatussucceeded) {
		return findByProperty(SECONDDDSTATUSSUCCEEDED, secondddstatussucceeded);
	}

	public List findByIsbpay(Object isbpay) {
		return findByProperty(ISBPAY, isbpay);
	}

	public List findByBpayreference(Object bpayreference) {
		return findByProperty(BPAYREFERENCE, bpayreference);
	}

	public List findByBpaystatusfailed(Object bpaystatusfailed) {
		return findByProperty(BPAYSTATUSFAILED, bpaystatusfailed);
	}

	public List findByBpaystatussucceeded(Object bpaystatussucceeded) {
		return findByProperty(BPAYSTATUSSUCCEEDED, bpaystatussucceeded);
	}

	public List findByIsdirectcredit(Object isdirectcredit) {
		return findByProperty(ISDIRECTCREDIT, isdirectcredit);
	}

	public List findByDirectcreditstatusfailed(Object directcreditstatusfailed) {
		return findByProperty(DIRECTCREDITSTATUSFAILED, directcreditstatusfailed);
	}

	public List findByDirectcreditstatussucceeded(Object directcreditstatussucceeded) {
		return findByProperty(DIRECTCREDITSTATUSSUCCEEDED, directcreditstatussucceeded);
	}

	public List findByOpsissueraisedticked(Object opsissueraisedticked) {
		return findByProperty(OPSISSUERAISEDTICKED, opsissueraisedticked);
	}

	public List findByOpsissueraiseduserid(Object opsissueraiseduserid) {
		return findByProperty(OPSISSUERAISEDUSERID, opsissueraiseduserid);
	}

	public List findByOpsissueresolvedticked(Object opsissueresolvedticked) {
		return findByProperty(OPSISSUERESOLVEDTICKED, opsissueresolvedticked);
	}

	public List findByOpsissueresolveduserid(Object opsissueresolveduserid) {
		return findByProperty(OPSISSUERESOLVEDUSERID, opsissueresolveduserid);
	}

	public List findByOperationscomments1(Object operationscomments1) {
		return findByProperty(OPERATIONSCOMMENTS1, operationscomments1);
	}

	public List findByOperationscomments2(Object operationscomments2) {
		return findByProperty(OPERATIONSCOMMENTS2, operationscomments2);
	}

	public List findByOperationscomments3(Object operationscomments3) {
		return findByProperty(OPERATIONSCOMMENTS3, operationscomments3);
	}

	public List findByOperationscomments4(Object operationscomments4) {
		return findByProperty(OPERATIONSCOMMENTS4, operationscomments4);
	}

	public List findByOperationscomments5(Object operationscomments5) {
		return findByProperty(OPERATIONSCOMMENTS5, operationscomments5);
	}

	public List findByOperationscomments6(Object operationscomments6) {
		return findByProperty(OPERATIONSCOMMENTS6, operationscomments6);
	}

	public List findByOperationscomments7(Object operationscomments7) {
		return findByProperty(OPERATIONSCOMMENTS7, operationscomments7);
	}

	public List findByOperationscomments8(Object operationscomments8) {
		return findByProperty(OPERATIONSCOMMENTS8, operationscomments8);
	}

	public List findByOperationscomments9(Object operationscomments9) {
		return findByProperty(OPERATIONSCOMMENTS9, operationscomments9);
	}

	public List findByOperationslastuser(Object operationslastuser) {
		return findByProperty(OPERATIONSLASTUSER, operationslastuser);
	}

	public List findByAdministrationlastuser(Object administrationlastuser) {
		return findByProperty(ADMINISTRATIONLASTUSER, administrationlastuser);
	}

	public List findByMasterlastuser(Object masterlastuser) {
		return findByProperty(MASTERLASTUSER, masterlastuser);
	}

	public List findByAmountdue(Object amountdue) {
		return findByProperty(AMOUNTDUE, amountdue);
	}

	public List findByNewamountdue(Object newamountdue) {
		return findByProperty(NEWAMOUNTDUE, newamountdue);
	}

	public List findByAdviserbonafideschecked(Object adviserbonafideschecked) {
		return findByProperty(ADVISERBONAFIDESCHECKED, adviserbonafideschecked);
	}

	public List findByAutomaticdirectdebitsuppressed(Object automaticdirectdebitsuppressed) {
		return findByProperty(AUTOMATICDIRECTDEBITSUPPRESSED, automaticdirectdebitsuppressed);
	}

	public List findByFirstamountreceived(Object firstamountreceived) {
		return findByProperty(FIRSTAMOUNTRECEIVED, firstamountreceived);
	}

	public List findByAmendedpaymentamount(Object amendedpaymentamount) {
		return findByProperty(AMENDEDPAYMENTAMOUNT, amendedpaymentamount);
	}

	public List findByInhouseamount(Object inhouseamount) {
		return findByProperty(INHOUSEAMOUNT, inhouseamount);
	}

    public Application merge(Application detachedInstance) {
        log.debug("merging Application instance");
        try {
            Application result = (Application) getHibernateTemplate()
                    .merge(detachedInstance);
            log.debug("merge successful");
            return result;
        } catch (RuntimeException re) {
            log.error("merge failed", re);
            throw re;
        }
    }

    public void attachDirty(Application instance) {
        log.debug("attaching dirty Application instance");
        try {
            getHibernateTemplate().saveOrUpdate(instance);
            log.debug("attach successful");
        } catch (RuntimeException re) {
            log.error("attach failed", re);
            throw re;
        }
    }

    public void attachClean(Application instance) {
        log.debug("attaching clean Application instance");
        try {
            getHibernateTemplate().lock(instance, LockMode.NONE);
            log.debug("attach successful");
        } catch (RuntimeException re) {
            log.error("attach failed", re);
            throw re;
        }
    }

	public static ApplicationDAO getFromApplicationContext(ApplicationContext ctx) {
    	return (ApplicationDAO) ctx.getBean("ApplicationDAO");
	}

  public void refresh(Application application) {
    if (!super.getSession().isDirty()) {
      super.getHibernateTemplate().refresh(application);
    }
  }

  /**
   * Loads ORM dependencies needed to use the application object on the
   * front end.
   * 
   * @param application The application.
   */
  public Application findApplicationByIdWithDependencies(Long applicationId) {
    DetachedCriteria criteria = DetachedCriteria.forClass(Application.class);
    criteria.add(Restrictions.idEq(applicationId));
    criteria.setFetchMode("investorindividuals", FetchMode.JOIN);
    criteria.setFetchMode("company", FetchMode.JOIN);
    criteria.setFetchMode("trust", FetchMode.JOIN);
    criteria.setFetchMode("trust.companyByCompanyid", FetchMode.JOIN);
    criteria.setFetchMode("trust.companyBySolicitorcompanyid", FetchMode.JOIN);
    criteria.setFetchMode("directCreditDetails", FetchMode.JOIN);
    
    List applications = super.getHibernateTemplate().findByCriteria(criteria);
    
    Application application;
    if (applications.size() > 0) {
      if (applications.size() > 1) {
        logger.error("More than 1 application found with id " + applicationId 
            + ".  Using first value ...");
      }
      
      application = (Application) applications.iterator().next();
    } else {
      application = null;
    }
    
    return application;
  }

  public void updateDirectCreditDetails(Application application) {
    super.getHibernateTemplate().saveOrUpdate(application.getDirectCreditDetails());
  }
}