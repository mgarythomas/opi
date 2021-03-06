package org.opi.domain;



/**
 * Bank generated by MyEclipse - Hibernate Tools
 */

public class Bank implements java.io.Serializable {


    // Fields    

     private String bsb;
     private String type;
     private String name;
     private String address1;
     private String suburb;
     private String state;
     private String postcode;
     private String telephone;


    // Constructors

    /** default constructor */
     public Bank(String bsb) {
    	 this.bsb = bsb;
     }

     public Bank() {
    }

	/** minimal constructor */
    public Bank(String bsb, String name, String address1, String suburb, String state, String postcode) {
        this.bsb = bsb;
        this.name = name;
        this.address1 = address1;
        this.suburb = suburb;
        this.state = state;
        this.postcode = postcode;
    }
    
    /** full constructor */
    public Bank(String bsb, String type, String name, String address1, String suburb, String state, String postcode, String telephone) {
        this.bsb = bsb;
        this.type = type;
        this.name = name;
        this.address1 = address1;
        this.suburb = suburb;
        this.state = state;
        this.postcode = postcode;
        this.telephone = telephone;
    }

   
    // Property accessors

    public String getBsb() {
        return this.bsb;
    }
    
    public void setBsb(String bsb) {
        this.bsb = bsb;
    }

    public String getType() {
        return this.type;
    }
    
    public void setType(String type) {
        this.type = type;
    }

    public String getName() {
        return this.name;
    }
    
    public void setName(String name) {
        this.name = name;
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

    public String getTelephone() {
        return this.telephone;
    }
    
    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }
   








}