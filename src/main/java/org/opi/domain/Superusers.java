package org.opi.domain;

import java.util.LinkedHashMap;
import java.util.Map;

import org.springframework.security.core.userdetails.User;


public class Superusers{

   private long transadvisorId = 1;
   private Advisor transadvisor;
   private Map<String, String> advisors;
   private Map<Long, String> investors;
   private User users; 
   
//   private String transinvestortype; // holds the transient selection
//
//   private String transproductname; // holds the transient selection

   public boolean isAdvisorapplications()
   {
	   if (transadvisor.isNew())
		   return false;
	   
	   if (transadvisor.getApplications().size() > 0)
		   return true;
	   else
		   return false;
   }
    /** default constructor */
    public Superusers() {
    	advisors = new LinkedHashMap<String,String>();
    }

//    public Superusers(Advisor advisor) {
//       this.transadvisor = advisor;
//    }

   public Map<String, String> getAdvisors()
   {
      return advisors;
   }

   public boolean getAuthorized() {
      return BaseDomain.isSuperuser();
   }

   public boolean isAuthorized() {
      return BaseDomain.isSuperuser();
   }

//   public String getTransinvestortype() {
//      return transinvestortype;
//   }
//
//   public void setTransinvestortype(String transinvestortype) {
//      this.transinvestortype = transinvestortype;
//   }
//
//   public String getTransproductname() {
//      return transproductname;
//   }
//
//   public void setTransproductname(String transproductname) {
//      this.transproductname = transproductname;
//   }

   public Advisor getTransadvisor()
   {
      return transadvisor;
   }

   public Long getTransadvisorId()
   {
      return transadvisorId;
   }

   public User getUsers()
   {
      return users;
   }

   public void setAdvisors(Map<String, String> advisormap)
   {
      this.advisors.clear();
      this.advisors.putAll(advisormap);
   }

   public void setTransadvisor(Advisor transadvisor)
   {
      this.transadvisor = transadvisor;
   }

   public void setTransadvisorId(Long transadvisorId)
   {
      this.transadvisorId = transadvisorId;
   }

   public void setUsers(User users)
   {
      this.users = users;
   }
   public Map<Long, String> getInvestors() {
      return investors;
   }
   public void setInvestors(Map<Long, String> investors) {
      this.investors = investors;
   }
   public void setTransadvisorId(long transadvisorId) {
      this.transadvisorId = transadvisorId;
   }
}