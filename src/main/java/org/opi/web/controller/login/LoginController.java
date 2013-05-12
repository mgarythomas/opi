package org.opi.web.controller.login;

import javax.servlet.http.HttpServletRequest;


import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import org.opi.domain.Users;
import org.springframework.validation.BindException;

import org.springframework.web.servlet.ModelAndView;

import org.springframework.web.servlet.mvc.SimpleFormController;

/**
 * Controller to handle the login view.
 *
 * @author Ana Velez
 */
public class LoginController extends SimpleFormController {
  //~ Methods ------------------------------------------------------------------

  @Override
  protected Object formBackingObject(HttpServletRequest request)
                              throws Exception {
    logger.debug("formBackingObject ...");

    return new Users();
  }

  @Override
  protected ModelAndView onSubmit(Object command, BindException errors)
                           throws Exception {
    logger.debug("onSubmit ...");
    return super.onSubmit(command, errors);
  }

  //~ Static fields/initializers -----------------------------------------------

  private static final Log logger = LogFactory.getLog(LoginController.class);
}
