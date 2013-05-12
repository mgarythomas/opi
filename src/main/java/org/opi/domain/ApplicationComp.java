package org.opi.domain;

import java.util.Comparator;

public class ApplicationComp implements Comparator<Application>,
                                        java.io.Serializable {
  //~ Methods ------------------------------------------------------------------

  public int compare(Application o1, Application o2) {
    int res =
      o1.getAccountdesignation().compareToIgnoreCase(
        o2.getAccountdesignation());

    // enable this to see all applications even with the same acccount 
    // designation.
//    if (res == 0) {
//      res = new Long(o1.getId()).compareTo(o2.getId());
//    }
    return res;
  }
}
