package com.ubs.opi.domain;

import java.util.Comparator;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class AdvisorComp implements Comparator<Advisor>,
		java.io.Serializable {

   private static final Log log = LogFactory.getLog(AdvisorComp.class);

	public int compare(Advisor o1, Advisor o2) {
      try
      {
         return o1.getIndividual().getFullname().compareToIgnoreCase(
               o2.getIndividual().getFullname());
      } catch (Exception e)
      {
         log.error("SPURIOUS DATA", e);
         return 1;
      }

	}
}
