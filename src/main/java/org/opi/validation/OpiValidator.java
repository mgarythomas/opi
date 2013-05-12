package org.opi.validation;

import java.text.SimpleDateFormat;
import java.util.Iterator;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.opi.domain.Investorindividual;
import org.opi.domain.Utils;
import org.springframework.util.StringUtils;
import org.springframework.validation.Errors;
import org.springframework.validation.FieldError;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;


/**
 * <code>Validator</code> for <code>Advisor</code> forms.
 *
 * @author Paul McLachlan
 */
public class OpiValidator implements Validator {

	private static final String DATE_FORMAT = "MM-dd-yyyy";

	private static final Log log = LogFactory.getLog(OpiValidator.class);

	private static final String REG_EXP_3DP = "\\d\\.\\d{0,3}$";

   public static final String REG_EXP_ABN = "\\d{11}";
  
  private static final String REG_EXP_ACN = "\\d{9}";

	private static final String REG_EXP_ACNo = "\\d{5,10}";

   public static final String REG_EXP_AFSL = "\\d{6}";

	private static final String REG_EXP_ARBN = "\\d{9}";

	private static final String REG_EXP_BSB = "\\d{6}";

	public static final String REG_EXP_EMAIL = ".+@.+\\.[a-z]+";

	private static final String REG_EXP_IS_NUMBER = "\\d";

	private static final String REG_EXP_PO_BOX = "^[pP](ost)?[ |\\.]*[oO](ffice)?[ |\\.]*[bB][oO][xX]?[ 0-9]*[^[a-z ]]*";

	public static final String REG_EXP_POSTCODE = "\\d{4}";

	private static final String REG_EXP_TEL = "\\d{10}";

	private static final String REG_EXP_TFN = "\\d{8,9}";
   
   public static final String AFSL_ERR_STR = "AFSL must be 6 digits long.";

   public static final String ABN_ERR_STR = "ABN must be 11 digits long.";

   public static final String POSTCODE_ERR_STR = "Postcode must be 4 digits long.";
	/**
	 *
	 * @param val
	 */
	protected static String clean(String val) {
		if (val != null) {
			val = val.replaceAll("\\s+", "");
			val = val.replaceAll("\\-+", "");
		}
		return val;
	}

	/**
	 *
	 * @param val
	 * @param pattern
	 * @return
	 */
	public static boolean isMatched(String val, String pattern) {
		// ignore if empty or null
		if (val == null || !StringUtils.hasText(val.toString()))
			return true;
		Pattern p = Pattern.compile(pattern);
		Matcher m = p.matcher(val);
		return m.matches();
	}

	private static boolean isMatched(String val, String pattern,
			boolean defaultMatched) {
		// ignore if empty or null
		if (val == null || !StringUtils.hasText(val.toString()))
			return defaultMatched;
		Pattern p = Pattern.compile(pattern);
		Matcher m = p.matcher(val);
		return m.matches();
	}

	/**
	 * TODO fix up for properties messaging
	 *
	 * @param errors
	 * @param fieldpath
	 * @param fieldname
	 */
	protected static void isRequired(Errors errors, String fieldpath,
			String fieldname) {
		StringBuffer buff = new StringBuffer();
		buff.append(fieldname);
		buff.append(" is mandatory");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, fieldpath, null, buff.toString());
	}

	/**
	 * 
	 * @param errors
	 * @param fieldpath
	 * @param fieldname
	 */
	protected static void isRequiredConditional(Errors errors,
			String fieldpath, String fieldname) {
		if (!Utils.hasAuthority("ROLE_ADMINISTRATOR")) {
			isRequired(errors, fieldpath, fieldname);
		}
	}

	/**
	 * 
	 * @param errors
	 * @param fieldpath
	 * @param fieldname
	 * @param val
	 * @param min
	 * @param inc
	 */
	protected static void isValidAmount(Errors errors, String fieldpath,
			String fieldname, long val, long min, long inc) {

		if (val != 0) {

			if ((val % inc) != 0) {
				errors.rejectValue(fieldpath, null,
						" must be an increment of $" + inc);

			}

			if (val < min) {

				errors.rejectValue(fieldpath, null, " must be greater than $"
						+ min);

			}
		}
	}

	/**
	 *
	 * @param errors
	 * @param fieldpath
	 * @param val
	 * @return
	 */
	protected static String validateAcctDesignateName(Errors errors,
			String fieldpath, String val) {
		String clean_val = clean(val);
		if (isMatched(clean_val, REG_EXP_IS_NUMBER)) {
			errors.rejectValue(fieldpath, null,
					"Account Name must be alphanumeric");
		}
		return clean_val;
	}

	/**
	 *
	 * @param errors
	 * @param fieldpath
	 * @param val
	 * @return
	 */
	protected static void validateDPs(Errors errors, String fieldpath,
			double val) {
		if (!isMatched("" + val, REG_EXP_3DP)) {
			errors.rejectValue(fieldpath, null,
					"Adviser Commission must be 3 decimal places or less ");
		}
	}

	/**
	 *
	 * @param errors
	 * @param fieldpath
	 * @param val
	 */
	protected static String validatePostcode(Errors errors, String fieldpath,
			String val) {
		String clean_val = clean(val);
		if (!isMatched(clean_val, REG_EXP_POSTCODE)) {
			errors.rejectValue(fieldpath, null, POSTCODE_ERR_STR
					);
		}
		return clean_val;
	}

	/**
	 *
	 * @param errors
	 * @param fieldpath
	 * @param val
	 */
	protected static void validateResidentialAddress(Errors errors,
			String fieldpath, String val) {

		if (val == null || !StringUtils.hasText(val.toString()))
			return;
		Pattern p = Pattern.compile(REG_EXP_PO_BOX);
		Matcher m = p.matcher(val);

		if (m.matches()) {
			errors.rejectValue(fieldpath, null,
					"Residential Address cannot be a PO Box ");
		}
	}

	/**
	 *
	 * @param errors
	 * @param fieldpath
	 * @param val
	 * @return
	 */
	protected static String validateTelephone(Errors errors, String fieldpath,
			String val) {
		String clean_val = clean(val);
		clean_val = clean_val.replaceAll("[A-Za-z\\(\\)\\+]+", "");
		if (!isMatched(clean_val, REG_EXP_TEL)) {
			errors.rejectValue(fieldpath, null,
					"Incorrect Telephone number format.");
		}
		return clean_val;
	}

	/**
	 *
	 * @param errors
	 * @param fieldpath
	 * @param val
	 */
	protected static String validateTFN(Errors errors, String fieldpath,
			String val) {
		String clean_val = clean(val);
		if (!isMatched(clean_val, REG_EXP_TFN)) {
			errors.rejectValue(fieldpath, null, "TFN must be 8 or 9 digits long.");
		}
		return clean_val;
	}

	protected int mandatoryCounter = 0;

	public int getMandatoryCounter() {
		return mandatoryCounter;
	}

	public static void logErrors(Errors errors) {
		int cnt = errors.getFieldErrorCount();
		Iterator itr = errors.getFieldErrors().iterator();
		while (itr.hasNext()) {
			FieldError fe = (FieldError) itr.next();
			String fieldName = fe.getField();
			String msg = fe.getDefaultMessage();
         
			log.info("FieldError name=" + fieldName + " msg=" + msg);
		}
	}

	protected void rejectMandatory(Errors errors) {
		if (errors.getErrorCount() > 0) {
			log.info("errors.getErrorCount()=" + errors.getErrorCount());
			// ValidationUtils.rejectIfEmptyOrWhitespace(errors,
			// "id",
			// "errors.required-class",
			// new Object[]{new DefaultMessageSourceResolvable("id")},
			// "Please complete all Mandatory fields");
		}
		// mandatoryCounter++;
	}

	public void setMandatoryCounter(int mandatoryCounter) {
		this.mandatoryCounter = mandatoryCounter;
	}

	public boolean supports(Class clazz) {
		return true;
	}

	public void validate(Object obj, Errors errors) {
	}

	protected static String validateABN(Errors errors, String fieldpath, String val) {
		String clean_val = clean(val);
		if (!isMatched(clean_val, REG_EXP_ABN)) {
			errors.rejectValue(fieldpath, null, ABN_ERR_STR);
		}
		return clean_val;
	}

  protected static String validateACN(Errors errors, String fieldpath, String val) {
    String clean_val = clean(val);
    if (!isMatched(clean_val, REG_EXP_ACN)) {
      errors.rejectValue(fieldpath, null, "ABN must be 9 digits long.");
    }
    return clean_val;
  }
  
	protected String validateACNo(Errors errors, String fieldpath, String val) {
		String clean_val = clean(val);
		if (!isMatched(clean_val, REG_EXP_ACNo)) {
			errors.rejectValue(fieldpath, null,
					"A/C Number must be 5-10 digits long.");
		}
		return clean_val;
	}

	/**
	 *
	 * @param errors
	 * @param fieldpath
	 * @param val
	 */
	protected String validateAFSL(Errors errors, String fieldpath, String val) {
		String clean_val = clean(val);
		if (!isMatched(clean_val, REG_EXP_AFSL)) {
			errors.rejectValue(fieldpath, null, AFSL_ERR_STR);
		}
		return clean_val;
	}

	/**
	 *
	 * @param errors
	 * @param fieldpath
	 * @param val
	 */
	protected static String validateARBN(Errors errors, String fieldpath, String val) {
		String clean_val = clean(val);
		if (!isMatched(clean_val, REG_EXP_ARBN)) {
			errors.rejectValue(fieldpath, null, "ARBN must be 9 digits long.");
		}
		return clean_val;
	}

	/**
	 *
	 * @param errors
	 * @param fieldpath
	 * @param val
	 */
	protected String validateBSB(Errors errors, String fieldpath, String val) {
		String clean_val = clean(val);
		if (!isMatched(clean_val, REG_EXP_BSB)) {
			errors.rejectValue(fieldpath, null, "BSB must be 6 digits long.");
		}
		return clean_val;
	}

	/**
	 *
	 * @param errors
	 * @param fieldpath
	 * @param val
	 */
	protected void validateDateFormat(Errors errors, String fieldpath,
			String val) {

		int dateFormatLength = DATE_FORMAT.length();
		try {
			if (val.length() != dateFormatLength) {
				errors.rejectValue(fieldpath, null, "Incorrect Date Format - "
						+ DATE_FORMAT + " expected.");
			} else {
				SimpleDateFormat format = new SimpleDateFormat(DATE_FORMAT);
				format.setLenient(false);
				format.parse(val);
			}
		} catch (Exception e) {
			errors.rejectValue(fieldpath, null, "Incorrect Date Format - "
					+ DATE_FORMAT + " expected.");
		}
	}

	/**
	 *
	 * @param errors
	 * @param fieldpath
	 * @param val
	 * @param name
	 */
	protected static void validateEmail(Errors errors, String fieldpath, String val) {
		// cleanWhitespace(val);
		if (!isMatched(val, REG_EXP_EMAIL)) {
			String errorField = "email";
         errors.rejectValue(fieldpath, null, "Incorrect Email Format");

//         errors.rejectValue(fieldpath, "errors.invalid-format",
//					new Object[] { new DefaultMessageSourceResolvable(
//							errorField) }, errorField);
		}
	}

	public void validateIndividual(Investorindividual investorindividual,
			Errors errors) {
		isRequired(errors, "individual.firstname", "firstname");
		isRequired(errors, "individual.lastname", "lastname");
		isRequired(errors, "individual.address1", "address1");
		isRequired(errors, "individual.postcode", "postcode");
		isRequired(errors, "individual.suburb", "suburb");
		isRequired(errors, "individual.state", "state");
		isRequired(errors, "individual.dateofbirth", "dateofbirth");
	}

}
