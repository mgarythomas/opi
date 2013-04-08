package com.ubs.opi.domain;

import java.io.Serializable;

/**
 * Domain model for an application's direct credit details.
 *
 * @author Ana Velez
 */
public class ApplicationDirectCreditDetails implements Serializable {
  //~ Methods ------------------------------------------------------------------

  public boolean equals(Object o) {
    return o instanceof ApplicationDirectCreditDetails &&
           (((ApplicationDirectCreditDetails) o).id == this.id);
  }

  public int hashCode() {
    return (this.id != null) ? this.id.hashCode() : 0;
  }

  public String toString() {
    return "{applicationDirectCredit: bsb = " + this.bsb + ", accountName = " +
           this.accountName + ", accountNumber = " + this.accountNumber + "}";
  }

  public Long getId() {
    return this.id;
  }

  public void setId(Long id) {
    this.id = id;
  }

  public String getAccountName() {
    return this.accountName;
  }

  public void setAccountName(String accountName) {
    this.accountName = accountName;
  }

  public String getAccountNumber() {
    return this.accountNumber;
  }

  public void setAccountNumber(String accountNumber) {
    this.accountNumber = accountNumber;
  }

  public String getAccountType() {
    return this.accountType;
  }

  public void setAccountType(String accountType) {
    this.accountType = accountType;
  }

  public Application getApplication() {
    return this.application;
  }

  public void setApplication(Application application) {
    this.application = application;
  }

  public String getBsb() {
    return this.bsb;
  }

  public void setBsb(String bsb) {
    this.bsb = bsb;
  }

  public String getInstitution() {
    return this.institution;
  }

  public void setInstitution(String institution) {
    this.institution = institution;
  }

  public String getInstitutionAddress() {
    return this.institutionAddress;
  }

  public void setInstitutionAddress(String institutionAddress) {
    this.institutionAddress = institutionAddress;
  }

  public String getInstitutionPostcode() {
    return this.institutionPostcode;
  }

  public void setInstitutionPostcode(String institutionPostcode) {
    this.institutionPostcode = institutionPostcode;
  }

  public String getInstitutionState() {
    return this.institutionState;
  }

  public void setInstitutionState(String institutionState) {
    this.institutionState = institutionState;
  }

  public String getInstitutionSuburb() {
    return this.institutionSuburb;
  }

  public void setInstitutionSuburb(String institutionSuburb) {
    this.institutionSuburb = institutionSuburb;
  }

  //~ Instance fields ----------------------------------------------------------

  private Long id;
  private Application application;
  private String bsb;
  private String accountName;
  private String accountType;
  private String accountNumber;
  private String institution;
  private String institutionAddress;
  private String institutionSuburb;
  private String institutionPostcode;
  private String institutionState;
}
