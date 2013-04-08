package com.ubs.opi.domain;

import java.util.HashSet;
import java.util.Set;


/**
 * Logon generated by MyEclipse - Hibernate Tools
 */

public class Logon extends com.ubs.opi.domain.BaseDomain implements java.io.Serializable {

   // added by paulmac
   static final long serialVersionUID = 7;
    // Fields    

     private long id = -1; // mod. by paulmac
     private String username;
     private String pwd;
     private String email;
     private Set individuals = new HashSet(0);
     private Set<Role> roles = new HashSet<Role>(0);


    // Constructors

    /** default constructor */
    public Logon() {
    }

	/** minimal constructor */
    public Logon(String email) {
        this.email = email;
    }
    
    /** full constructor */
    public Logon(String username, String pwd, String email, Set individuals, Set<Role> roles) {
        this.username = username;
        this.pwd = pwd;
        this.email = email;
        this.individuals = individuals;
        this.roles = roles;
    }

   
    // Property accessors

    public long getId() {
        return this.id;
    }
    
    public void setId(long id) {
        this.id = id;
    }

    public String getUsername() {
        return this.username;
    }
    
    public void setUsername(String username) {
        this.username = username;
    }

    public String getPwd() {
        return this.pwd;
    }
    
    public void setPwd(String pwd) {
        this.pwd = pwd;
    }

    public String getEmail() {
        return this.email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }

    public Set getIndividuals() {
        return this.individuals;
    }
    
    public void setIndividuals(Set individuals) {
        this.individuals = individuals;
    }

    public Set getRoles() {
        return this.roles;
    }
    
    public void setRoles(Set<Role> roles) {
        this.roles = roles;
    }

    public void addRole(Role role) {
       this.roles.add(role);
       role.setLogon(this);
    }









}