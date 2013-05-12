package org.opi.domain;

import org.opi.validation.OpiValidator;
import org.springframework.util.StringUtils;



public class Dwrdealergroup extends org.opi.domain.BaseDomain implements java.io.Serializable {

   private long id = Constants.NEW_DOMAIN_ID; // mod. by paulmac
   private long dbid = Constants.NEW_DOMAIN_ID;
   private String isdaapproved = Constants.FALSE;
   private String afsl;
     private String abn;
     private String name;
     private boolean doesnothaveadvisorfirms;
    // Constructors

   public String validate() {
        String result = "";
        if (!StringUtils.hasText(this.afsl))
           result += "AFSL is Required." + System.getProperty("line.separator");
        else if (!OpiValidator.isMatched(this.afsl, OpiValidator.REG_EXP_AFSL))
              result += OpiValidator.AFSL_ERR_STR + System.getProperty("line.separator"); 
        if (!StringUtils.hasText(this.name))
           result += "Name is Required." + System.getProperty("line.separator");
           
        if (!StringUtils.hasText(this.abn))
           result += "ABN is Required." + System.getProperty("line.separator");
        else if (!OpiValidator.isMatched(this.abn, OpiValidator.REG_EXP_ABN))
              result += OpiValidator.ABN_ERR_STR + System.getProperty("line.separator"); 

        return result;
     }
     

   // added by paulmac
   public void update(Dealergroup dg) {
      dg.setAfsl(this.getAfsl());
      dg.getCompany().setAbn(this.getAbn());
      dg.getCompany().setName(this.getName());
      dg.setIsdaapproved(this.getIsdaapproved());
   }
   
   public String getIsdaapproved() {
      return isdaapproved;
   }

   public void setIsdaapproved(String isdaapproved) {
      this.isdaapproved = isdaapproved;
   }

   /** default constructor */
     public Dwrdealergroup() {
     }

     public Dwrdealergroup(String afsl) {
        this.afsl = afsl;
        abn = "00000000000";
        name = "dummy";
     }

     public Dwrdealergroup(Dealergroup dealergroup) {
        this.dbid = dealergroup.getId();
        this.afsl = dealergroup.getAfsl();
//        if (dealergroup.getCompany().getAbn() == null)
//           this.abn = "10101010101";
//        else
        this.abn = dealergroup.getCompany().getAbn();
        this.name = dealergroup.getCompany().getName();
//        if (dealergroup.getIsdaapproved() == null)
//           this.abn = "false";
//        else
        this.isdaapproved = dealergroup.getIsdaapproved();
     }

     public String getAbn() {
      return abn;
   }

   public void setAbn(String abn) {
      this.abn = abn;
   }

   public String getName() {
      return name;
   }

   public void setName(String name) {
      this.name = name;
   }

    // Property accessors
    
   public String getAfsl() {
       return this.afsl;
   }

   public void setAfsl(String afsl) {
       this.afsl = afsl;
   }

   public long getId() {
      return id;
   }

   public void setId(long id) {
      this.id = id;
   }


   public long getDbid() {
      return dbid;
   }


   public void setDbid(long dbid) {
      this.dbid = dbid;
   }


   public boolean isDoesnothaveadvisorfirms() {
      return doesnothaveadvisorfirms;
   }


   public void setDoesnothaveadvisorfirms(boolean doesnothaveadvisorfirms) {
      this.doesnothaveadvisorfirms = doesnothaveadvisorfirms;
   }






}