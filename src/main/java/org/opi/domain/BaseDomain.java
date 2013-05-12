package org.opi.domain;

import java.io.Serializable;

public abstract class BaseDomain implements Serializable {
   abstract public void setId(long id);
   abstract public long getId();
   public boolean isNew() {
      return (getId() > (Constants.NEW_DOMAIN_ID -1));
   }

   public static boolean isSuperuser() {
      return ( BaseDomain.isAdministrator() || BaseDomain.isDataentry()) ? true : false;
   }
   
      public static boolean isAdvisor() {
      return Utils.hasAuthority(Constants.ADVISOR);
   }   

   public static boolean isAdministrator() {
      return Utils.hasAuthority(Constants.ADMINISTRATOR);
   }   

   public static boolean isDataentry() {
      return Utils.hasAuthority(Constants.DATAENTRY);
   }   

   public static boolean isBdm() {
      return Utils.hasAuthority(Constants.BDM);
   }   

}
