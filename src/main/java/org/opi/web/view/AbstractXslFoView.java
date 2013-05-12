/**
 * Copyright 2002-2004 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.opi.web.view;

import java.io.OutputStream;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javax.xml.transform.Result;
import javax.xml.transform.Source;
import javax.xml.transform.sax.SAXResult;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import org.apache.fop.apps.Fop;
import org.apache.fop.apps.FopFactory;
import org.apache.fop.apps.MimeConstants;

import org.springframework.web.servlet.view.xslt.AbstractXsltView;

/**
 * Convenient superclass for views rendered to PDF (or other FOP output format)
 * using XSLT-FO stylesheet.
 *
 * Subclasses must provide the XML W3C document to transform.
 * They do not need to concern themselves with XSLT or FOP.
 *
 * <p>In addition to properties specified in {@link AbstractXsltView}, the
 * following can be set:
 * <ul>
 * <li>renderer (int) - sets the output rendering used by the FOP engine. Note that some
 * values for this property (notably Driver.RENDER_AWT and Driver.RENDER_PRINT) may be
 * incompatible with this usage of FOP and will throw runtime exceptions</li>
 * </ul>
 *
 * @author Darren Davison
 * @see AbstractXsltView
 */
public abstract class AbstractXslFoView extends AbstractXsltView {
  //~ Methods ------------------------------------------------------------------

  /**
   * Perform the actual transformation, writing to the HTTP response via the
   * FOP Driver.
   */
  protected void doTransform(Map model, Source source,
                             HttpServletRequest request,
                             HttpServletResponse response)
                      throws Exception {
    response.setHeader("Content-Disposition", "inline");
    response.setContentType("application/pdf");

    FopFactory fopFactory = FopFactory.newInstance();

    if (log.isInfoEnabled()) {
      log.info(
        "ContextPath = " +
        request.getSession().getServletContext().getRealPath("/"));
    }

    OutputStream os = response.getOutputStream();

    Fop fop = fopFactory.newFop(MimeConstants.MIME_PDF, os);

    Result intermediateFile = new SAXResult(fop.getDefaultHandler());

    // Delegate to the superclass for the actual output having constructed the result.
    super.doTransform(
      source,
      getParameters(request),
      intermediateFile,
      response.getCharacterEncoding());

    log.info("success");
  }

  //~ Static fields/initializers -----------------------------------------------

  private static final Log log = LogFactory.getLog(AbstractXslFoView.class);
}
