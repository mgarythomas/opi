package com.ubs.opi.validation;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.ubs.opi.domain.Users;

/**
 * <code>Validator</code> for <code>Logon</code> forms.
 *
 * @author Paul McLachlan
 */
public class LogonValidator implements Validator {

	public boolean supports(Class clazz) {
		return Users.class.isAssignableFrom(clazz);
	}

	public void validate(Object obj, Errors errors) {
      Users users = (Users) obj;

		ValidationUtils.rejectIfEmpty(errors, "username", "required", "required");
      //ValidationUtils.rejectIfEmpty(errors, "logon.email", "required", "required");
	}

}
