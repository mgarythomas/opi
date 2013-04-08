package com.ubs.opi.web;

import java.io.File;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.transform.Source;
import javax.xml.transform.stream.StreamSource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.ubs.opi.domain.SimpleXMLFile;
import com.ubs.opi.web.view.AbstractXslFoView;

public class OpiFopView extends AbstractXslFoView {
  //~ Constructors -------------------------------------------------------------

  public OpiFopView() {
    initApplicationContext();
  }

  //~ Methods ------------------------------------------------------------------

  /**
   * Returns the XML source to transform.
   * 
   */
  @Override
  protected Source createXsltSource(Map model, String root,
                                    HttpServletRequest request,
                                    HttpServletResponse response)
                             throws Exception {
    String xmlFilename = (String) model.get("xmlFilename");
    if (logger.isDebugEnabled()) {
      logger.debug("Transforming XML file " + xmlFilename);
    }
    
    File xmlFile = new File(xmlFilename);
    Source src = new StreamSource(xmlFile);

    return src;
  }

  //~ Static fields/initializers -----------------------------------------------

  static {
    final String key = "javax.xml.transform.TransformerFactory";
    final String value = "org.apache.xalan.processor.TransformerFactoryImpl";
    System.setProperty(key, value);
  }

  private static final Log logger = LogFactory.getLog(SimpleXMLFile.class);
}
