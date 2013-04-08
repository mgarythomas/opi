package com.ubs.opi.exception;

/**
 * Exception to indicate that an incorrect relationship was encountered in 
 * the domain layer.
 * 
 * @author Ana Velez
 */
public class IncorrectRelationshipException extends Exception {

  public IncorrectRelationshipException(String message) {
    super(message);
  }

}
