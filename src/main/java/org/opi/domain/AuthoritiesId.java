package org.opi.domain;



/**
 * AuthoritiesId generated by MyEclipse - Hibernate Tools
 */

public class AuthoritiesId implements java.io.Serializable {


    // Fields

     private String username;
     private String authority;


    // Constructors

    /** default constructor */
    public AuthoritiesId() {
    }


    /** full constructor */
    public AuthoritiesId(String username, String authority) {
        this.username = username;
        this.authority = authority;
    }


    // Property accessors

    public String getUsername() {
        return this.username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getAuthority() {
        return this.authority;
    }

    public void setAuthority(String authority) {
        this.authority = authority;
    }




   public boolean equals(Object other) {
         if ( (this == other ) ) return true;
		 if ( (other == null ) ) return false;
		 if ( !(other instanceof AuthoritiesId) ) return false;
		 AuthoritiesId castOther = ( AuthoritiesId ) other;

		 return ( (this.getUsername()==castOther.getUsername()) || ( this.getUsername()!=null && castOther.getUsername()!=null && this.getUsername().equals(castOther.getUsername()) ) )
 && ( (this.getAuthority()==castOther.getAuthority()) || ( this.getAuthority()!=null && castOther.getAuthority()!=null && this.getAuthority().equals(castOther.getAuthority()) ) );
   }

   public int hashCode() {
         int result = 17;

         result = 37 * result + ( getUsername() == null ? 0 : this.getUsername().hashCode() );
         result = 37 * result + ( getAuthority() == null ? 0 : this.getAuthority().hashCode() );
         return result;
   }





}