package com.ubs.opi.domain;

import org.springframework.util.StringUtils;

import com.ubs.opi.validation.OpiValidator;


public class Dwradvisorfirm implements java.io.Serializable {

    private long id = Constants.NEW_DOMAIN_ID;
    private long dbid = Constants.NEW_DOMAIN_ID;
    private String afname;     
    private String afabn;
    private String afsl;
    private String address1;
    private String suburb;
    private String state;
    private String postcode;
    private boolean doesnothaveadvisors;

    // Constructors

    /** default constructor */
    public Dwradvisorfirm() {
    }

    public Dwradvisorfirm(String dealerGroupAfsl, String abn) {
       this.setAfsl(dealerGroupAfsl);
       this.setAfabn(abn);
       // this.setAfname("");
       // this.setAfsl("999999");
    }

    public Dwradvisorfirm(Advisorfirm advisorfirm) {
       this.dbid = advisorfirm.getId();
       this.afsl = advisorfirm.getDealergroup().getAfsl();
       this.afname = advisorfirm.getCompany().getName();
       this.afabn = advisorfirm.getCompany().getAbn();
       this.address1 = advisorfirm.getCompany().getAddress1();
       this.suburb = advisorfirm.getCompany().getSuburb();
       this.state = advisorfirm.getCompany().getState();
       this.postcode = advisorfirm.getCompany().getPostcode();
    }

    // Property accessors
    
    public String validate() {
       String result = "";
       if (!StringUtils.hasText(this.afname))
          result += "Name is Required." + System.getProperty("line.separator");
          
       if (!StringUtils.hasText(this.afabn))
          result += "ABN is Required." + System.getProperty("line.separator");
       else if (!OpiValidator.isMatched(this.afabn, OpiValidator.REG_EXP_ABN))
             result += OpiValidator.ABN_ERR_STR + System.getProperty("line.separator"); 

       if (!StringUtils.hasText(this.address1))
          result += "Address is Required." + System.getProperty("line.separator");
       if (!StringUtils.hasText(this.suburb))
          result += "Suburb is Required." + System.getProperty("line.separator");
       if (!StringUtils.hasText(this.postcode))
          result += "Postcode is Required."; // + System.getProperty("line.separator");
       else if (!OpiValidator.isMatched(this.postcode, OpiValidator.REG_EXP_POSTCODE))
          result += OpiValidator.POSTCODE_ERR_STR + System.getProperty("line.separator"); 

       return result;
    }

    // added by paulmac
    public void update(Advisorfirm af) {
       af.getCompany().setAbn(this.getAfabn());
       af.getCompany().setName(this.getAfname());
       af.getCompany().setAddress1(this.getAddress1());
       af.getCompany().setSuburb(this.getSuburb());
       af.getCompany().setState(this.getState());
       af.getCompany().setPostcode(this.getPostcode());
    }

    public String getState() {
      return state;
   }

   public void setState(String state) {
      this.state = state;
   }

   public String getAddress1() {
      return address1;
   }

   public void setAddress1(String address1) {
      this.address1 = address1;
   }

   public String getPostcode() {
      return postcode;
   }

   public String getAfabn() {
      return afabn;
   }

   public void setAfabn(String afabn) {
      this.afabn = afabn;
   }

   public String getAfname() {
      return afname;
   }

   public void setAfname(String afname) {
      this.afname = afname;
   }

   public void setPostcode(String postcode) {
      this.postcode = postcode;
   }

   public String getSuburb() {
      return suburb;
   }

   public void setSuburb(String suburb) {
      this.suburb = suburb;
   }

   public long getId() {
      return id;
   }

   public void setId(long id) {
      this.id = id;
   }

   public String getAfsl() {
      return afsl;
   }

   public void setAfsl(String afsl) {
      this.afsl = afsl;
   }

   public long getDbid() {
      return dbid;
   }

   public void setDbid(long dbid) {
      this.dbid = dbid;
   }

   public String getFulladdress() {
      String address = "";
      if (StringUtils.hasText(address1))
         address += address1;
      if (StringUtils.hasText(suburb))
         address += " "+suburb;
      if (StringUtils.hasText(postcode))
         address += " "+postcode;
      if (StringUtils.hasText(state))
         address += " "+state;
      return address;
   }

   public boolean isDoesnothaveadvisors() {
      return doesnothaveadvisors;
   }

   public void setDoesnothaveadvisors(boolean doesnothaveadvisors) {
      this.doesnothaveadvisors = doesnothaveadvisors;
   }


}