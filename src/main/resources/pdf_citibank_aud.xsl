<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE xsl:stylesheet [<!ENTITY nbsp "&#160;"> <!ENTITY bullet "&#x2022;">]>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:svg="http://www.w3.org/2000/svg">
  <xsl:variable name="applicationType" select="EXTRACT/APPLICATION/TYPE"/>
  <!-- Type of application is enumerated: -->
  <!--   Individual = 0                   -->
  <!--   Joint = 1                        -->
  <!--   Corporate = 2                    -->
  <!--   Private Trust = 3                -->
  <!--   Corporate Trust = 4              -->
  <xsl:variable name="individualApplication" select="$applicationType = 0"/>
  <xsl:variable name="jointApplication" select="$applicationType = 1"/>
  <xsl:variable name="corporateApplication" select="$applicationType = 2"/>
  <xsl:variable name="privateTrustApplication" select="$applicationType = 3"/>
  <xsl:variable name="corporateTrustApplication" select="$applicationType = 4"/>

  <xsl:variable name="privateOrCorporateTrust" select="$privateTrustApplication or $corporateTrustApplication"/>
  <xsl:variable name="privateIndividualsApplying" select="$individualApplication or $jointApplication or $privateTrustApplication"/>
  <xsl:variable name="companyApplying" select="$corporateApplication or $corporateTrustApplication"/>

  <xsl:variable name="isBorrowingFromUBS" select="EXTRACT/APPLICATION/ISBORROWINGFROMUBS = 'true'"/>
  <xsl:variable name="isPurchasingPutFromUBS" select="EXTRACT/APPLICATION/ISPURCHASINGPUTFROMUBS = 'true'"/>
  <xsl:variable name="trustReviewDeeds" select="EXTRACT/APPLICATION/TRUSTREVIEWDEEDS = 'true'"/>
  <xsl:variable name="isIAL" select="EXTRACT/APPLICATION/ISIAL = 'true'"/>
  <xsl:variable name="reinvestDistribution" select="EXTRACT/APPLICATION/REINVESTDISTRIBUTION = 'true'"/>
  <xsl:variable name="directCreditDistribution" select="EXTRACT/APPLICATION/DIRECTCREDITDISTRIBUTION = 'true'"/>
  <xsl:variable name="isPaperCopyWanted" select="EXTRACT/APPLICATION/ISPAPERCOPYWANTED = 'true'"/>
  <xsl:variable name="isProviderCustomer" select="EXTRACT/APPLICATION/ISPROVIDERCUSTOMER = 'true'"/>
  <xsl:variable name="isUBSCustomer" select="EXTRACT/APPLICATION/ISUBSCUSTOMER = 'true'"/>
  <xsl:variable name="isEitherToSign" select="EXTRACT/APPLICATION/ISEITHERTOSIGN = 'true'"/>
  <xsl:variable name="isDAApproved" select="EXTRACT/APPLICATION/ISDAAPPROVED = 'true'"/>
  <xsl:variable name="isDraft" select="EXTRACT/APPLICATION/STATUS = '0'"/>
  
  <xsl:output method="xml" version="1.0" indent="yes"/>
  <xsl:template match="/">
    <fo:root>
      <!-- 
        - This section defines the layout for each section (the page size, etc).
        -
        -->
      <fo:layout-master-set>
        <fo:simple-page-master master-name="FormA" page-height="297mm" page-width="210mm" margin-top="0mm" margin-bottom="0mm" margin-left="0mm" margin-right="0mm">
          <fo:region-body margin-top="26mm" margin-bottom="26mm" margin-left="26mm" margin-right="17mm">
            <xsl:if test="$isDraft">
              <xsl:attribute name="background-image">url('http://ssyd0106pap:7023/opi/images/Draft.jpg')</xsl:attribute>
              <xsl:attribute name="background-repeat">no-repeat</xsl:attribute>
              <xsl:attribute name="background-position-horizontal">center</xsl:attribute>
              <xsl:attribute name="background-position-vertical">center</xsl:attribute>
            </xsl:if>
          </fo:region-body>
          <fo:region-before extent="26mm"/>
          <fo:region-after extent="26mm"/>
        </fo:simple-page-master>
      </fo:layout-master-set>
  
      <!-- 
        - This page-secquence is for Form A - The green pages.
        -
        -->
      <fo:page-sequence master-reference="FormA" force-page-count="no-force">
        <fo:static-content flow-name="xsl-region-before">
          <fo:block>&nbsp;</fo:block>
        </fo:static-content>
        <fo:static-content flow-name="xsl-region-after">
          <fo:block text-align="center">
            <fo:page-number/>
          </fo:block>
        </fo:static-content>
        <fo:flow flow-name="xsl-region-body" font-size="9pt">
          <fo:block font-size="20pt" 
                    space-after="6pt" 
                    border="solid thin black" 
                    text-align="center" 
                    padding-top="2mm"
                    padding-bottom="2mm"
                    font-family="Tahoma, Helvetica" 
                    font-weight="bold">
            FORM A - AUD SERIES
          </fo:block>
          
          <fo:table padding-after="5px">
            <fo:table-column column-width="60%"/>
            <fo:table-column column-width="40%"/>
            <fo:table-body>
              <fo:table-row>
                <fo:table-cell>
                  <fo:block font-size="20pt" space-after="6pt" font-family="Ubsheadline, 'UBSHeadline', 'Times New Roman', Georgia, Times, serif">
                    Investor Application Form
                  </fo:block>
                  
                  <fo:block font-size="14pt" space-after="6pt" font-family="'UBSHeadline', 'Times New Roman', Georgia, Times, serif">
                    UBS Call Ups – Series 6 – Infrastructure &amp; Environment Basket
                  </fo:block>
                  
                  <fo:block font-size="12pt" space-after="6pt" font-weight="bold" padding-after="1cm">
                    THIS FORM IS TO BE USED IF YOU WISH TO INVEST IN UNITS. 
                    THIS FORM SHOULD BE FORWARDED TO YOUR APPROVED ADVISER.
                  </fo:block>
                </fo:table-cell>
                <fo:table-cell text-align="right">
                  <fo:block border="solid thin black" text-align="left" padding-top="3mm" padding-bottom="3mm" padding-left="3mm">
                    <fo:block space-after="1.5cm" text-align="left">
                      Financial Adviser Stamp
                    </fo:block>
                    <fo:block space-after="3mm" text-align="left">
                      Adviser Name:
                      <fo:inline font-weight="bold">
                        <xsl:value-of select="EXTRACT/APPLICATION/ADVISORFIRSTNAME"/>
                        <xsl:text>&#x20;</xsl:text> 
                        <xsl:value-of select="EXTRACT/APPLICATION/ADVISORLASTNAME"/>
                      </fo:inline>
                    </fo:block>
                    <fo:block space-after="3mm" text-align="left">
                      Telephone:
                      <fo:inline font-weight="bold">
                        <xsl:value-of select="EXTRACT/APPLICATION/ADVISORPHONE"/>
                      </fo:inline>
                    </fo:block>
                    <fo:block space-after="3mm" text-align="left">
                      Email:
                      <fo:inline font-weight="bold">
                        <xsl:value-of select="EXTRACT/APPLICATION/ADVISOREMAIL"/>
                      </fo:inline>
                    </fo:block>
                  
                    <!-- 
                    <fo:instream-foreign-object>
                      <svg:svg width="43mm" height="36mm" xmlns:svg="http://www.w3.org/2000/svg">
                        <svg:rect x="2%" y="2%" width="95%" height="95%" stroke="#000000" stroke-width="1pt" fill="white">
                          HELLO
                        </svg:rect>
                      </svg:svg>
                    </fo:instream-foreign-object>
                    -->
                  </fo:block>
                </fo:table-cell>
              </fo:table-row>
            </fo:table-body>
          </fo:table>
          
          
          <fo:block font-size="11pt" space-after="6pt" font-weight="bold">
            Please refer to the Instructions for the Investor Application Form on the previous page.
          </fo:block>
          
          <fo:block font-size="8pt" space-after="6pt">
            I/we hereby apply for the following Units to be issued by UBS to me/us as set out in this Investor Application Form below
            pursuant to the PDS dated 27 June 2007:
          </fo:block>
          
          <fo:block font-size="11pt" space-after="6pt" font-weight="bold">
            A. Full Details of Buyer:
          </fo:block>
          
          <fo:block font-size="8pt" space-after="6pt">
            If an individual applicant, please provide your full name, date of birth, residential address and occupation under 1) below
          </fo:block>
          <fo:block font-size="8pt" space-after="6pt">
            If a company applicant, please provide the full name of the company and ABN/ACN/ARBN under 2) below and the details of 2 directors under 1) below
          </fo:block>
          <fo:block font-size="8pt" space-after="6pt">
            If a super fund applicant, please provide the full name of the super fund and ABN under 2) below and the details of the trustees under 1) below and the names only of the beneficiaries under 3) below.
          </fo:block>
          <fo:block font-size="8pt" space-after="6pt">
            If a trust applicant with an individual trustee, please provide the full name of the trust under 2) below and the details of the trustees under 1) below and the names only of the beneficiaries under 3) below
          </fo:block>
          <fo:block font-size="8pt" space-after="6pt">
            If a trust applicant with a corporate trustee, please provide the full name of the trust under 2) below and the details of 2 directors of the trustee under 1) below and the names only of the beneficiaries under 3) below
          </fo:block>
        
          <fo:block font-size="11pt" space-after="6pt" font-weight="bold">
            1) Details of Applicants, Trustees and/or Directors
          </fo:block>
          
          <xsl:if test="$individualApplication">
            <!-- 
              - If it's an individual, we only have 1 applicant.
              -
              -->
            <fo:block font-size="11pt" space-after="6pt" font-weight="bold">
              Applicant
            </fo:block>
            
            <xsl:call-template name="applicantDetails">
              <xsl:with-param name="firstName"><xsl:value-of select="EXTRACT/APPLICANT[@row = '1']/FIRSTNAME"/></xsl:with-param>
              <xsl:with-param name="middleName"><xsl:value-of select="EXTRACT/APPLICANT[@row = '1']/MIDDLENAME"/></xsl:with-param>
              <xsl:with-param name="lastName"><xsl:value-of select="EXTRACT/APPLICANT[@row = '1']/LASTNAME"/></xsl:with-param>
              <xsl:with-param name="dateOfBirth"><xsl:value-of select="EXTRACT/APPLICANT[@row = '1']/DATEOFBIRTH"/></xsl:with-param>
              <xsl:with-param name="occupation"><xsl:value-of select="EXTRACT/APPLICANT[@row = '1']/OCCUPATION"/></xsl:with-param>
              <xsl:with-param name="address1"><xsl:value-of select="EXTRACT/APPLICANT[@row = '1']/ADDRESS1"/></xsl:with-param>
              <xsl:with-param name="address2">
                <xsl:value-of select="EXTRACT/APPLICANT[@row = '1']/SUBURB"/>,
                <xsl:value-of select="EXTRACT/APPLICANT[@row = '1']/STATE"/>,
                <xsl:value-of select="EXTRACT/APPLICANT[@row = '1']/POSTCODE"/>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:if>
          <xsl:if test="$jointApplication">
            <!-- 
              - If it's a joint individual, print for each individual.
              -
              -->
            <xsl:for-each select="EXTRACT/APPLICANT">
              <fo:block font-size="11pt" space-after="6pt" font-weight="bold">
                Applicant <xsl:value-of select="position()"/>
              </fo:block>
              
              <xsl:call-template name="applicantDetails">
                <xsl:with-param name="firstName"><xsl:value-of select="FIRSTNAME"/></xsl:with-param>
                <xsl:with-param name="middleName"><xsl:value-of select="MIDDLENAME"/></xsl:with-param>
                <xsl:with-param name="lastName"><xsl:value-of select="LASTNAME"/></xsl:with-param>
                <xsl:with-param name="dateOfBirth"><xsl:value-of select="DATEOFBIRTH"/></xsl:with-param>
                <xsl:with-param name="occupation"><xsl:value-of select="OCCUPATION"/></xsl:with-param>
                <xsl:with-param name="address1"><xsl:value-of select="ADDRESS1"/></xsl:with-param>
                <xsl:with-param name="address2">
                  <xsl:value-of select="SUBURB"/>,
                  <xsl:value-of select="STATE"/>,
                  <xsl:value-of select="POSTCODE"/>
                </xsl:with-param>
              </xsl:call-template>
            </xsl:for-each>
          </xsl:if>
          <xsl:if test="$corporateApplication">
            <xsl:choose>
              <xsl:when test="EXTRACT/APPLICANT[@row = '1']/ISSOLEDIRECTOR = 'true'">
                <!-- 
                  - If it's corporate account with a sole director, only print
                  - that director's details.
                  -
                  -->
                <fo:block font-size="11pt" space-after="6pt" font-weight="bold">
                  Director
                </fo:block>
                
                <xsl:call-template name="applicantDetails">
                  <xsl:with-param name="firstName"><xsl:value-of select="EXTRACT/APPLICANT[@row = '1']/FIRSTNAME"/></xsl:with-param>
                  <xsl:with-param name="middleName"><xsl:value-of select="EXTRACT/APPLICANT[@row = '1']/MIDDLENAME"/></xsl:with-param>
                  <xsl:with-param name="lastName"><xsl:value-of select="EXTRACT/APPLICANT[@row = '1']/LASTNAME"/></xsl:with-param>
                  <xsl:with-param name="dateOfBirth"><xsl:value-of select="EXTRACT/APPLICANT[@row = '1']/DATEOFBIRTH"/></xsl:with-param>
                  <xsl:with-param name="occupation"><xsl:value-of select="EXTRACT/APPLICANT[@row = '1']/OCCUPATION"/></xsl:with-param>
                  <xsl:with-param name="address1"><xsl:value-of select="EXTRACT/APPLICANT[@row = '1']/ADDRESS1"/></xsl:with-param>
                  <xsl:with-param name="address2">
                    <xsl:value-of select="EXTRACT/APPLICANT[@row = '1']/SUBURB"/>,
                    <xsl:value-of select="EXTRACT/APPLICANT[@row = '1']/STATE"/>,
                    <xsl:value-of select="EXTRACT/APPLICANT[@row = '1']/POSTCODE"/>
                  </xsl:with-param>
                </xsl:call-template>
              </xsl:when>
              <xsl:otherwise>
                <!--
                  - If it's a corporate account without a sole director, print
                  - for each director.
                  -
                  -->
                <xsl:for-each select="EXTRACT/APPLICANT">
                  <fo:block font-size="11pt" space-after="6pt" font-weight="bold">
                    Director <xsl:value-of select="position()"/>
                  </fo:block>
                  
                  <xsl:call-template name="applicantDetails">
                    <xsl:with-param name="firstName"><xsl:value-of select="FIRSTNAME"/></xsl:with-param>
                    <xsl:with-param name="middleName"><xsl:value-of select="MIDDLENAME"/></xsl:with-param>
                    <xsl:with-param name="lastName"><xsl:value-of select="LASTNAME"/></xsl:with-param>
                    <xsl:with-param name="dateOfBirth"><xsl:value-of select="DATEOFBIRTH"/></xsl:with-param>
                    <xsl:with-param name="occupation"><xsl:value-of select="OCCUPATION"/></xsl:with-param>
                    <xsl:with-param name="address1"><xsl:value-of select="ADDRESS1"/></xsl:with-param>
                    <xsl:with-param name="address2">
                      <xsl:value-of select="SUBURB"/>,
                      <xsl:value-of select="STATE"/>,
                      <xsl:value-of select="POSTCODE"/>
                    </xsl:with-param>
                  </xsl:call-template>
                </xsl:for-each>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:if>
          <xsl:if test="$privateTrustApplication">
            <!--
              - For private trusts, print for each trustee.
              -
              -->
            <xsl:for-each select="EXTRACT/APPLICANT">
              <fo:block font-size="11pt" space-after="6pt" font-weight="bold">
                Trustee <xsl:value-of select="position()"/>
              </fo:block>
              
              <xsl:call-template name="applicantDetails">
                <xsl:with-param name="firstName"><xsl:value-of select="FIRSTNAME"/></xsl:with-param>
                <xsl:with-param name="middleName"><xsl:value-of select="MIDDLENAME"/></xsl:with-param>
                <xsl:with-param name="lastName"><xsl:value-of select="LASTNAME"/></xsl:with-param>
                <xsl:with-param name="dateOfBirth"><xsl:value-of select="DATEOFBIRTH"/></xsl:with-param>
                <xsl:with-param name="occupation"><xsl:value-of select="OCCUPATION"/></xsl:with-param>
                <xsl:with-param name="address1"><xsl:value-of select="ADDRESS1"/></xsl:with-param>
                <xsl:with-param name="address2">
                  <xsl:value-of select="SUBURB"/>,
                  <xsl:value-of select="STATE"/>,
                  <xsl:value-of select="POSTCODE"/>
                </xsl:with-param>
              </xsl:call-template>
            </xsl:for-each>
          </xsl:if>
          <xsl:if test="$corporateTrustApplication">
            <!-- 
              - For corporate trusts, print for each trust director.
              - 
              -->
            <xsl:for-each select="EXTRACT/APPLICANT[ISDIRECTOR = 'true']">
              <fo:block font-size="11pt" space-after="6pt" font-weight="bold">
                Trustee Director <xsl:value-of select="position()"/>
              </fo:block>
              
              <xsl:call-template name="applicantDetails">
                <xsl:with-param name="firstName"><xsl:value-of select="FIRSTNAME"/></xsl:with-param>
                <xsl:with-param name="middleName"><xsl:value-of select="MIDDLENAME"/></xsl:with-param>
                <xsl:with-param name="lastName"><xsl:value-of select="LASTNAME"/></xsl:with-param>
                <xsl:with-param name="dateOfBirth"><xsl:value-of select="DATEOFBIRTH"/></xsl:with-param>
                <xsl:with-param name="occupation"><xsl:value-of select="OCCUPATION"/></xsl:with-param>
                <xsl:with-param name="address1"><xsl:value-of select="ADDRESS1"/></xsl:with-param>
                <xsl:with-param name="address2">
                  <xsl:value-of select="SUBURB"/>,
                  <xsl:value-of select="STATE"/>,
                  <xsl:value-of select="POSTCODE"/>
                </xsl:with-param>
              </xsl:call-template>
            </xsl:for-each>
          </xsl:if>
  
          <fo:block font-size="11pt" space-after="6pt" font-weight="bold">
            2) Company/Trust/Super Fund Name
          </fo:block>
          
          <fo:table padding-after="5px">
            <fo:table-column column-width="100%" />
            <fo:table-body>
              <fo:table-row>
                <fo:table-cell>
                  <fo:block font-size="9pt" margin-right="10px">Name</fo:block>
                  <fo:block border="solid thin black" margin-right="10px">
                    <xsl:choose>
                      <xsl:when test="$individualApplication or $jointApplication">
                        &nbsp;
                      </xsl:when>
                      <xsl:when test="$corporateApplication">
                        &nbsp;
                        <xsl:value-of select="EXTRACT/APPLICATION[@row = '1']/COMPANYNAME"/>
                      </xsl:when>
                      <xsl:when test="$privateTrustApplication">
                        &nbsp;
                        <xsl:value-of select="EXTRACT/APPLICATION[@row = '1']/TRUSTNAME"/>
                      </xsl:when>
                      <xsl:when test="$corporateTrustApplication">
                        &nbsp;
                        <xsl:value-of select="EXTRACT/APPLICATION[@row = '1']/COMPANYNAME"/> (COMPANY NAME),
                        <xsl:value-of select="EXTRACT/APPLICATION[@row = '1']/TRUSTNAME"/> (TRUST NAME)
                      </xsl:when>
                    </xsl:choose>
                  </fo:block>
                </fo:table-cell>
              </fo:table-row>
            </fo:table-body>
          </fo:table>
          
          <fo:table padding-after="5px">
            <fo:table-column column-width="100%" />
            <fo:table-body>
              <fo:table-row>
                <fo:table-cell>
                  <fo:block font-size="9pt" margin-right="10px">ABN / ACN / ARBN</fo:block>
                  <fo:block border="solid thin black" margin-right="10px">
                    &nbsp;
                    <xsl:choose>
                      <xsl:when test="$corporateApplication">
                        <xsl:variable name="companyAbn"><xsl:value-of select="EXTRACT/APPLICATION[@row = '1']/COMPANYABN"/></xsl:variable>
                        <xsl:variable name="companyAcn"><xsl:value-of select="EXTRACT/APPLICATION[@row = '1']/COMPANYACN"/></xsl:variable>
                        <xsl:variable name="companyArbn"><xsl:value-of select="EXTRACT/APPLICATION[@row = '1']/COMPANYARBN"/></xsl:variable>
                        <xsl:if test="$companyAbn">
                          <xsl:value-of select="$companyAbn"/> (ABN)
                        </xsl:if>
                        <xsl:if test="$companyAcn">
                          <xsl:value-of select="$companyAcn"/> (ACN)
                        </xsl:if>
                        <xsl:if test="$companyArbn">
                          <xsl:value-of select="$companyArbn"/> (ARBN)
                        </xsl:if>
                      </xsl:when>
                      <xsl:when test="$corporateTrustApplication">
                        <xsl:variable name="companyAbn"><xsl:value-of select="EXTRACT/APPLICATION[@row = '1']/COMPANYABN"/></xsl:variable>
                        <xsl:variable name="companyAcn"><xsl:value-of select="EXTRACT/APPLICATION[@row = '1']/COMPANYACN"/></xsl:variable>
                        <xsl:variable name="companyArbn"><xsl:value-of select="EXTRACT/APPLICATION[@row = '1']/COMPANYARBN"/></xsl:variable>
                        <xsl:variable name="trustAbn"><xsl:value-of select="EXTRACT/APPLICATION[@row = '1']/TRUSTABN"/></xsl:variable>
                        <xsl:variable name="trustAcn"><xsl:value-of select="EXTRACT/APPLICATION[@row = '1']/TRUSTACN"/></xsl:variable>
                        <xsl:variable name="trustArbn"><xsl:value-of select="EXTRACT/APPLICATION[@row = '1']/TRUSTARBN"/></xsl:variable>
                        <xsl:if test="$companyAbn">
                          <xsl:value-of select="$companyAbn"/> (COMPANY ABN)
                        </xsl:if>
                        <xsl:if test="$companyAcn">
                          <xsl:value-of select="$companyAcn"/> (COMPANY ACN)
                        </xsl:if>
                        <xsl:if test="$companyArbn">
                          <xsl:value-of select="$companyArbn"/> (COMPANY ARBN)
                        </xsl:if>
                        ,
                        <xsl:if test="$trustAbn">
                          <xsl:value-of select="$trustAbn"/> (TRUST ABN)
                        </xsl:if>
                        <xsl:if test="$companyAcn">
                          <xsl:value-of select="$trustAcn"/> (TRUST ACN)
                        </xsl:if>
                        <xsl:if test="$companyArbn">
                          <xsl:value-of select="$trustArbn"/> (TRUST ARBN)
                        </xsl:if>
                      </xsl:when>
                    </xsl:choose>
                  </fo:block>
                </fo:table-cell>
              </fo:table-row>
            </fo:table-body>
          </fo:table>
          
          <fo:block font-size="11pt" space-after="6pt" font-weight="bold">
            3) Names of Trust/Super Fund Beneficiaries
          </fo:block>
          
          <fo:table padding-after="5px">
            <fo:table-column column-width="100%" />
            <fo:table-body>
              <fo:table-row>
                <fo:table-cell>
                  <fo:block-container height="2.5cm" border="thin solid black" margin-right="10px">
                    <fo:block min-height="5cm">&nbsp;<xsl:value-of select="EXTRACT/APPLICATION[@row = '1']/TRUSTBENEFICIARIES"/></fo:block>
                  </fo:block-container>
                </fo:table-cell>
              </fo:table-row>
            </fo:table-body>
          </fo:table>
          
          <fo:block font-size="11pt" space-after="6pt" font-weight="bold">
            B. Postal Address Details:
          </fo:block>
          
          <fo:table padding-after="5px">
            <fo:table-column column-width="100%" />
            <fo:table-body>
              <fo:table-row>
                <fo:table-cell>
                  <fo:block font-size="9pt" margin-right="10px">Number and Street</fo:block>
                  <fo:block border="solid thin black" margin-right="10px">
                    &nbsp;
                    <xsl:value-of select="EXTRACT/APPLICATION[@row = '1']/POSTALADDRESS1"/>
                    <xsl:text>&#x20;</xsl:text> 
                    <xsl:value-of select="EXTRACT/APPLICATION[@row = '1']/POSTALADDRESS2"/>
                  </fo:block>
                </fo:table-cell>
              </fo:table-row>
            </fo:table-body>
          </fo:table>
          <fo:table padding-after="5px">
            <fo:table-column column-width="50%" />
            <fo:table-column column-width="25%" />
            <fo:table-column column-width="25%" />
            <fo:table-body>
              <fo:table-row>
                <fo:table-cell>
                  <fo:block font-size="9pt" margin-right="10px">Suburb, City or Town</fo:block>
                  <fo:block border="solid thin black" margin-right="10px">
                    &nbsp;
                    <xsl:value-of select="EXTRACT/APPLICATION[@row = '1']/POSTALSUBURB"/>
                  </fo:block>
                </fo:table-cell>
                <fo:table-cell>
                  <fo:block font-size="9pt" margin-right="10px">State</fo:block>
                  <fo:block border="solid thin black" margin-right="10px">
                    &nbsp;
                    <xsl:value-of select="EXTRACT/APPLICATION[@row = '1']/POSTALSTATE"/>
                  </fo:block>
                </fo:table-cell>
                <fo:table-cell>
                  <fo:block font-size="9pt" margin-right="10px">Postcode</fo:block>
                  <fo:block border="solid thin black" margin-right="10px">
                    &nbsp;
                    <xsl:value-of select="EXTRACT/APPLICATION[@row = '1']/POSTALPOSTCODE"/>
                  </fo:block>
                </fo:table-cell>
              </fo:table-row>
            </fo:table-body>
          </fo:table>
          
          <fo:block font-size="11pt" space-after="6pt" font-weight="bold">
            C. Telephone Details:
          </fo:block>
          
          <fo:table padding-after="5px">
            <fo:table-column column-width="20%" />
            <fo:table-column column-width="30%" />
            <fo:table-column column-width="20%" />
            <fo:table-column column-width="30%" />
            <fo:table-body>
              <fo:table-row>
                <fo:table-cell>
                  <fo:block font-size="9pt" margin-right="10px">Daytime Number (include area code)</fo:block>
                </fo:table-cell>
                <fo:table-cell>
                  <fo:block border="solid thin black" margin-right="10px">
                    <xsl:variable name="homePhone"><xsl:value-of select="EXTRACT/APPLICATION[@row = '1']/HOMEPHONE"/></xsl:variable>
                    <xsl:variable name="workPhone"><xsl:value-of select="EXTRACT/APPLICATION[@row = '1']/WORKPHONE"/></xsl:variable>
                    &nbsp;
                    <xsl:if test="$homePhone">
                      <xsl:value-of select="$homePhone"/>
                    </xsl:if>
                    <xsl:if test="$homePhone and $workPhone">
                      ,<fo:block/>
                    </xsl:if>
                    <xsl:if test="$workPhone">
                      <xsl:value-of select="$workPhone"/>
                    </xsl:if>
                  </fo:block>
                </fo:table-cell>
                <fo:table-cell>
                  <fo:block font-size="9pt" margin-right="10px">Contact Name</fo:block>
                </fo:table-cell>
                <fo:table-cell>
                  <fo:block border="solid thin black" margin-right="10px">
                    &nbsp;
                    <xsl:value-of select="EXTRACT/APPLICATION[@row = '1']/CONTACTFIRSTNAME"/>
                    <xsl:text>&#x20;</xsl:text> 
                    <xsl:value-of select="EXTRACT/APPLICATION[@row = '1']/CONTACTLASTNAME"/>
                  </fo:block>
                </fo:table-cell>
              </fo:table-row>
            </fo:table-body>
          </fo:table>
          
          <fo:block font-size="11pt" space-after="6pt" font-weight="bold">
            D. Bank Account Details (for direct credit of funds to your account):
          </fo:block>
          
          <fo:block font-size="11pt" space-after="6pt">
            I/We request that payments due to me/us by UBS be deposited directly into the following account. I/We acknowledge
            that these instructions supersede and have priority over all previous instructions, but will only apply in respect of the Units
            issued pursuant to the PDS dated 27 June 2007. Unless advised in writing or otherwise, I/we acknowledge that all future
            payments due to me/us will be paid into the nominated account.
          </fo:block>
          
          <fo:table padding-after="5px">
            <fo:table-column column-width="45%" />
            <fo:table-column column-width="20%" />
            <fo:table-column column-width="35%" />
            <fo:table-body>
              <fo:table-row>
                <fo:table-cell>
                  <fo:block font-size="9pt" margin-right="10px">Bank / Financial Institution Name</fo:block>
                  <fo:block border="solid thin black" margin-right="10px">
                    &nbsp;
                    <xsl:value-of select="EXTRACT/APPLICATION[@row = '1']/DDINSTITUTION"/>
                  </fo:block>
                </fo:table-cell>
                <fo:table-cell>
                  <fo:block font-size="9pt" margin-right="10px">BSB</fo:block>
                  <fo:block border="solid thin black" margin-right="10px">
                    &nbsp;
                    <xsl:value-of select="substring (EXTRACT/APPLICATION/DDBSB, 1, 3)"/>
                    -
                    <xsl:value-of select="substring (EXTRACT/APPLICATION/DDBSB, 4, 3)"/>
                  </fo:block>
                </fo:table-cell>
                <fo:table-cell>
                  <fo:block font-size="9pt" margin-right="10px">Account Number</fo:block>
                  <fo:block border="solid thin black" margin-right="10px">
                    &nbsp;
                    <xsl:value-of select="EXTRACT/APPLICATION/DDACCOUNTNO"/>
                  </fo:block>
                </fo:table-cell>
              </fo:table-row>
            </fo:table-body>
          </fo:table>
          <fo:table padding-after="5px">
            <fo:table-column column-width="55%" />
            <fo:table-column column-width="45%" />
            <fo:table-body>
              <fo:table-row>
                <fo:table-cell>
                  <fo:block font-size="9pt" margin-right="10px">Account Name</fo:block>
                  <fo:block border="solid thin black" margin-right="10px">
                    &nbsp;
                    <xsl:value-of select="EXTRACT/APPLICATION/DDACCOUNTNAME"/>
                  </fo:block>
                </fo:table-cell>
                <fo:table-cell>
                  <fo:block font-size="9pt" margin-right="10px">Name of Branch / Suburb</fo:block>
                  <fo:block border="solid thin black" margin-right="10px">
                    &nbsp;
                    <xsl:value-of select="EXTRACT/APPLICATION/DDINSTITUTIONADDRESS"/>,
                    <xsl:value-of select="EXTRACT/APPLICATION/DDINSTITUTIONSUBURB"/>,
                    <xsl:value-of select="EXTRACT/APPLICATION/DDINSTITUTIONPOSTCODE"/>,
                    <xsl:value-of select="EXTRACT/APPLICATION/DDINSTITUTIONSTATE"/>
                  </fo:block>
                </fo:table-cell>
              </fo:table-row>
            </fo:table-body>
          </fo:table>
          <fo:table padding-after="5px">
            <fo:table-column column-width="40%" />
            <fo:table-column column-width="20%" />
            <fo:table-column column-width="30%" />
            <fo:table-body>
              <fo:table-row>
                <fo:table-cell>
                  <fo:block font-size="9pt" margin-right="10px">Type of account (Units: do NOT use your credit card number)</fo:block>
                  <fo:block border="solid thin black" margin-right="10px">&nbsp;<xsl:value-of select="EXTRACT/APPLICATION[@row = '1']/DDACCOUNTTYPE"/></fo:block>
                </fo:table-cell>
                <fo:table-cell>
                  <fo:block/>
                </fo:table-cell>
                <fo:table-cell>
                  <fo:block/>
                </fo:table-cell>
              </fo:table-row>
            </fo:table-body>
          </fo:table>
          
          <fo:block font-size="11pt" space-after="6pt" font-weight="bold">
            E. Details of the Units to be purchased:
          </fo:block>
          
          <xsl:variable name="totalInvestmentAmount" select="EXTRACT/APPLICATION/APPLICATIONAMOUNT01 + EXTRACT/APPLICATION/APPLICATIONAMOUNT02 + EXTRACT/APPLICATION/APPLICATIONAMOUNT03"/>
          <fo:table padding-after="5px" border-collapse="collapse">
            <fo:table-column column-width="40%" />
            <fo:table-column column-width="20%" />
            <fo:table-column column-width="20%" />
            <fo:table-column column-width="20%" />
            <fo:table-body>
              <fo:table-row>
                <fo:table-cell border-top="thick solid black" padding-top="3px" padding-bottom="3px" border-bottom="thin solid black">
                  <fo:block font-size="11pt" margin-right="10px" font-weight="bold">Investment</fo:block>
                </fo:table-cell>
                <fo:table-cell border-top="thick solid black" padding-top="3px" padding-bottom="3px" border-bottom="thin solid black">
                  <fo:block font-size="11pt" margin-right="10px" text-align="center" font-weight="bold">(i) Investment Amount per Unit</fo:block>
                </fo:table-cell>
                <fo:table-cell border-top="thick solid black" padding-top="3px" padding-bottom="3px" border-bottom="thin solid black">
                  <fo:block font-size="11pt" margin-right="10px" text-align="center" font-weight="bold">(ii) Number to be Purchased (Minimum 10,000)</fo:block>
                </fo:table-cell>
                <fo:table-cell border-top="thick solid black" padding-top="3px" padding-bottom="3px" border-bottom="thin solid black">
                  <fo:block font-size="11pt" margin-right="10px" text-align="center" font-weight="bold">(iii) Total Investment Amount Payable</fo:block>
                </fo:table-cell>
              </fo:table-row>
              <fo:table-row>
                <fo:table-cell padding-top="3px" padding-bottom="3px" border-bottom="thick solid black">
                  <fo:block font-size="11pt" margin-right="10px">Call Ups – Series 6 - Infrastructure &amp; Environment Basket</fo:block>
                </fo:table-cell>
                <fo:table-cell padding-top="3px" padding-bottom="3px" border-bottom="thick solid black">
                  <fo:block font-size="11pt" margin-right="10px" text-align="center">$1.00 AUD</fo:block>
                </fo:table-cell>
                <fo:table-cell padding-top="3px" padding-bottom="3px" border-bottom="thick solid black">
                  <fo:block font-size="11pt" margin-right="10px" text-align="center">
                    $<xsl:value-of select="format-number($totalInvestmentAmount, '#,##0')"/> AUD
                  </fo:block>
                </fo:table-cell>
                <fo:table-cell padding-top="3px" padding-bottom="3px" border-bottom="thick solid black">
                  <fo:block font-size="11pt" margin-right="10px" text-align="center">
                    $<xsl:value-of select="format-number($totalInvestmentAmount, '#,##0')"/> AUD
                  </fo:block>
                </fo:table-cell>
              </fo:table-row>
            </fo:table-body>
          </fo:table>
          
          <fo:block font-size="11pt" space-after="6pt" font-weight="bold">
            F. Details of Approved Adviser:
          </fo:block>
          
          <fo:table padding-after="5px">
            <fo:table-column column-width="100%"/>
            <fo:table-body>
              <fo:table-row>
                <fo:table-cell>
                  <fo:block font-size="9pt" margin-right="10px">Name of Approved Adviser Full Name/Company Name:</fo:block>
                  <fo:block border="solid thin black" margin-right="10px">
                    &nbsp;
                    <xsl:value-of select="EXTRACT/APPLICATION/ADVISORFIRSTNAME"/>
                    <xsl:text>&#x20;</xsl:text> 
                    <xsl:value-of select="EXTRACT/APPLICATION/ADVISORLASTNAME"/>
                    /
                    <xsl:value-of select="EXTRACT/APPLICATION/ADVISORCOMPANYNAME"/>
                  </fo:block>
                </fo:table-cell>
              </fo:table-row>
            </fo:table-body>
          </fo:table>
          
          <fo:block font-size="11pt" space-after="6pt" font-weight="bold">
            G. Address Details:
          </fo:block>
          
          <fo:table padding-after="5px">
            <fo:table-column column-width="100%" />
            <fo:table-body>
              <fo:table-row>
                <fo:table-cell>
                  <fo:block font-size="9pt" margin-right="10px">Number and Street</fo:block>
                  <fo:block border="solid thin black" margin-right="10px">
                    &nbsp;
                    <xsl:value-of select="EXTRACT/APPLICATION/ADVISORADDRESS1"/>
                    <xsl:if test="EXTRACT/APPLICATION/ADVISORADDRESS2 != ''">
                      ,
                      <xsl:value-of select="EXTRACT/APPLICATION/ADVISORADDRESS2"/>
                    </xsl:if>
                  </fo:block>
                </fo:table-cell>
              </fo:table-row>
            </fo:table-body>
          </fo:table>
          <fo:table padding-after="5px">
            <fo:table-column column-width="50%" />
            <fo:table-column column-width="25%" />
            <fo:table-column column-width="25%" />
            <fo:table-body>
              <fo:table-row>
                <fo:table-cell>
                  <fo:block font-size="9pt" margin-right="10px">Suburb, City or Town</fo:block>
                  <fo:block border="solid thin black" margin-right="10px">
                    &nbsp;
                    <xsl:value-of select="EXTRACT/APPLICATION/ADVISORSUBURB"/>
                  </fo:block>
                </fo:table-cell>
                <fo:table-cell>
                  <fo:block font-size="9pt" margin-right="10px">State</fo:block>
                  <fo:block border="solid thin black" margin-right="10px">
                    &nbsp;
                    <xsl:value-of select="EXTRACT/APPLICATION/ADVISORSTATE"/>
                  </fo:block>
                </fo:table-cell>
                <fo:table-cell>
                  <fo:block font-size="9pt" margin-right="10px">Postcode</fo:block>
                  <fo:block border="solid thin black" margin-right="10px">
                    &nbsp;
                    <xsl:value-of select="EXTRACT/APPLICATION/ADVISORPOSTCODE"/>
                  </fo:block>
                </fo:table-cell>
              </fo:table-row>
            </fo:table-body>
          </fo:table>
  
          <fo:list-block>
            <fo:list-item>
              <fo:list-item-label>
                <fo:block>1.</fo:block>
              </fo:list-item-label>
              <fo:list-item-body start-indent="1cm" >
                <fo:block>
                  BY THIS POWER OF ATTORNEY, I/we irrevocably appoint for valuable consideration UBS, its related bodies
                  corporate and each of their respective employees whose title includes the word &quot;director&quot; jointly, and each of
                  them severally as my/our true and lawful attorney to do:
                  <fo:list-block>
                    <fo:list-item start-indent="1cm">
                      <fo:list-item-label>
                        <fo:block>(a)</fo:block>
                      </fo:list-item-label>
                      <fo:list-item-body start-indent="2cm">
                        <fo:block>
                          everything necessary or expedient to bind me/us to the Terms, complete any blanks in the Terms and
                          date and execute the Terms on my/our behalf;
                        </fo:block>
                      </fo:list-item-body>
                    </fo:list-item>
                    <fo:list-item start-indent="1cm">
                      <fo:list-item-label>
                        <fo:block>(b)</fo:block>
                      </fo:list-item-label>
                      <fo:list-item-body start-indent="2cm">
                        <fo:block>
                          anything which I/we must do under or in relation to the Terms or any other agreement or arrangement
                          between me/us and UBS relating to the Units (including arranging physical delivery of the Delivery
                          Assets or acting in accordance with the Agency Sale Arrangement); and
                        </fo:block>
                      </fo:list-item-body>
                    </fo:list-item>
                    <fo:list-item start-indent="1cm">
                      <fo:list-item-label>
                        <fo:block>(c)</fo:block>
                      </fo:list-item-label>
                      <fo:list-item-body start-indent="2cm">
                        <fo:block>
                          anything incidental or necessary in relation to the above (including, but not limited to, completing any
                          blanks in this Investor Application Form and appointing any person as sub-attorney to do any of the
                          above).
                        </fo:block>
                      </fo:list-item-body>
                    </fo:list-item>
                  </fo:list-block>
                </fo:block>
              </fo:list-item-body>
            </fo:list-item>
            <fo:list-item>
              <fo:list-item-label>
                <fo:block>2.</fo:block>
              </fo:list-item-label>
              <fo:list-item-body start-indent="1cm">
                <fo:block>
                  I/We indemnify the attorney against all claims, losses, damages and expenses suffered or incurred as a result of 
                  anything done under this power of attorney.
                </fo:block>
              </fo:list-item-body>
            </fo:list-item>
            <fo:list-item>
              <fo:list-item-label>
                <fo:block>3.</fo:block>
              </fo:list-item-label>
              <fo:list-item-body start-indent="1cm">
                <fo:block>
                  I/We have read and understood, and agree to accept the Units on the 
                  Terms relevant to my/our Units. In particular, I/we:
                  <fo:list-block>
                    <fo:list-item start-indent="1cm">
                      <fo:list-item-label>
                        <fo:block>(a)</fo:block>
                      </fo:list-item-label>
                      <fo:list-item-body start-indent="2cm">
                        <fo:block>
                          acknowledge that by signing this Investor Application Form and 
                          arranging for the Approved Adviser to lodge it with UBS:
                        </fo:block>
                        <fo:block>
                          (i) the Approved Adviser, as my/our agent, will forward this Investor 
                          Application Form to UBS for the number of Units set out in this 
                          Investor Application Form; and
                        </fo:block>
                        <fo:block>
                          (ii) UBS may, in its absolute discretion, accept or reject my/our 
                          Application;
                        </fo:block>
                      </fo:list-item-body>
                    </fo:list-item>
                    <fo:list-item start-indent="1cm">
                      <fo:list-item-label>
                        <fo:block>(b)</fo:block>
                      </fo:list-item-label>
                      <fo:list-item-body start-indent="2cm">
                        <fo:block>
                          acknowledge that I/we received a complete copy/print-out of the PDS 
                          accompanied by this Investor Application Form before I/we completed 
                          this Investor Application Form;
                        </fo:block>
                      </fo:list-item-body>
                    </fo:list-item>
                    <fo:list-item start-indent="1cm">
                      <fo:list-item-label>
                        <fo:block>(c)</fo:block>
                      </fo:list-item-label>
                      <fo:list-item-body start-indent="2cm">
                        <fo:block>
                          agree to be bound by the Terms set out in the PDS;
                        </fo:block>
                      </fo:list-item-body>
                    </fo:list-item>
                    <fo:list-item start-indent="1cm">
                      <fo:list-item-label>
                        <fo:block>(d)</fo:block>
                      </fo:list-item-label>
                      <fo:list-item-body start-indent="2cm">
                        <fo:block>
                          acknowledge that neither UBS nor any of its related entities have 
                          provided any tax advice or otherwise made any representations regarding 
                          the tax consequences of an application for or an investment in Units;
                        </fo:block>
                      </fo:list-item-body>
                    </fo:list-item>
                    <fo:list-item start-indent="1cm">
                      <fo:list-item-label>
                        <fo:block>(e)</fo:block>
                      </fo:list-item-label>
                      <fo:list-item-body start-indent="2cm">
                        <fo:block>
                          acknowledge that to the extent I/we deem appropriate, I/we have or 
                          will obtain my/our own financial and taxation advice from an 
                          independent professional adviser; and
                        </fo:block>
                      </fo:list-item-body>
                    </fo:list-item>
                    <fo:list-item start-indent="1cm">
                      <fo:list-item-label>
                        <fo:block>(f)</fo:block>
                      </fo:list-item-label>
                      <fo:list-item-body start-indent="2cm">
                        <fo:block>
                          waive and agree not to assert any claim against UBS or any of its
                          related entities with respect to the tax aspects of this investment 
                          in Units.
                        </fo:block>
                      </fo:list-item-body>
                    </fo:list-item>
                  </fo:list-block>
                </fo:block>
              </fo:list-item-body>
            </fo:list-item>
            <fo:list-item>
              <fo:list-item-label>
                <fo:block>4.</fo:block>
              </fo:list-item-label>
              <fo:list-item-body start-indent="1cm">
                <fo:block>
                 Where bank account details have not been provided to enable direct credit of funds to my/our account, I/we
                 acknowledge that I/we will receive any cash payments by cheque. I/we acknowledge that UBS may impose a
                 charge reflecting the cost of processing cheque payments, provided UBS gives prior notice to me/us of its
                 intention to impose such a charge. Neither UBS nor the Registrar will be responsible for any delays in crediting
                 funds to my/our nominated account as a result of transaction procedures or errors by any financial institution.
                </fo:block>
              </fo:list-item-body>
            </fo:list-item>
            <fo:list-item>
              <fo:list-item-label>
                <fo:block>5.</fo:block>
              </fo:list-item-label>
              <fo:list-item-body start-indent="1cm">
                <fo:block>
                 I/We agree to accept the issue of the Units specified above subject to the same conditions. I/We have not
                 received any notice of revocation of the Power of Attorney under which the transfer is signed, by death of the
                 grantor or otherwise.
                </fo:block>
              </fo:list-item-body>
            </fo:list-item>
            <fo:list-item>
              <fo:list-item-label>
                <fo:block>6.</fo:block>
              </fo:list-item-label>
              <fo:list-item-body start-indent="1cm">
                <fo:block>
                 I am/we are not bankrupt or insolvent (as the case may be) and am/are able to pay my/our debts as and when
                 they become due and that no step has been taken to make me/us bankrupt or commence winding up
                 proceedings, appoint a controller or administrator, seize or take possession of any of my/our assets or make an
                 arrangement, compromise or composition with any of my/our creditors.
                </fo:block>
              </fo:list-item-body>
            </fo:list-item>
            <fo:list-item>
              <fo:list-item-label>
                <fo:block>7.</fo:block>
              </fo:list-item-label>
              <fo:list-item-body start-indent="1cm">
                <fo:block>
                 I/we have read and understood the Terms and make all the representations and warranties contained in clause
                 11 of the Deferred Purchase Agreement.
                </fo:block>
              </fo:list-item-body>
            </fo:list-item>
            <fo:list-item>
              <fo:list-item-label>
                <fo:block>8.</fo:block>
              </fo:list-item-label>
              <fo:list-item-body start-indent="1cm">
                <fo:block>
                 If I am/we are acting as trustee in relation to the holding of the Units, I/we represent and warrant that I/we have
                 all the power, authority and discretion vested as trustee to apply for and hold the Units;
                </fo:block>
              </fo:list-item-body>
            </fo:list-item>
            <fo:list-item>
              <fo:list-item-label>
                <fo:block>9.</fo:block>
              </fo:list-item-label>
              <fo:list-item-body start-indent="1cm">
                <fo:block>
                 I/we will not offer, sell, re-sell or deliver, directly or indirectly, any Units so purchased in any overseas jurisdiction
                 or to any foreign persons, or for the account or benefit of any such foreign person, or to others for the offering,
                 sale or re-sale or delivery in any overseas jurisdiction or to any such foreign persons where that offer, sale, resale
                 or delivery would be in breach of any Australian or foreign law.
                </fo:block>
              </fo:list-item-body>
            </fo:list-item>
            <fo:list-item>
              <fo:list-item-label>
                <fo:block>10.</fo:block>
              </fo:list-item-label>
              <fo:list-item-body start-indent="1cm">
                <fo:block>
                 I/we acknowledge that the Call Ups are not a deposit obligation of UBS AG and is subject to investment risks,
                 including the possible loss of the Investment Amount invested, in the event of Early Maturity or UBS Buy-Back.
                </fo:block>
              </fo:list-item-body>
            </fo:list-item>
            <fo:list-item>
              <fo:list-item-label>
                <fo:block>11.</fo:block>
              </fo:list-item-label>
              <fo:list-item-body start-indent="1cm">
                <fo:block>
                 I/we acknowledge that I/we have read and understood the declarations set out above in this Investor Application
                 Form, and by returning the Investor Application Form together with my/our payment for the Investment
                 Amount, I/we agree to be bound by them and make the declarations contained therein. I/we agree to
                 indemnify UBS and any of its related bodies corporate against any loss, liability, damage, claim, cost or expense
                 incurred as a result, directly or indirectly, of any such declaration set out in this Investor Application Form
                 proving to be untrue or incorrect.
                </fo:block>
              </fo:list-item-body>
            </fo:list-item>
            <fo:list-item>
              <fo:list-item-label>
                <fo:block>12.</fo:block>
              </fo:list-item-label>
              <fo:list-item-body start-indent="1cm">
                <fo:block>
                 I/we have read and understood the Privacy Policy in Section 11 of this PDS and agree that information about
                 me/us written on this form will not be collected, used or disclosed for any purpose other than for the purposes
                 stated in the PDS. Where I/we have provided information about any other individual, I/we will make that
                 individual aware of the provisions of the privacy statement.
                </fo:block>
              </fo:list-item-body>
            </fo:list-item>
            <fo:list-item>
              <fo:list-item-label>
                <fo:block>13.</fo:block>
              </fo:list-item-label>
              <fo:list-item-body start-indent="1cm">
                <fo:block>
                 I/we agree that UBS may disclose personal information about me/us to my/our Approved Adviser or other adviser
                 and that once UBS provides information to my/our Approved Adviser or other adviser, UBS can no longer
                 control the ways in which that information is used and I/we agree that UBS is not liable for any loss, expense,
                 damage, or claim directly or indirectly connected with any disclosure of information by UBS to my/our Approved
                 Adviser or other adviser, except to the extent required by law.
                </fo:block>
              </fo:list-item-body>
            </fo:list-item>
          </fo:list-block>
          
          <fo:block space-after="6pt">
            UBS or your Approved Adviser and/or its associates may wish to communicate with you in the future about other
            investment opportunities that may be of interest. Please tick this box if you do NOT wish to be contacted for this
            purpose.
          </fo:block>
  
          <xsl:call-template name="checkBoxItem">
            <xsl:with-param name="text">No thanks, I/we prefer NOT to be contacted about investment opportunities in the future.</xsl:with-param>
          </xsl:call-template>
  
          <fo:block margin-left="20pt">
            <fo:block font-weight="bold" text-transform="capitalize" padding-before="20pt" padding-after="20pt">
              DATED: ______________________________
            </fo:block>
            
            <fo:block padding-after="5pt">
              SIGNED, SEALED AND DELIVERED by:
            </fo:block>
          </fo:block>
  
          <xsl:choose>
            <xsl:when test="$individualApplication or $jointApplication or $privateTrustApplication">
              <!-- 
              <fo:block margin-left="20pt">
                <fo:block margin-left="35pt" font-weight="bold">
                  (Individual Buyer)
                </fo:block>
              </fo:block>
              -->
              
              <fo:table padding-before="30pt">
                <fo:table-column column-width="50%" />
                <fo:table-column column-width="50%" />
                <fo:table-body>
                  <fo:table-row>
                    <fo:table-cell>
                      <fo:block padding-top="3px" margin-left="20pt" margin-right="5px" padding-left="5pt">
                        &nbsp;
                      </fo:block>
                      <fo:block border-top="thin solid black" padding-bottom="30pt" padding-top="3px" margin-left="20pt" padding-left="35pt" margin-right="5px">
                        First Buyer's Signature
                      </fo:block>
                      <fo:block padding-top="3px" margin-left="20pt" margin-right="5px" padding-left="35pt">
                        <xsl:variable name="firstBuyer" select="EXTRACT/APPLICANT[@row = '1']"/>
                        <xsl:value-of select="$firstBuyer/FIRSTNAME"/>
                        <xsl:if test="$firstBuyer/MIDDLENAME"><xsl:text>&#x20;</xsl:text> </xsl:if>
                        <xsl:value-of select="$firstBuyer/MIDDLENAME"/>
                        <xsl:if test="$firstBuyer/LASTNAME"><xsl:text>&#x20;</xsl:text> </xsl:if>
                        <xsl:value-of select="$firstBuyer/LASTNAME"/>
                      </fo:block>
                      <fo:block border-top="thin solid black" padding-bottom="30pt" padding-top="3px" margin-left="20pt" padding-left="35pt" margin-right="5px">
                        First Buyer's Name
                      </fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                      <fo:block padding-top="3px" padding-left="35pt" margin-left="5px">
                        &nbsp;
                      </fo:block>
                      <fo:block border-top="thin solid black" padding-bottom="30pt" padding-top="3px" padding-left="35pt" margin-left="5px">
                        Second Buyer's Signature (if applicable)
                      </fo:block>
                      <fo:block padding-top="3px" padding-left="35pt" margin-left="5px">
                        <xsl:if test="EXTRACT/APPLICANT[@row = '2']">
                          <xsl:variable name="secondBuyer" select="EXTRACT/APPLICANT[@row = '2']"/>
                          <xsl:value-of select="$secondBuyer/FIRSTNAME"/>
                          <xsl:if test="$secondBuyer/MIDDLENAME"><xsl:text>&#x20;</xsl:text> </xsl:if>
                          <xsl:value-of select="$secondBuyer/MIDDLENAME"/>
                          <xsl:if test="$secondBuyer/LASTNAME"><xsl:text>&#x20;</xsl:text> </xsl:if>
                          <xsl:value-of select="$secondBuyer/LASTNAME"/>
                        </xsl:if>
                        <xsl:if test="not(EXTRACT/APPLICANT[@row = '2'])">
                          &nbsp;
                        </xsl:if>
                      </fo:block>
                      <fo:block border-top="thin solid black" padding-bottom="30pt" padding-top="3px" padding-left="35pt" margin-left="5px">
                        Second Buyer's Name (if applicable)
                      </fo:block>
                    </fo:table-cell>
                  </fo:table-row>
                </fo:table-body>
              </fo:table>
            </xsl:when>
            <xsl:otherwise>
              <!-- 
              <fo:block margin-left="20pt">
                <fo:block margin-left="35pt" font-weight="bold">
                  (Company Buyer)
                </fo:block>
              </fo:block>
              -->
              <fo:table padding-before="30pt">
                <fo:table-column column-width="45%" />
                <fo:table-column column-width="25%" />
                <fo:table-column column-width="30%" />
                <fo:table-body>
                  <fo:table-row>
                    <fo:table-cell>
                      <fo:block padding-top="3px" margin-left="20pt" margin-right="-20pt" padding-left="35pt" padding-right="45pt">
                        &nbsp;<xsl:value-of select="EXTRACT/APPLICATION[@row = '1']/COMPANYNAME"/>
                      </fo:block>
                      <fo:block border-top="thin solid black" padding-bottom="30pt" padding-top="3px" margin-left="20pt" margin-right="-20pt" padding-left="35pt" padding-right="45pt">
                        Executed by (insert name of company) in accordance with the Corporations Act:
                      </fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                      <fo:block padding-top="3px" margin-left="20pt" margin-right="-20pt" padding-left="10pt" padding-right="10pt">
                        &nbsp;
                        <!-- removed this section for now.  leave blank for their signatures instead.
                        <xsl:choose>
                          <xsl:when test="EXTRACT/APPLICANT[ISDIRECTOR = 'true' and ISSOLEDIRECTOR = 'true']">
                            <!- -  only one director. - ->
                            <xsl:variable name="secretary" select="EXTRACT/APPLICANT[ISDIRECTOR = 'true' and ISSOLEDIRECTOR = 'true']"/>
                            <xsl:value-of select="$secretary/FIRSTNAME"/>
                            <xsl:if test="$secretary/MIDDLENAME"><xsl:text>&#x20;</xsl:text> </xsl:if>
                            <xsl:value-of select="$secretary/MIDDLENAME"/>
                            <xsl:if test="$secretary/LASTNAME"><xsl:text>&#x20;</xsl:text> </xsl:if>
                            <xsl:value-of select="$secretary/LASTNAME"/>
                          </xsl:when>
                          <xsl:when test="EXTRACT/APPLICANT/ISCOMPANYSECRETARY = 'true'">
                            <!- -  there is a secretary. - ->
                            <xsl:variable name="secretary" select="EXTRACT/APPLICANT[ISCOMPANYSECRETARY = 'false' and ISDIRECTOR = 'true']"/>
                            <xsl:value-of select="$secretary/FIRSTNAME"/>
                            <xsl:if test="$secretary/MIDDLENAME"><xsl:text>&#x20;</xsl:text> </xsl:if>
                            <xsl:value-of select="$secretary/MIDDLENAME"/>
                            <xsl:if test="$secretary/LASTNAME"><xsl:text>&#x20;</xsl:text> </xsl:if>
                            <xsl:value-of select="$secretary/LASTNAME"/>
                          </xsl:when>
                          <xsl:otherwise>
                            <!- -  normal scenario:  two or more directors - ->
                            <xsl:variable name="secretary" select="EXTRACT/APPLICANT[ISDIRECTOR = 'true']"/>
                            <xsl:value-of select="$secretary/FIRSTNAME"/>
                            <xsl:if test="$secretary/MIDDLENAME"><xsl:text>&#x20;</xsl:text> </xsl:if>
                            <xsl:value-of select="$secretary/MIDDLENAME"/>
                            <xsl:if test="$secretary/LASTNAME"><xsl:text>&#x20;</xsl:text> </xsl:if>
                            <xsl:value-of select="$secretary/LASTNAME"/>
                          </xsl:otherwise>
                        </xsl:choose>
                        -->
                      </fo:block>
                      <fo:block border-top="thin solid black" padding-bottom="30pt" padding-top="3px" margin-left="20pt" margin-right="-20pt" padding-left="35pt" padding-right="35pt">
                        Director/Secretary
                      </fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                      <fo:block padding-top="3px" margin-left="20pt" margin-right="-20pt" padding-left="10pt" padding-right="-10pt">
                        &nbsp;
                        <!-- removed this section for now.  leave blank for their signatures instead.
                        <xsl:choose>
                          <xsl:when test="EXTRACT/APPLICANT[ISDIRECTOR = 'true' and ISSOLEDIRECTOR = 'true']">
                            <!- -  only one director. - ->
                            &nbsp;
                          </xsl:when>
                          <xsl:when test="EXTRACT/APPLICANT/ISCOMPANYSECRETARY = 'true'">
                            <!- -  there is a secretary. - ->
                            <xsl:variable name="secretary" select="EXTRACT/APPLICANT[ISCOMPANYSECRETARY = 'false' and ISDIRECTOR = 'true']"/>
                            <xsl:value-of select="$secretary/FIRSTNAME"/>
                            <xsl:if test="$secretary/MIDDLENAME"><xsl:text>&#x20;</xsl:text> </xsl:if>
                            <xsl:value-of select="$secretary/MIDDLENAME"/>
                            <xsl:if test="$secretary/LASTNAME"><xsl:text>&#x20;</xsl:text> </xsl:if>
                            <xsl:value-of select="$secretary/LASTNAME"/>
                          </xsl:when>
                          <xsl:otherwise>
                            <!- -  normal scenario:  two or more directors - ->
                            <xsl:variable name="secretaryRow" select="EXTRACT/APPLICANT[ISDIRECTOR = 'true']/@row"/>
                            <xsl:variable name="director" select="EXTRACT/APPLICANT[ISDIRECTOR = 'true' and number(@row) != number($secretaryRow)]"/>
                            <xsl:value-of select="$director/FIRSTNAME"/>
                            <xsl:if test="$director/MIDDLENAME"><xsl:text>&#x20;</xsl:text> </xsl:if>
                            <xsl:value-of select="$director/MIDDLENAME"/>
                            <xsl:if test="$director/LASTNAME"><xsl:text>&#x20;</xsl:text> </xsl:if>
                            <xsl:value-of select="$director/LASTNAME"/>
                          </xsl:otherwise>
                        </xsl:choose>
                        -->
                      </fo:block>
                      <fo:block border-top="thin solid black" padding-bottom="30pt" padding-top="3px" margin-left="20pt" padding-left="35pt">
                        Director
                      </fo:block>
                    </fo:table-cell>
                  </fo:table-row>
                </fo:table-body>
              </fo:table>
            </xsl:otherwise>
          </xsl:choose>
          
          <fo:block margin-left="20pt">
            <fo:block margin-left="35pt" font-weight="bold">
              (Power of Attorney)
            </fo:block>
          </fo:block>
        
          <fo:table padding-before="30pt">
            <fo:table-column column-width="45%" />
            <fo:table-column column-width="25%" />
            <fo:table-column column-width="30%" />
            <fo:table-body>
              <fo:table-row>
                <fo:table-cell>
                  <fo:block border-top="thin solid black" padding-bottom="30pt" padding-top="3px" margin-left="20pt" margin-right="-20pt" padding-left="35pt" padding-right="45pt">
                    Executed by and on behalf of (insert name of company) by its attorney in the presence of:
                  </fo:block>
                </fo:table-cell>
                <fo:table-cell>
                  <fo:block border-top="thin solid black" padding-bottom="30pt" padding-top="3px" margin-left="20pt" margin-right="-20pt" padding-left="35pt" padding-right="35pt">
                    Attorney Signature
                  </fo:block>
                </fo:table-cell>
                <fo:table-cell>
                  <fo:block border-top="thin solid black" padding-bottom="30pt" padding-top="3px" margin-left="20pt" padding-left="35pt">
                    Attorney Name
                  </fo:block>
                </fo:table-cell>
              </fo:table-row>
            </fo:table-body>
          </fo:table>
          <fo:table padding-before="20pt">
            <fo:table-column column-width="45%" />
            <fo:table-column column-width="25%" />
            <fo:table-column column-width="30%" />
            <fo:table-body>
              <fo:table-row>
                <fo:table-cell>
                  <fo:block border-top="thin solid black" padding-bottom="30pt" padding-top="3px" margin-left="20pt" margin-right="-20pt" padding-left="35pt" padding-right="45pt">
                    Witness Signature
                  </fo:block>
                </fo:table-cell>
                <fo:table-cell>
                  <fo:block border-top="thin solid black" padding-bottom="30pt" padding-top="3px" margin-left="20pt" margin-right="-20pt" padding-left="35pt" padding-right="35pt">
                    Witness Name
                  </fo:block>
                </fo:table-cell>
                <fo:table-cell>
                  <fo:block border-top="thin solid black" padding-bottom="30pt" padding-top="3px" margin-left="20pt" padding-left="35pt">
                    &nbsp;
                  </fo:block>
                </fo:table-cell>
              </fo:table-row>
            </fo:table-body>
          </fo:table>
        </fo:flow>
      </fo:page-sequence>
    </fo:root>
  </xsl:template>

  <xsl:template name="applicantDetails">
    <xsl:param name="firstName"/>
    <xsl:param name="middleName"/>
    <xsl:param name="lastName"/>
    <xsl:param name="dateOfBirth"/>
    <xsl:param name="occupation"/>
    <xsl:param name="address1"/>
    <xsl:param name="address2"/>
    
    <fo:table padding-after="5px" auto-restore="false" relative-align="baseline" keep-together.within-page="always">
      <fo:table-column column-width="33%"/>
      <fo:table-column column-width="33%" />
      <fo:table-column column-width="33%" />
      <fo:table-body>
        <fo:table-row>
          <fo:table-cell>
            <fo:block font-size="9pt">First Name</fo:block>
            <fo:block border="solid thin black" margin-right="5mm">&nbsp;<xsl:value-of select="$firstName"/></fo:block>
          </fo:table-cell>
          <fo:table-cell>
            <fo:block font-size="9pt">Middle Name</fo:block>
            <fo:block border="solid thin black" margin-right="5mm">&nbsp;<xsl:value-of select="$middleName"/></fo:block>
          </fo:table-cell>
          <fo:table-cell>
            <fo:block font-size="9pt">Last Name</fo:block>
            <fo:block border="solid thin black" margin-right="5mm">&nbsp;<xsl:value-of select="$lastName"/></fo:block>
          </fo:table-cell>
        </fo:table-row>
      </fo:table-body>
    </fo:table>
    
    <fo:table padding-after="5px" intrusion-displace="block">
      <fo:table-column column-width="40%" />
      <fo:table-column column-width="60%" />
      <fo:table-body>
        <fo:table-row>
          <fo:table-cell>
            <fo:block font-size="9pt">Date of Birth</fo:block>
            <fo:block border="solid thin black" margin-right="10px">
              &nbsp;
              <xsl:call-template name="formatDate"><xsl:with-param name="date" select="$dateOfBirth"/></xsl:call-template>
            </fo:block>
          </fo:table-cell>
          <fo:table-cell>
            <fo:block font-size="9pt">Occupation</fo:block>
            <fo:block border="solid thin black" margin-right="10px">&nbsp;<xsl:value-of select="$occupation"/></fo:block>
          </fo:table-cell>
        </fo:table-row>
      </fo:table-body>
    </fo:table>
    
    <fo:table padding-after="5px">
      <fo:table-column column-width="100%" />
      <fo:table-body>
        <fo:table-row>
          <fo:table-cell>
            <fo:block font-size="9pt" margin-right="10px">Residential Address (number and street; suburb, city or town; state; and postcode – <fo:inline font-weight="bold">Please note that PO Box is not accepted)</fo:inline></fo:block>
            <fo:block border="solid thin black" border-bottom-width="0px" margin-right="10px">&nbsp;<xsl:value-of select="$address1"/></fo:block>
            <fo:block border="solid thin black" margin-right="10px">&nbsp;<xsl:value-of select="$address2"/></fo:block>
          </fo:table-cell>
        </fo:table-row>
      </fo:table-body>
    </fo:table>
  </xsl:template>
  
  <xsl:template name="checkBoxItem">
    <xsl:param name="text"/>
    <fo:table space-after="1mm" table-layout="fixed">
      <fo:table-column column-width="1cm"/>
      <fo:table-column/>
      <fo:table-body display-align="center">
        <fo:table-row>
          <fo:table-cell>
            <fo:block>
              <fo:instream-foreign-object>
                <svg:svg width="4mm" height="4mm" xmlns:svg="http://www.w3.org/2000/svg">
                  <svg:rect x="2%" y="2%" width="95%" height="95%" stroke="#000000" stroke-width="1pt" fill="white"/>
                </svg:svg>
              </fo:instream-foreign-object>
            </fo:block>
          </fo:table-cell>
          <fo:table-cell><fo:block space-after="6pt"><xsl:copy-of select="$text"/></fo:block></fo:table-cell>
        </fo:table-row>
      </fo:table-body>
    </fo:table>
  </xsl:template>
  
  <xsl:template name="formatDate">
    <xsl:param name="date"/>
    <xsl:value-of select="substring-before (substring-after (substring-after ($date, '-'), '-'), ' ')"/>
    <xsl:text> </xsl:text>
    <xsl:variable name="month" select="substring-before (substring-after ($date, '-'), '-')"/>
    <xsl:choose>
      <xsl:when test="$month = '01'">January</xsl:when>
      <xsl:when test="$month = '02'">February</xsl:when>
      <xsl:when test="$month = '03'">March</xsl:when>
      <xsl:when test="$month = '04'">April</xsl:when>
      <xsl:when test="$month = '05'">May</xsl:when>
      <xsl:when test="$month = '06'">June</xsl:when>
      <xsl:when test="$month = '07'">July</xsl:when>
      <xsl:when test="$month = '08'">August</xsl:when>
      <xsl:when test="$month = '09'">September</xsl:when>
      <xsl:when test="$month = '10'">October</xsl:when>
      <xsl:when test="$month = '11'">November</xsl:when>
      <xsl:when test="$month = '12'">December</xsl:when>
    </xsl:choose>
    <xsl:text> </xsl:text>
    <xsl:value-of select="substring-before ($date, '-')"/>
  </xsl:template>
</xsl:stylesheet>

