package org.opi.domain;

import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import org.apache.commons.lang3.StringUtils;

/**
 * Domain model for an individiual entity.
 * 
 * @author Paul McLachlan
 * @author Ana Velez
 */
@SuppressWarnings("serial")
public class Individual implements Serializable, Cloneable, Comparable<Individual> {
  //~ Constructors -------------------------------------------------------------

  /** default constructor */
  public Individual() { }

  //~ Methods ------------------------------------------------------------------
  
  /**
   * Compares the likeliness that two individual objects represent the same
   * person.
   * 
   * Due to legal reasons, we cannot compare TFNs and hence really have no 
   * source of truth to say that two individuals are equal.
   */
  public int compareTo(Individual individual) {
    Individual i1 = this;
    Individual i2 = individual;
    
    // The degreeOfDifference increases in value everytime one of the
    // needed constraints don't match, making it go further away from "0".
    // Note that we start at 1 since starting at 0 would imply that if all
    // the below contraints match then the individuals are "equal", which 
    // isn't true.  They're just very similary.
    int degreeOfDifference = 1;
    
    // 1 - initial of firstname
    if (!(!StringUtils.isBlank(i1.firstname) && 
          !StringUtils.isBlank(i2.firstname) && 
          StringUtils.equalsIgnoreCase(i1.firstname.substring(0, 1), 
                                       i2.firstname.substring(0, 1)))) {
      ++degreeOfDifference;
    }
    
    // 2 - surname
    if (!equalsIgnoreCaseAndNotEmpty(i1.lastname, i2.lastname)) {
      ++degreeOfDifference;
    }
    
    // 3 - date of birth
    if (!(i1.dateofbirth != null && i2.dateofbirth != null && i1.dateofbirth.equals(i2.dateofbirth))) {
      ++degreeOfDifference;
    }
    
    // 4 - town of birth
    if (!equalsAndNotEmpty(i1.townofbirth, i2.townofbirth)) {
      ++degreeOfDifference;
    }

    // 5 - country of birth
    if (!equalsAndNotEmpty(i1.countryofbirth, i2.countryofbirth)) {
      ++degreeOfDifference;
    }
    
    // 6 - driver's licence number
    if (!equalsAndNotEmpty(i1.driverslicenceno, i2.driverslicenceno)) {
      ++degreeOfDifference;
    }
    
    return degreeOfDifference; 
  }
  
  private static boolean equalsAndNotEmpty(String s1, String s2) {
    return s1 != null && s2 != null && !StringUtils.isBlank(s1) && !StringUtils.isBlank(s2) && StringUtils.equals(s1, s2);
  }
  
  private static boolean equalsIgnoreCaseAndNotEmpty(String s1, String s2) {
    return s1 != null && s2 != null && !StringUtils.isBlank(s1) && !StringUtils.isBlank(s2) && StringUtils.equalsIgnoreCase(s1, s2);
  }
  
  public Individual clone() {
    Individual individual = new Individual();
    
    individual.title = title;
    individual.firstname = firstname;
    individual.middlename = middlename;
    individual.lastname = lastname;
    individual.address1 = address1;
    individual.address2 = address2;
    individual.suburb = suburb;
    individual.state = state;
    individual.postcode = postcode;
    individual.country = country;
    individual.tfn = tfn;
    individual.abn = abn;
    individual.homephone = homephone;
    individual.workphone = workphone;
    individual.mobilephone = mobilephone;
    individual.personalfax = personalfax;
    individual.workfax = workfax;
    individual.personalemail = personalemail;
    individual.workemail = workemail;
    individual.dateofbirth = dateofbirth;
    individual.townofbirth = townofbirth;
    individual.countryofbirth = countryofbirth;
    individual.passportno = passportno;
    individual.nationality = nationality;
    individual.driverslicenceno = driverslicenceno;
    individual.occupation = occupation;
    individual.employer = employer;
    individual.advisors = advisors;
    
    return individual;
  }
  
  /**
   * Checks if this is a new individual (ie - it hasn't been persisted yet).
   * 
   * @return <code>true</code> or <code>false</code>. 
   */
  public boolean isNew() {
    return this.id == null;
  }
  
  /**
   * Added by paulmac.  Returns the full name of the individual.
   * 
   * Modified by Gav to handle null values.
   *  
   * @return The individual's full name.
   */ 
  public String getFullname() {
    return StringUtils.trim(this.lastname) + ", " + StringUtils.trim(this.firstname);
  }

  public Long getId() {
    return this.id;
  }

  public void setId(Long id) {
    this.id = id;
  }

  public Users getUsers() {
    return this.users;
  }

  public void setUsers(Users users) {
    this.users = users;
  }

  public String getTitle() {
    return this.title;
  }

  public void setTitle(String title) {
    this.title = title;
  }

  public String getFirstname() {
    return this.firstname;
  }

  public void setFirstname(String firstname) {
    this.firstname = firstname;
  }

  public String getMiddlename() {
    return this.middlename;
  }

  public void setMiddlename(String middlename) {
    this.middlename = middlename;
  }

  public String getLastname() {
    return this.lastname;
  }

  public void setLastname(String lastname) {
    this.lastname = lastname;
  }

  public String getAddress1() {
    return this.address1;
  }

  public void setAddress1(String address1) {
    this.address1 = address1;
  }

  public String getSuburb() {
    return this.suburb;
  }

  public void setSuburb(String suburb) {
    this.suburb = suburb;
  }

  public String getState() {
    return this.state;
  }

  public void setState(String state) {
    this.state = state;
  }

  public String getPostcode() {
    return this.postcode;
  }

  public void setPostcode(String postcode) {
    this.postcode = postcode;
  }

  public String getCountry() {
    return this.country;
  }

  public void setCountry(String country) {
    this.country = country;
  }

  public String getTfn() {
    return this.tfn;
  }

  public void setTfn(String tfn) {
    this.tfn = tfn;
  }

  public String getAbn() {
    return this.abn;
  }

  public void setAbn(String abn) {
    this.abn = abn;
  }

  public String getHomephone() {
    return this.homephone;
  }

  public void setHomephone(String homephone) {
    this.homephone = homephone;
  }

  public String getWorkphone() {
    return this.workphone;
  }

  public void setWorkphone(String workphone) {
    this.workphone = workphone;
  }

  public String getMobilephone() {
    return this.mobilephone;
  }

  public void setMobilephone(String mobilephone) {
    this.mobilephone = mobilephone;
  }

  public String getPersonalfax() {
    return this.personalfax;
  }

  public void setPersonalfax(String personalfax) {
    this.personalfax = personalfax;
  }

  public String getWorkfax() {
    return this.workfax;
  }

  public void setWorkfax(String workfax) {
    this.workfax = workfax;
  }

  public String getPersonalemail() {
    return this.personalemail;
  }

  public void setPersonalemail(String personalemail) {
    this.personalemail = personalemail;
  }

  public String getWorkemail() {
    return this.workemail;
  }

  public void setWorkemail(String workemail) {
    this.workemail = workemail;
  }

  public Date getDateofbirth() {
    return this.dateofbirth;
  }

  public void setDateofbirth(Date dateofbirth) {
    this.dateofbirth = dateofbirth;
  }

  public String getTownofbirth() {
    return this.townofbirth;
  }

  public void setTownofbirth(String townofbirth) {
    this.townofbirth = townofbirth;
  }

  public String getCountryofbirth() {
    return this.countryofbirth;
  }

  public void setCountryofbirth(String countryofbirth) {
    this.countryofbirth = countryofbirth;
  }

  public String getPassportno() {
    return this.passportno;
  }

  public void setPassportno(String passportno) {
    this.passportno = passportno;
  }

  public String getNationality() {
    return this.nationality;
  }

  public void setNationality(String nationality) {
    this.nationality = nationality;
  }

  public String getDriverslicenceno() {
    return this.driverslicenceno;
  }

  public void setDriverslicenceno(String driverslicenceno) {
    this.driverslicenceno = driverslicenceno;
  }

  public String getOccupation() {
    return this.occupation;
  }

  public void setOccupation(String occupation) {
    this.occupation = occupation;
  }

  public String getEmployer() {
    return this.employer;
  }

  public void setEmployer(String employer) {
    this.employer = employer;
  }

  public Set<Advisor> getAdvisors() {
    return this.advisors;
  }

  public void setAdvisors(Set<Advisor> advisors) {
    this.advisors = advisors;
  }

  public Set<Investorindividual> getInvestorindividuals() {
    return this.investorindividuals;
  }

  public void setInvestorindividuals(Set<Investorindividual> investorindividuals) {
    this.investorindividuals = investorindividuals;
  }

  public Investorindividual getTransInvestorindividual() {
    return transInvestorindividual;
  }

  public void setTransInvestorindividual(Investorindividual transInvestorindividual) {
    this.transInvestorindividual = transInvestorindividual;
  }

  public String getAddress2() {
    return address2;
  }

  public void setAddress2(String address2) {
    this.address2 = address2;
  }

  //~ Instance fields ----------------------------------------------------------

  private Investorindividual transInvestorindividual;

  // Fields
  private Long id;
  private Users users;
  private String title;
  private String firstname;
  private String middlename;
  private String lastname;
  private String address1;
  private String address2;
  private String suburb;
  private String state;
  private String postcode;
  private String country;
  private String tfn;
  private String abn;
  private String homephone;
  private String workphone;
  private String mobilephone;
  private String personalfax;
  private String workfax;
  private String personalemail;
  private String workemail;
  private Date dateofbirth;
  private String townofbirth;
  private String countryofbirth;
  private String passportno;
  private String nationality;
  private String driverslicenceno;
  private String occupation;
  private String employer;
  private Set<Advisor> advisors = new HashSet<Advisor>();
  private Set<Investorindividual> investorindividuals = new HashSet<Investorindividual>();
}
