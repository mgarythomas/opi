package com.ubs.opi.domain;

import org.springframework.util.StringUtils;
import com.ubs.opi.validation.OpiValidator;

public class Dwradvisor implements java.io.Serializable {

   private long id = Constants.NEW_DOMAIN_ID;
   private long dbid = Constants.NEW_DOMAIN_ID;
     private String title;
     private String firstname;
     private String middlename;
     private String fullname;
     private String username;
     private String password;
     private String lastname;
     private String workphone;
     private String mobilephone;
     private String workfax;
     private String assistantname;
     private String assistantemail;
     private String workemail;
     private boolean doesnothaveapplications;


    // Constructors

    /** default constructor */
    public Dwradvisor() {
    }

    public Dwradvisor(String dummy) {
       this.firstname = "dum";
       this.lastname = "dum";
       this.username = "dumm";
       this.password = "iama";
       this.workphone = "0255555555";
       this.mobilephone = "0455555555";
       this.workfax = "0255555555";
       this.assistantname = "dum dum";
       this.assistantemail = "dumdum@hotmail.com";
       this.workemail = "dummy@hotmail.com";
    }

    public Dwradvisor(Advisor advisor) {
       this.dbid = advisor.getId();
       this.firstname = advisor.getIndividual().getFirstname();
       this.lastname = advisor.getIndividual().getLastname();
       this.username = advisor.getIndividual().getUsers().getUsername();
       this.password = advisor.getIndividual().getUsers().getPassword();
       this.workphone = advisor.getIndividual().getWorkphone();
       this.mobilephone = advisor.getIndividual().getMobilephone();
       this.workfax = advisor.getIndividual().getWorkfax();
       this.assistantname = advisor.getAssistantname();
       this.assistantemail = advisor.getAssistantemail();
       this.workemail = advisor.getIndividual().getWorkemail();
    }


    public String validate() {
       String result = "";
       if (!StringUtils.hasText(this.firstname))
          result += "First name is Required." + System.getProperty("line.separator"); 
       if (!StringUtils.hasText(this.lastname))
          result += "Surname is Required." + System.getProperty("line.separator"); 
       if (!StringUtils.hasText(this.workemail))
          result += "Email is Required." + System.getProperty("line.separator");
       else
         if (!OpiValidator.isMatched(this.workemail, OpiValidator.REG_EXP_EMAIL))
            result += "Email is not a valid email address." + System.getProperty("line.separator");       
       if (StringUtils.hasText(this.assistantemail) && !OpiValidator.isMatched(this.assistantemail, OpiValidator.REG_EXP_EMAIL))
          result += "Assistant Email is not a valid email address."; // + System.getProperty("line.separator");       

       return result;
    }
    
    public void update(Advisor adv) {
       adv.getIndividual().getUsers().setUsername(this.getUsername());
       adv.getIndividual().setFirstname(this.getFirstname());
       adv.getIndividual().setLastname(this.getLastname());
       adv.getIndividual().setWorkemail(this.getWorkemail());
       adv.setAssistantname(this.getAssistantname());
       adv.setAssistantemail(this.getAssistantemail());
    }

    public String getFirstname() {
      return firstname;
   }

   public void setFirstname(String firstname) {
      this.firstname = firstname;
   }

   public String getLastname() {
      return lastname;
   }

   public void setLastname(String lastname) {
      this.lastname = lastname;
   }

   public String getMiddlename() {
      return middlename;
   }

   public void setMiddlename(String middlename) {
      this.middlename = middlename;
   }

   public String getMobilephone() {
      return mobilephone;
   }

   public void setMobilephone(String mobilephone) {
      this.mobilephone = mobilephone;
   }

   public String getTitle() {
      return title;
   }

   public void setTitle(String title) {
      this.title = title;
   }

   public String getWorkemail() {
      return workemail;
   }

   public void setWorkemail(String workemail) {
      this.workemail = workemail;
   }

   public String getWorkfax() {
      return workfax;
   }

   public void setWorkfax(String workfax) {
      this.workfax = workfax;
   }

   public String getWorkphone() {
      return workphone;
   }

   public void setWorkphone(String workphone) {
      this.workphone = workphone;
   }

   public String getAssistantname() {
      return assistantname;
   }

   public void setAssistantname(String assistantname) {
      this.assistantname = assistantname;
   }

   public String getAssistantemail() {
      return assistantemail;
   }

   public void setAssistantemail(String assistantemail) {
      this.assistantemail = assistantemail;
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

   public String getFullname() {
      return this.lastname + ", " + this.firstname;
   }

   public String getPassword() {
      return password;
   }

   public void setPassword(String password) {
      this.password = password;
   }

   public String getUsername() {
      return username;
   }

   public void setUsername(String username) {
      this.username = username;
   }

   public boolean isDoesnothaveapplications() {
      return doesnothaveapplications;
   }

   public void setDoesnothaveapplications(boolean doesnothaveapplications) {
      this.doesnothaveapplications = doesnothaveapplications;
   }







}