package com.ubs.opi.domain;

import java.io.Serializable;
import java.util.Date;

/**
 * Domain model for a guarantor's financial data.
 *
 * @author Ana Velez
 */
public class FinancialInformation implements Serializable {
  //~ Methods ------------------------------------------------------------------
  
  public Long getId() {
    return this.id;
  }

  public void setId(Long id) {
    this.id = id;
  }
  
  public Long getCash() {
    return this.cash;
  }

  public void setCash(Long cash) {
    this.cash = cash;
  }

  public Long getGuaranteesGranted() {
    return this.guaranteesGranted;
  }

  public void setGuaranteesGranted(Long guaranteesGranted) {
    this.guaranteesGranted = guaranteesGranted;
  }

  public Long getIntSecuredLoans() {
    return this.intSecuredLoans;
  }

  public void setIntSecuredLoans(Long intSecuredLoans) {
    this.intSecuredLoans = intSecuredLoans;
  }

  public Long getIntUnsecuredLoans() {
    return this.intUnsecuredLoans;
  }

  public void setIntUnsecuredLoans(Long intUnsecuredLoans) {
    this.intUnsecuredLoans = intUnsecuredLoans;
  }

  public Long getInvestmentProperty() {
    return this.investmentProperty;
  }

  public void setInvestmentProperty(Long investmentProperty) {
    this.investmentProperty = investmentProperty;
  }

  public Long getLivingExpenses() {
    return this.livingExpenses;
  }

  public void setLivingExpenses(Long livingExpenses) {
    this.livingExpenses = livingExpenses;
  }

  public Long getLoansInvProperty() {
    return this.loansInvProperty;
  }

  public void setLoansInvProperty(Long loansInvProperty) {
    this.loansInvProperty = loansInvProperty;
  }

  public Long getLoansPersonalUnse() {
    return this.loansPersonalUnse;
  }

  public void setLoansPersonalUnse(Long loansPersonalUnse) {
    this.loansPersonalUnse = loansPersonalUnse;
  }

  public Long getLoansResProperty() {
    return this.loansResProperty;
  }

  public void setLoansResProperty(Long loansResProperty) {
    this.loansResProperty = loansResProperty;
  }

  public Long getOtherassets() {
    return this.otherassets;
  }

  public void setOtherassets(Long otherassets) {
    this.otherassets = otherassets;
  }

  public String getOtherassetsDetails() {
    return this.otherassetsDetails;
  }

  public void setOtherassetsDetails(String otherassetsDetails) {
    this.otherassetsDetails = otherassetsDetails;
  }

  public Long getOtherExpenses() {
    return this.otherExpenses;
  }

  public void setOtherExpenses(Long otherExpenses) {
    this.otherExpenses = otherExpenses;
  }

  public String getOtherExpensesDetails() {
    return this.otherExpensesDetails;
  }

  public void setOtherExpensesDetails(String otherExpensesDetails) {
    this.otherExpensesDetails = otherExpensesDetails;
  }

  public Long getOtherIncome() {
    return this.otherIncome;
  }

  public void setOtherIncome(Long otherIncome) {
    this.otherIncome = otherIncome;
  }

  public String getOtherIncomeDetails() {
    return this.otherIncomeDetails;
  }

  public void setOtherIncomeDetails(String otherIncomeDetails) {
    this.otherIncomeDetails = otherIncomeDetails;
  }

  public Long getOtherLiabilities() {
    return this.otherLiabilities;
  }

  public void setOtherLiabilities(Long otherLiabilities) {
    this.otherLiabilities = otherLiabilities;
  }

  public String getOtherLiabilitiesDetails() {
    return this.otherLiabilitiesDetails;
  }

  public void setOtherLiabilitiesDetails(String otherLiabilitiesDetails) {
    this.otherLiabilitiesDetails = otherLiabilitiesDetails;
  }

  public Long getOtherLiquid() {
    return this.otherLiquid;
  }

  public void setOtherLiquid(Long otherLiquid) {
    this.otherLiquid = otherLiquid;
  }

  public Long getOtherLoansSecured() {
    return this.otherLoansSecured;
  }

  public void setOtherLoansSecured(Long otherLoansSecured) {
    this.otherLoansSecured = otherLoansSecured;
  }

  public Long getRentalAndDividend() {
    return this.rentalAndDividend;
  }

  public void setRentalAndDividend(Long rentalAndDividend) {
    this.rentalAndDividend = rentalAndDividend;
  }

  public Long getResidentialProperty() {
    return this.residentialProperty;
  }

  public void setResidentialProperty(Long residentialProperty) {
    this.residentialProperty = residentialProperty;
  }

  public Long getSalary() {
    return this.salary;
  }

  public void setSalary(Long salary) {
    this.salary = salary;
  }

  public Long getShares() {
    return this.shares;
  }

  public void setShares(Long shares) {
    this.shares = shares;
  }

  public Long getTaxPayable() {
    return this.taxPayable;
  }

  public void setTaxPayable(Long taxPayable) {
    this.taxPayable = taxPayable;
  }

  public Date getTaxPayableDate() {
    return this.taxPayableDate;
  }

  public void setTaxPayableDate(Date taxPayableDate) {
    this.taxPayableDate = taxPayableDate;
  }

  public Investorindividual getInvestorindividual() {
    return this.investorindividual;
  }

  public void setInvestorindividual(Investorindividual investorindividual) {
    this.investorindividual = investorindividual;
  }
  
  public Long getAfterTaxTotal() {
    return this.getIncomeTotal() - this.taxPayable;
  }

  public Long getAssetsTotal() {
    return this.cash + this.shares + this.otherLiquid + this.residentialProperty + this.investmentProperty + this.otherassets;
  }

  public Long getExpenditureTotal() {
    return this.intSecuredLoans + this.intUnsecuredLoans + this.livingExpenses + this.otherExpenses;
  }

  public Long getIncomeAvailable() {
    return this.getAfterTaxTotal() - this.getExpenditureTotal();
  }


  public Long getIncomeTotal() {
    return this.salary + this.rentalAndDividend + this.otherIncome;
  }


  public Long getLiabilitiesTotal() {
    return this.otherLoansSecured + this.loansResProperty +
    this.loansInvProperty + this.loansPersonalUnse +
    this.guaranteesGranted + this.otherLiabilities;
  }


  public Long getNetAssets() {
    return this.getAssetsTotal() - this.getLiabilitiesTotal();
  }

  
  //~ Instance fields ----------------------------------------------------------

  private Long id;
  private Investorindividual investorindividual;
  private Long cash;
  private Long shares;
  private Long otherLiquid;
  private Long residentialProperty;
  private Long investmentProperty;
  private Long otherassets;
  private String otherassetsDetails;
  private Long otherLoansSecured;
  private Long loansResProperty;
  private Long loansInvProperty;
  private Long loansPersonalUnse;
  private Long guaranteesGranted;
  private Long otherLiabilities;
  private String otherLiabilitiesDetails;
  private Long salary;
  private Long rentalAndDividend;
  private Long otherIncome;
  private String otherIncomeDetails;
  private Long taxPayable;
  private Date taxPayableDate;
  private Long intSecuredLoans;
  private Long intUnsecuredLoans;
  private Long livingExpenses;
  private Long otherExpenses;
  private String otherExpensesDetails;
}
