package org.opi.domain;



/**
 * Role generated by MyEclipse - Hibernate Tools
 */

public class Role extends org.opi.domain.BaseDomain implements java.io.Serializable {

   // added by paulmac
   static final public String AdvisorRole = "ROLE_ADVISOR";
   static final public String AdminRole = "ROLE_ADMINISTRATOR";

   static final public String InvestorRole = "INVESTOR";
   static final public String DirectorRole = "DIRECTOR";
   static final public String AssistantAdvisorRole = "ASSISTANT";

   static final long serialVersionUID = 9;
    // Fields    

     private long id = -1; // mod. by paulmac
     private Logon logon;
     private String rolename;


    // Constructors

    /** default constructor */
    public Role() {
    }

	/** minimal constructor */
    public Role(String rolename) {
        this.rolename = rolename;
    }
    
    /** full constructor */
    public Role(Logon logon, String rolename) {
        this.logon = logon;
        this.rolename = rolename;
    }

   
    // Property accessors

    public long getId() {
        return this.id;
    }
    
    public void setId(long id) {
        this.id = id;
    }

    public Logon getLogon() {
        return this.logon;
    }
    
    public void setLogon(Logon logon) {
        this.logon = logon;
    }

    public String getRolename() {
        return this.rolename;
    }
    
    public void setRolename(String rolename) {
        this.rolename = rolename;
    }
   








}