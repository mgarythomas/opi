package org.opi.web.interceptor;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.ThemeResolver;
import org.springframework.web.servlet.support.RequestContextUtils;
import org.springframework.web.servlet.theme.ThemeChangeInterceptor;

/**
 * Extension of Spring's {@link ThemeChangeInterceptor} that makes sure that
 * only known themes are requested.
 *
 * @author Ana Velez
 */
public class OpiThemeChangeInterceptor extends ThemeChangeInterceptor {
  //~ Methods ------------------------------------------------------------------

  public boolean preHandle(HttpServletRequest request,
                           HttpServletResponse response, Object handler)
                    throws ServletException {
    boolean result = super.preHandle(request, response, handler);
    
    ThemeResolver themeResolver = RequestContextUtils.getThemeResolver(request);
    
    String newTheme = themeResolver.resolveThemeName(request);
    
    if (!validThemes.contains(newTheme)) {
      // not found.
      logger.error("Invalid theme passed in: " + newTheme);
      try {
        response.sendRedirect("accessDenied.jsp");

        return false;
      } catch (IOException e) {
        throw new ServletException("Could not redirect to accessDenied page.", e);
      }
    } else if (request.getParameter(this.paramName) != null){
      // found.  redirect to page without "param=.." extension.
      logger.warn("New theme set: " + newTheme + ".  Redirecting to login.htm");
      try {
        response.sendRedirect("login.htm");
      } catch (IOException e) {
        throw new ServletException("Could not redirect to login page.", e);
      }
    }

    return result;
  }

  /**
   * Set the name of the parameter that contains a theme specification
   * in a theme change request. Default is "theme".
   */
  public void setParamName(String paramName) {
    this.paramName = paramName;
    super.setParamName(paramName);
  }

  //~ Static fields/initializers -----------------------------------------------

  public static final List<String> validThemes =
    Arrays.asList("ubs", "hfa", "citibank", "bis");

  //~ Instance fields ----------------------------------------------------------

  private String paramName = DEFAULT_PARAM_NAME;
  
  private static final Log logger = LogFactory
      .getLog(OpiThemeChangeInterceptor.class);
}
