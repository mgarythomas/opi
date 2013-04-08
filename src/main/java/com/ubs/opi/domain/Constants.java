package com.ubs.opi.domain;

public class Constants
{
   static final public int NEW_DOMAIN_ID = Integer.MAX_VALUE -1000;

   static final public String FALSE = "false";
   static final public String TRUE = "true";

   // Product Types
   static final public String OCTANE_4 = "Octane Global";

   // InvestorIndividual.Role
   static final public String BENEFICFIARY = "Beneficiary";
   static final public String TRUSTEE = "Trustee";
   static final public String APPLICANT = "Applicant";
   static final public String DIRECTOR = "Director";
   static final public String GUARANTOR = "Guarantor";
   
   // Investor (and Company) Types
   static final public String INDIVIDUAL = "Individual";
   static final public String JOINT = "Joint Individual";
   static final public String CORPORATE = "Corporate";
   static final public String PRIVATE_TRUST = "Individual Trust";
   static final public String CORPORATE_TRUST = "Corporate Trust";
   
   static final public String NEW_ = "New ";

   static final public Long SELECT_PRODUCT_TYPE = new Long(-1);

   static final public Long SELECT_INVESTOR_TYPE = new Long(-1);
   static final public Long INDIVIDUAL_TYPE = new Long(0);
   static final public Long JOINT_TYPE = new Long(1);
   static final public Long CORPORATE_TYPE = new Long(2);
   static final public Long PRIVATE_TRUST_TYPE = new Long(3);
   static final public Long CORPORATE_TRUST_TYPE = new Long(4);

   static final public Long DRAFT_STATUS = new Long(0);
   static final public Long SUBMITTED_STATUS = new Long(1);
   static final public Long PROCESSING_STATUS = new Long(2);
   static final public Long INFORMATION_REQUIRED_STATUS = new Long(3);
   static final public Long CONDITIONAL_APPROVAL_STATUS = new Long(4);
   static final public Long APPROVED_STATUS = new Long(5);
   static final public Long REJECTED_STATUS = new Long(6);
   static final public Long WITHDRAWN_STATUS = new Long(7);
   static final public Long CANCELLED_STATUS = new Long(8);

   static final public String DRAFT = "Draft";
   static final public String SUBMITTED = "Submitted";
   static final public String PROCESSING = "Processing";
   static final public String INFORMATION_REQUIRED = "Information Required";
   static final public String CONDITIONAL_APPROVAL = "Conditional Approval";
   static final public String APPROVED = "Approved";
   static final public String REJECTED = "Rejected";
   static final public String WITHDRAWN = "Withdrawn";
   static final public String CANCELLED = "Cancelled";

   //
   // payment states
   //
   static final public String PAY_STATE_PENDING = "Pending";
   static final public Long PAY_STATE_PENDING_KEY = new Long(0);
   static final public String PAY_STATE_SCHEDULED = "Scheduled";
   static final public Long PAY_STATE_SCHEDULED_KEY = new Long(1);
   static final public String PAY_STATE_PAID = "Paid";
   static final public Long PAY_STATE_PAID_KEY = new Long(2);
   static final public String PAY_STATE_QUERY = "Query";
   static final public Long PAY_STATE_QUERY_KEY = new Long(3);

   // roles
   static final public String ADVISOR = "ROLE_ADVISOR";
   static final public String ADMINISTRATOR = "ROLE_ADMINISTRATOR";
   static final public String GURU = "ROLE_GURU";
   static final public String DATAENTRY = "ROLE_DATAENTRY";
   static final public String BDM = "ROLE_BDM"; 
}
