package com.ubs.opi.domain;

import java.util.Comparator;

public class InvestorindividualComp implements Comparator<Investorindividual>, java.io.Serializable {
   public int compare (Investorindividual o1, Investorindividual o2) {
     if (!o1.isNew() && !o2.isNew()) {
       return o1.getId().compareTo(o2.getId()); 
     } else {
       return -1;
     }
   }
 }

