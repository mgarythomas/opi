package org.opi.domain;

import java.util.HashSet;
import java.util.Set;

/**
 * Users generated by MyEclipse - Hibernate Tools
 */
public class Users implements java.io.Serializable {
  //~ Methods ------------------------------------------------------------------

  // Property accessors
  public String getUsername() {
    return this.username;
  }

  public void setUsername(String username) {
    this.username = username;
  }

  public String getPassword() {
    return this.password;
  }

  public void setPassword(String password) {
    this.password = password;
  }

  public String getPasswordconfirmed() {
    return this.passwordconfirmed;
  }

  public void setPasswordconfirmed(String passwordconfirmed) {
    this.passwordconfirmed = passwordconfirmed;
  }

  public String getEnabled() {
    return this.enabled;
  }

  public void setEnabled(String enabled) {
    this.enabled = enabled;
  }

  public Set getAuthoritieses() {
    return this.authoritieses;
  }

  public void setAuthoritieses(Set authoritieses) {
    this.authoritieses = authoritieses;
  }

  public String getCheckpassword() {
    return checkpassword;
  }

  public void setCheckpassword(String checkpassword) {
    this.checkpassword = checkpassword;
  }

  public Set<Individual> getIndividuals() {
    return this.individuals;
  }

  public void setIndividuals(Set<Individual> individuals) {
    this.individuals = individuals;
  }

  public String toString() {
    return "{user: username = " + this.username + "}";
  }

  //~ Instance fields ----------------------------------------------------------

  private String checkpassword;

  private String username;
  private String password;
  private String passwordconfirmed = "false";
  private String enabled = "false";
  private Set authoritieses = new HashSet(0);
  private Set<Individual> individuals = new HashSet<Individual>();
}
