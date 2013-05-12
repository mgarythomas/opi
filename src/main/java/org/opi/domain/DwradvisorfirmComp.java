package org.opi.domain;

import java.util.Comparator;

public class DwradvisorfirmComp implements Comparator, java.io.Serializable {
   public int compare (Object o1, Object o2) {
     return (((Dwradvisorfirm)o1).getAfname().hashCode() - ((Dwradvisorfirm)o2).getAfname().hashCode());
   }
 }

