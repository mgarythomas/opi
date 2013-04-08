package com.ubs.opi.domain;

import java.util.Comparator;

public class DwrdealergroupComp implements Comparator, java.io.Serializable {
   public int compare (Object o1, Object o2) {
     return (((Dwrdealergroup)o1).getName().hashCode() - ((Dwrdealergroup)o2).getName().hashCode());
   }
 }

