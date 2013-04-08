package com.ubs.opi.domain;

import java.io.File;
import java.io.FileOutputStream;
import java.io.PrintStream;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.Date;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class SimpleXMLFile
{
  static final Log log = LogFactory.getLog(SimpleXMLFile.class);

  private String mCurrentKey = null;
  private PrintStream mXML;
  public static String sBaseDirectory = System.getProperty("java.io.tmpdir");

  private File xmlFile;
  private FileOutputStream fo;

  public SimpleXMLFile (String id)
  {
    try
    {
      xmlFile = new File (System.getProperty ("java.io.tmpdir") + System.getProperty ("file.separator") +
                          "application" + id + "_" + new Date ().getTime () + ".xml");
      fo = new FileOutputStream (xmlFile);
      mXML = new PrintStream (xmlFile);
      mXML.println ("<?xml version = '1.0' encoding='utf-8'?>");
      mXML.println ("<EXTRACT>"); // use upper-case throughout xml
    }
    catch (Exception e)
    {
      log.error ("XML file creation error", e);
      // TODO: handle exception
    }
  }

  public void close () // should close when it goes out of scope
  {
    mXML.println ("</EXTRACT>"); // use upper-case
    mXML.close ();
    log.info("XML file closed");
    //System.out.println ("XML file closed"); 
  }

  public String getFilename ()
  {
    return xmlFile.getAbsolutePath ();
  }

  public void startKey (String key, int row)
  {
    mCurrentKey = key.toUpperCase();
    mXML.println ("  <" + mCurrentKey + " row='" + row + "'>");
  }

  public void endKey ()
  {
    mXML.println ("  </" + mCurrentKey + ">");
    mCurrentKey = null;
  }

  public void putItem (String tag, String value)
  {
    if (value == null)
      value = "";
    mXML.println ("    <" + tag.toUpperCase() + ">" + escaped (value) + "</" + tag.toUpperCase() + ">"); // ensure all tags are lower-case throughout
  }

  private String escaped (String value)
  {
    return value.replaceAll ("&", "&amp;").replaceAll ("<", "&lt;").replaceAll (">", "&gt;");
  }

  public void putQuery (String key, ResultSet rs)
  {
    try
    {
      ResultSetMetaData meta = rs.getMetaData ();
      int row = 0;
      int columns = meta.getColumnCount ();
      while (rs.next ())
      {
        row += 1;
        startKey (key, row);
        for (int i = 1; i <= columns; i++)
          putItem (meta.getColumnName (i), rs.getString (i));
        endKey ();
      }
    }
    catch (SQLException exception)
    {
      //System.err.println ("Database access error: " + exception);
      log.error("Database access error", exception);
      //Runtime.getRuntime ().halt (21);
    }
  }
}