package org.opi.exception;

import javax.servlet.ServletException;

/**
 * Exception for unauthorised access to web resource. 
 * 
 * @author Ana Velez
 */
public class RestrictedAccessException extends ServletException {
  public RestrictedAccessException(String message) {
    super(message);
  }
}
