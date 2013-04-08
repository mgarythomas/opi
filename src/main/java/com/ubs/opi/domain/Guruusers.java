package com.ubs.opi.domain;

import java.util.List;

public class Guruusers{

   private List<Dealergroup> dealergroups;
   
    /** default constructor */
    public Guruusers() {
    }

   public List<Dealergroup> getDealergroups() {
      return dealergroups;
   }

   public void setDealergroups(List<Dealergroup> dealergroups) {
      this.dealergroups = dealergroups;
   }

}