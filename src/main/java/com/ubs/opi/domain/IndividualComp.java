package com.ubs.opi.domain;

import java.util.Comparator;

public class IndividualComp implements Comparator<Individual>,
		java.io.Serializable {

   public int compare (Individual o1, Individual o2) {
      return o1.getFullname().compareToIgnoreCase(o2.getFullname());
   }
}
