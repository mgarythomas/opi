package com.ubs.opi.domain;

import java.util.Map;
import java.util.TreeMap;

import org.springframework.util.StringUtils;
//import com.ubs.opi.validation.OpiValidator;

public class Dwrapplication implements java.io.Serializable {

   private long id = Constants.NEW_DOMAIN_ID;
   private long dbid = Constants.NEW_DOMAIN_ID;
     private String name;
     private String type;
     private String amount;
     private String product;
     private Long status;
     private String displaystatus;

    // Constructors

    /** default constructor */
    public Dwrapplication() {
    }

    public Dwrapplication(String dummy) {
       this.name = "dummy";
       this.product = "dummy";
       this.status = new Long(-1);
       this.amount = "$0.00";
       this.type = "Individual";
    }

    public Dwrapplication(Application application) {
       this.dbid = application.getId();
       this.name = application.getAccountdesignation();
       this.product = application.getProduct().getName();
       this.status = application.getStatus();
       this.amount = "$" + application.getTotalamount();
       this.type = application.getDisplaytype();
    }

    public String validate() {
       String result = "";
       if (!StringUtils.hasText(this.name))
          result += "Designate name is Required." + System.getProperty("line.separator"); 
       if (!StringUtils.hasText(this.product))
          result += "Product is Required." + System.getProperty("line.separator"); 

       // Property accessors
       return result;
    }
    
    public void update(Application app) {
       app.setAccountdesignation(this.getName());
       app.setStatus(this.getStatus());
    }
    
   public long getDbid() {
      return dbid;
   }

   public void setDbid(long dbid) {
      this.dbid = dbid;
   }

   public long getId() {
      return id;
   }

   public void setId(long id) {
      this.id = id;
   }

   public String getAmount() {
      return amount;
   }

   public void setAmount(String amount) {
      this.amount = amount;
   }

   public String getName() {
      return name;
   }

   public void setName(String name) {
      this.name = name;
   }

   public String getProduct() {
      return product;
   }

   public void setProduct(String product) {
      this.product = product;
   }

   public Long getStatus() {
      return status;
   }

   public void setStatus(Long status) {
      this.status = status;
   }

   public String getType() {
      return type;
   }

   public void setType(String type) {
      this.type = type;
   }

   public String getDisplaystatus() {
      return Utils.getAppstatus().get(this.status); //displaystatus;
   }

   public void setDisplaystatus(String displaystatus) {
      this.displaystatus = displaystatus;
   }






}