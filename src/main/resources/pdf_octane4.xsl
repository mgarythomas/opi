<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE xsl:stylesheet [<!ENTITY nbsp "&#160;"> <!ENTITY bullet "&#x2022;">]>
<xsl:stylesheet version="1.0" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:variable name="environment" select="'OPI'"/>      <!-- either 'PIAF' or 'OPI' - note the nested quotes -->

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
    <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">

      <fo:layout-master-set>

        <fo:simple-page-master master-name="CoverPage" page-height="297mm" page-width="210mm" margin-top="10mm" margin-bottom="10mm" margin-left="15mm" margin-right="15mm">
          <fo:region-body margin-top="15mm" margin-bottom="20pt">
            <xsl:if test="$isDraft">
              <xsl:choose>
                <xsl:when test="$environment = 'PIAF'"><xsl:attribute name="background-image">Draft.jpg</xsl:attribute></xsl:when>
                <xsl:when test="$environment = 'OPI'"><xsl:attribute name="background-image">url('http://localhost/opi/images/Draft.jpg')</xsl:attribute></xsl:when>
              </xsl:choose>
              <xsl:attribute name="background-repeat">no-repeat</xsl:attribute>
              <xsl:attribute name="background-position-horizontal">center</xsl:attribute>
              <xsl:attribute name="background-position-vertical">center</xsl:attribute>
            </xsl:if>
          </fo:region-body>
          <fo:region-before extent="15mm"/>
          <fo:region-after extent="10pt"/>
        </fo:simple-page-master>
 
 	<fo:simple-page-master master-name="Letter" page-height="297mm" page-width="210mm" margin-top="10mm" margin-bottom="10mm" margin-left="15mm" margin-right="15mm">
          <fo:region-body margin-top="15mm" margin-bottom="20pt">
            <xsl:if test="$isDraft">
              <xsl:choose>
                <xsl:when test="$environment = 'PIAF'"><xsl:attribute name="background-image">Draft.jpg</xsl:attribute></xsl:when>
                <xsl:when test="$environment = 'OPI'"><xsl:attribute name="background-image">url('http://localhost/opi/images/Draft.jpg')</xsl:attribute></xsl:when>
              </xsl:choose>
              <xsl:attribute name="background-repeat">no-repeat</xsl:attribute>
              <xsl:attribute name="background-position-horizontal">center</xsl:attribute>
              <xsl:attribute name="background-position-vertical">center</xsl:attribute>
            </xsl:if>
          </fo:region-body>
          <fo:region-before extent="15mm"/>
          <fo:region-after extent="10pt"/>
        </fo:simple-page-master>

 	<fo:simple-page-master master-name="Normal" page-height="297mm" page-width="210mm" margin-top="10mm" margin-bottom="10mm" margin-left="15mm" margin-right="15mm">
          <fo:region-body margin-top="15mm" margin-bottom="20pt">
          </fo:region-body>
          <fo:region-before extent="15mm"/>
          <fo:region-after extent="10pt"/>
        </fo:simple-page-master>

      </fo:layout-master-set>

      <fo:page-sequence master-reference="CoverPage" force-page-count="no-force">

        <fo:static-content flow-name="xsl-region-before">
          <fo:block font-size="12pt" font-weight="bold" color="#004780" text-align="center">RBS <fo:inline color="gray">SWEATY</fo:inline> GLOBAL FUND</fo:block>
        </fo:static-content>

        <fo:static-content flow-name="xsl-region-after">
          <fo:table table-layout="fixed">
            <fo:table-column column-width="33%"/>
            <fo:table-column column-width="34%"/>
            <fo:table-column column-width="33%"/>
            <fo:table-body font-size="9pt" font-style="italic">
              <fo:table-row>
                <fo:table-cell text-align="left"><fo:block>RBS Sweaty Global Fund</fo:block></fo:table-cell>
                <fo:table-cell text-align="center"><fo:block><xsl:if test="$isDraft">Draft </xsl:if>Application Form</fo:block></fo:table-cell>
                <fo:table-cell text-align="right"><fo:block>Cover Page</fo:block></fo:table-cell>
              </fo:table-row>
            </fo:table-body>
          </fo:table>
        </fo:static-content>

        <fo:flow flow-name="xsl-region-body" font-size="9pt">

          <fo:block font-size="18pt" space-after="6pt">Account designation: <xsl:value-of select="EXTRACT/APPLICATION/ACCOUNTDESIGNATION"/></fo:block>
          <fo:block font-size="18pt" space-after="6pt">
            Application type:
            <xsl:choose>
              <xsl:when test="$isBorrowingFromUBS and $isIAL = false()">Loan and Put Option</xsl:when>
              <xsl:when test="$isBorrowingFromUBS and $isIAL">Interest Assistance Loan, Loan and Put Option</xsl:when>
              <xsl:when test="$isBorrowingFromUBS = false() and $isPurchasingPutFromUBS">Direct Investment with Put Option</xsl:when>
              <xsl:when test="$isBorrowingFromUBS = false() and $isPurchasingPutFromUBS = false()">Direct Investment</xsl:when>
            </xsl:choose>
          </fo:block>
          <xsl:variable name="totalInvestmentAmount" select="EXTRACT/APPLICATION/APPLICATIONAMOUNT01 + EXTRACT/APPLICATION/APPLICATIONAMOUNT02 + EXTRACT/APPLICATION/APPLICATIONAMOUNT03"/>
          <fo:block font-size="18pt" space-after="24pt">Total investment amount: $<xsl:value-of select="format-number ($totalInvestmentAmount, '#,##0')"/></fo:block>
          <fo:block font-size="18pt" space-after="12pt">Checklist</fo:block>
          <xsl:call-template name="checkBoxLead"><xsl:with-param name="text">Please ensure the following has been completed or provided when you submit your Application Form:</xsl:with-param></xsl:call-template>
          <xsl:call-template name="checkBoxItem"><xsl:with-param name="text">Please add Adviser Stamp (including AFSL number) to page 1 of the application form.</xsl:with-param></xsl:call-template>
          <xsl:call-template name="checkBoxItem"><xsl:with-param name="text">Review the printed application form and check accuracy.</xsl:with-param></xsl:call-template>
          <xsl:if test="$isBorrowingFromUBS">
            <xsl:choose>
              <xsl:when test="$jointApplication">
                <xsl:call-template name="checkBoxItem"><xsl:with-param name="text">Each individual must provide most recent payslip or tax return (if applicable guarantor's payslip or tax return).</xsl:with-param></xsl:call-template>
              </xsl:when>
              <xsl:otherwise>
                <xsl:call-template name="checkBoxItem"><xsl:with-param name="text">Provide most recent payslip or tax return (if applicable guarantor's payslip or tax return).</xsl:with-param></xsl:call-template>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:if>
          <xsl:if test="$isBorrowingFromUBS or $isPurchasingPutFromUBS">
            <xsl:call-template name="checkBoxItem"><xsl:with-param name="text">Complete and sign the BIS direct debit authorisation in Section 6 (please do not send a cheque).</xsl:with-param></xsl:call-template>
          </xsl:if>
          <xsl:if test="not ($isBorrowingFromUBS)">
            <xsl:call-template name="checkBoxItem"><xsl:with-param name="text">Complete and sign the RBS direct debit authorisation in Appendix C (please do not send a cheque).</xsl:with-param></xsl:call-template>
          </xsl:if>

          <xsl:choose>
            <xsl:when test="$individualApplication">
              <xsl:call-template name="checkBoxItem"><xsl:with-param name="text">Sign the application form (Section 9).</xsl:with-param></xsl:call-template>
              <xsl:choose>
                <xsl:when test="$isDAApproved">
                  <xsl:call-template name="checkBoxItem"><xsl:with-param name="text">Copy of the Power of Attorney required if any other person is acting on the investor's behalf.</xsl:with-param></xsl:call-template>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:if test="$isBorrowingFromUBS or $isPurchasingPutFromUBS">
                    <xsl:call-template name="checkBoxItem"><xsl:with-param name="text">Certified copy of valid passport or driver's licence (with clear image and expiry date).</xsl:with-param></xsl:call-template>
                    <xsl:call-template name="checkBoxItem"><xsl:with-param name="text">Original or certified copy of utility bill or bank statement, no more than 3 months old (address on utility bill or bank statement must match residential address stated in application form).</xsl:with-param></xsl:call-template>
                  </xsl:if>
                  <xsl:call-template name="checkBoxItem"><xsl:with-param name="text">Certified copy of the Power of Attorney required if any other person is acting on the investor's behalf.&nbsp; Please also provide certified copy of passport or driver's license for each attorney (if any).</xsl:with-param></xsl:call-template>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:when>

            <xsl:when test="$jointApplication">
              <xsl:call-template name="checkBoxItem"><xsl:with-param name="text">Each individual must sign the application form (Section 9).</xsl:with-param></xsl:call-template>
              <xsl:choose>
                <xsl:when test="$isDAApproved">
                  <xsl:call-template name="checkBoxItem"><xsl:with-param name="text">Copy of the Power of Attorney required if any other person(s) is/are acting on the investors' behalf.</xsl:with-param></xsl:call-template>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:if test="$isBorrowingFromUBS or $isPurchasingPutFromUBS">
                    <xsl:call-template name="checkBoxItem"><xsl:with-param name="text">Each individual must provide a certified copy of valid passport or driver's licence (with clear image and expiry date).</xsl:with-param></xsl:call-template>
                    <xsl:call-template name="checkBoxItem"><xsl:with-param name="text">Each individual must provide an original or certified copy of utility bill or bank statement, no more than 3 months old (address on utility bill or bank statement must match residential address stated in application form).</xsl:with-param></xsl:call-template>
                  </xsl:if>
                  <xsl:call-template name="checkBoxItem"><xsl:with-param name="text">Certified copy of the Power of Attorney required if any other person(s) is/are acting on the investors' behalf. Please also provide certified copy of passport or driver's license for each attorney (if any).</xsl:with-param></xsl:call-template>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:when>

            <xsl:when test="$privateOrCorporateTrust">
              <xsl:if test="$privateIndividualsApplying">
                <xsl:call-template name="checkBoxItem"><xsl:with-param name="text">All individual trustees must sign the application form (Section 9).</xsl:with-param></xsl:call-template>
              </xsl:if>
              <xsl:if test="$isBorrowingFromUBS">
                <xsl:call-template name="checkBoxItem"><xsl:with-param name="text">Completed and signed declaration from your solicitor (Appendix A) OR tick the box for trust deed review in Section 3C and provide a copy of your current trust deed.</xsl:with-param></xsl:call-template>
              </xsl:if>
              <xsl:if test="($isBorrowingFromUBS or $isPurchasingPutFromUBS) and not ($isDAApproved)">
                <xsl:choose>
                  <xsl:when test="$corporateTrustApplication">
                    <xsl:call-template name="checkBoxItem"><xsl:with-param name="text">Certified copies of passports or drivers' licences for all beneficial owners of corporate trustee (i.e. persons holding 25% or more of shares in the company).</xsl:with-param></xsl:call-template>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:call-template name="checkBoxItem"><xsl:with-param name="text">Certified copy of passport or driver's licence for all individual trustees (with clear image and expiry date).</xsl:with-param></xsl:call-template>
                    <xsl:call-template name="checkBoxItem"><xsl:with-param name="text">Certified copy of utility bill or bank statement for all individual trustees (no more than 3 months old - address on utility bill or bank statement must match residential address in application form).</xsl:with-param></xsl:call-template>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:if>
            </xsl:when>

            <xsl:when test="$companyApplying">
              <xsl:call-template name="checkBoxItem"><xsl:with-param name="text">Sign the application form by 2 directors, or a director and a company secretary.&nbsp; Can only be signed by one director if that signatory is the sole director and company secretary (Section 9).</xsl:with-param></xsl:call-template>
              <xsl:if test="($isBorrowingFromUBS or $isPurchasingPutFromUBS) and not ($isDAApproved)">
                <xsl:call-template name="checkBoxItem"><xsl:with-param name="text">Certified copies of passports or drivers' licences for 2 directors (or director and company secretary or sole director) and all beneficial owners of the company (i.e. persons holding 25% or more of shares in the company).</xsl:with-param></xsl:call-template>
              </xsl:if>
            </xsl:when>
          </xsl:choose>

          <fo:block>&nbsp;</fo:block>
          <fo:block>Please note that Dealer Groups that have completed a Distribution Agreement with BIS AG Switzerland Branch are not required to provide certified photo IDs or certified utility bills for their applicants.&nbsp; If unsure of the current status of your Dealer Group please contact BIS on (02) 8121-5720.</fo:block>
          <fo:block>&nbsp;</fo:block>
          <xsl:call-template name="checkBoxLead"><xsl:with-param name="text">Please ensure completed application forms are mailed to the following address:</xsl:with-param></xsl:call-template>
          <xsl:call-template name="checkBoxItem"><xsl:with-param name="text">c/- Link Market Services, RBS Sweaty Global Fund, Reply Paid 1516, Sydney South, NSW, 1234.</xsl:with-param></xsl:call-template>
          <fo:block>&nbsp;</fo:block>
          <fo:block space-after="3pt">Copies of documentation can be certified as true copies of the original by:</fo:block>
          <fo:list-block provisional-distance-between-starts="5mm">
            <fo:list-item>
              <fo:list-item-label end-indent="label-end ()"><fo:block>&bullet;</fo:block></fo:list-item-label>
              <fo:list-item-body start-indent="body-start ()"><fo:block>an Attorney, Lawyer, Accountant,Justice of Peace or Notary Public; or</fo:block></fo:list-item-body>
            </fo:list-item>
            <fo:list-item>
              <fo:list-item-label end-indent="label-end ()"><fo:block>&bullet;</fo:block></fo:list-item-label>
              <fo:list-item-body start-indent="body-start ()"><fo:block>your financial advisor.</fo:block></fo:list-item-body>
            </fo:list-item>
          </fo:list-block>
          <fo:block>&nbsp;</fo:block>
          <fo:block>Please note that the above individuals cannot certify their own documents (e.g. they cannot certify their own drivers licence, passport or utility bill).</fo:block>
          <fo:block>&nbsp;</fo:block>
          <fo:block>The certification should state: <fo:inline font-style="italic">"This is a true copy of the seen original"</fo:inline>.</fo:block>
          <fo:block>&nbsp;</fo:block>
          <fo:block space-after="3pt">It should be dated and signed by the certifying person (signature cannot be photocopied), and include the following details about the certifying person:</fo:block>
          <fo:list-block provisional-distance-between-starts="5mm">
            <fo:list-item>
              <fo:list-item-label end-indent="label-end ()"><fo:block>&bullet;</fo:block></fo:list-item-label>
              <fo:list-item-body start-indent="body-start ()"><fo:block>name,</fo:block></fo:list-item-body>
            </fo:list-item>
            <fo:list-item>
              <fo:list-item-label end-indent="label-end ()"><fo:block>&bullet;</fo:block></fo:list-item-label>
              <fo:list-item-body start-indent="body-start ()"><fo:block>firm (if applicable),</fo:block></fo:list-item-body>
            </fo:list-item>
            <fo:list-item>
              <fo:list-item-label end-indent="label-end ()"><fo:block>&bullet;</fo:block></fo:list-item-label>
              <fo:list-item-body start-indent="body-start ()"><fo:block>position of person at the firm,</fo:block></fo:list-item-body>
            </fo:list-item>
            <fo:list-item>
              <fo:list-item-label end-indent="label-end ()"><fo:block>&bullet;</fo:block></fo:list-item-label>
              <fo:list-item-body start-indent="body-start ()"><fo:block>representative number (in case of a financial advisor),</fo:block></fo:list-item-body>
            </fo:list-item>
            <fo:list-item>
              <fo:list-item-label end-indent="label-end ()"><fo:block>&bullet;</fo:block></fo:list-item-label>
              <fo:list-item-body start-indent="body-start ()"><fo:block>contact phone number of certifying person.</fo:block></fo:list-item-body>
            </fo:list-item>
          </fo:list-block>
        </fo:flow>
      </fo:page-sequence>




      <fo:page-sequence master-reference="Letter" initial-page-number="1">

        <fo:static-content flow-name="xsl-region-before">
          <fo:block font-size="12pt" font-weight="bold" color="#004780" text-align="center">RBS <fo:inline color="gray">SWEATY</fo:inline> GLOBAL FUND</fo:block>
        </fo:static-content>

        <fo:static-content flow-name="xsl-region-after">
          <fo:table table-layout="fixed">
            <fo:table-column column-width="33%"/>
            <fo:table-column column-width="34%"/>
            <fo:table-column column-width="33%"/>
            <fo:table-body font-size="9pt" font-style="italic">
              <fo:table-row>
                <fo:table-cell text-align="left"><fo:block>RBS Sweaty Global Fund</fo:block></fo:table-cell>
                <fo:table-cell text-align="center"><fo:block>Application Form</fo:block></fo:table-cell>
                <fo:table-cell text-align="right"><fo:block>Page <fo:page-number/> of <fo:page-number-citation ref-id="TheEnd"/></fo:block></fo:table-cell>
              </fo:table-row>
            </fo:table-body>
          </fo:table>
        </fo:static-content>

        <fo:flow flow-name="xsl-region-body" font-size="9pt">

          <fo:table space-after="10pt" table-layout="fixed" keep-together="always">
            <fo:table-column column-width="22%"/>
            <fo:table-column column-width="56%"/>
            <fo:table-column column-width="22%"/>
            <fo:table-body display-align="center">
              <fo:table-row>
                <fo:table-cell><fo:block>&nbsp;</fo:block></fo:table-cell>
                <fo:table-cell line-height="11pt" >
                  <fo:block font-size="20pt" color="#004780" text-align="center" space-after="10pt">Application Form</fo:block>
                </fo:table-cell>
                <fo:table-cell line-height="11pt" number-rows-spanned="2">
                  <fo:block>
                    <fo:instream-foreign-object>
                      <svg:svg xmlns:svg="http://www.w3.org/2000/svg" width="40mm" height="30mm">
                        <svg:rect x="0.1mm" y="0.1mm" width="39.9mm" height="29.9mm" stroke="#004780" stroke-width="0.1mm" fill="white"/>
                      </svg:svg>
                    </fo:instream-foreign-object>
                  </fo:block>
                  <fo:block font-size="8pt" line-height="9pt" text-align="center">Adviser Stamp</fo:block>
                </fo:table-cell>
              </fo:table-row>
              <fo:table-row>
                <fo:table-cell font-weight="bold" line-height="11pt" number-columns-spanned="2">
                  <fo:block>Completed application forms must be returned to:</fo:block>
                  <fo:block>Link Market Services, RBS Sweaty Global Fund, Reply Paid 1516, Sydney South NSW 1234</fo:block>
                  <fo:block>&nbsp;</fo:block>
                  <fo:block>By affixing their Adviser Stamp, Advisers verify the acknowledgments and representations listed under Section 9 (w) of this Application Form.</fo:block>
                </fo:table-cell>
              </fo:table-row>
            </fo:table-body>
          </fo:table>

          <!-- Section 1 -->

          <fo:block space-after="18pt" keep-together="always">
            <fo:block font-size="12pt" color="white" background-color="#004780" line-height="16pt" text-align="left" space-after="10pt" padding-top="2pt" padding-left="2pt" padding-right="2pt">1.&nbsp;&nbsp;Adviser Details</fo:block>

            <fo:table table-layout="fixed" keep-together="always" border-style="solid" border-width="0.5pt" border-collapse="collapse">
              <fo:table-column column-width="35%"/>
              <fo:table-column column-width="65%"/>
              <fo:table-body display-align="center">
                <fo:table-row>
                  <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt"><fo:block>Name of Dealer Group</fo:block></fo:table-cell>
                  <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt" font-weight="bold"><fo:block><xsl:value-of select="EXTRACT/APPLICATION/DEALERGROUPNAME"/></fo:block></fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                  <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt"><fo:block>Adviser Name</fo:block></fo:table-cell>
                  <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt" font-weight="bold"><fo:block>
                    <xsl:call-template name="pad"><xsl:with-param name="text" select="EXTRACT/APPLICATION/ADVISORFIRSTNAME"/></xsl:call-template>
                    <xsl:value-of select="EXTRACT/APPLICATION/ADVISORLASTNAME"/>
                  </fo:block></fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                  <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt"><fo:block>Adviser Email Address</fo:block></fo:table-cell>
                  <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt" font-weight="bold"><fo:block><xsl:value-of select="EXTRACT/APPLICATION/ADVISOREMAIL"/></fo:block></fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                  <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt"><fo:block>Adviser's Asistant Name</fo:block></fo:table-cell>
                  <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt" font-weight="bold"><fo:block><xsl:value-of select="EXTRACT/APPLICATION/ADVISORASSISTANTNAME"/></fo:block></fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                  <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt"><fo:block>Adviser Work Number</fo:block></fo:table-cell>
                  <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt" font-weight="bold"><fo:block><xsl:value-of select="EXTRACT/APPLICATION/ADVISORPHONE"/></fo:block></fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                  <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt"><fo:block>Adviser Company Name</fo:block></fo:table-cell>
                  <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt" font-weight="bold"><fo:block><xsl:value-of select="EXTRACT/APPLICATION/ADVISORCOMPANYNAME"/></fo:block></fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                  <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt"><fo:block>Adviser Company Address</fo:block></fo:table-cell>
                  <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt" font-weight="bold">
                    <fo:block><xsl:value-of select="EXTRACT/APPLICATION/ADVISORADDRESS1"/></fo:block>
                    <fo:block><xsl:value-of select="EXTRACT/APPLICATION/ADVISORADDRESS2"/></fo:block>
                    <fo:block>
                      <xsl:call-template name="pad3"><xsl:with-param name="text" select="EXTRACT/APPLICATION/ADVISORSUBURB"/></xsl:call-template>
                      <xsl:call-template name="pad3"><xsl:with-param name="text" select="EXTRACT/APPLICATION/ADVISORSTATE"/></xsl:call-template>
                      <xsl:value-of select="EXTRACT/APPLICATION/ADVISORPOSTCODE"/>
                    </fo:block>
                  </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                  <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt"><fo:block>RBS Adviser Number</fo:block></fo:table-cell>
                  <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt" font-weight="bold"><fo:block><xsl:value-of select="EXTRACT/APPLICATION/ADVISORNUMBER"/></fo:block></fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                  <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt"><fo:block>Adviser Upfront Commission</fo:block></fo:table-cell>
                  <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt" font-weight="bold"><fo:block><xsl:value-of select="EXTRACT/APPLICATION/COMMISSION"/>%</fo:block></fo:table-cell>
                </fo:table-row>
              </fo:table-body>
            </fo:table>
          </fo:block>

          <!-- Section 2 -->

          <fo:block space-after="18pt" keep-together="always">
            <fo:block font-size="12pt" color="white" background-color="#004780" line-height="16pt" text-align="left" space-after="10pt" padding-top="2pt" padding-left="2pt" padding-right="2pt">2.&nbsp;&nbsp;Investment Details</fo:block>

            <fo:block font-size="10pt" font-weight="bold" space-after="10pt">2A - Investment Amount</fo:block>

            <fo:block space-after="10pt">
              Please indicate below your Application Amount for each of the RBS Sweaty Global Funds
              (minimum application of $5,000 with increments of $1,000 thereafter,
              or minimum application of $50,000 with increments of $10,000 thereafter if you are borrowing from BIS Switzerland to purchase your Units):
            </fo:block>

            <fo:table table-layout="fixed" keep-together="always" space-after="10pt" border-style="solid" border-width="0.5pt">
              <fo:table-column column-width="35%"/>
              <fo:table-column column-width="65%"/>
              <fo:table-body display-align="center">
                <fo:table-row>
                  <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt"><fo:block>RBS Sweaty Global Fund Asia</fo:block></fo:table-cell>
                  <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt" font-weight="bold"><fo:block>$<xsl:value-of select="format-number (EXTRACT/APPLICATION/APPLICATIONAMOUNT01, '#,##0')"/></fo:block></fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                  <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt"><fo:block>RBS Sweaty Global Fund Europe</fo:block></fo:table-cell>
                  <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt" font-weight="bold"><fo:block>$<xsl:value-of select="format-number (EXTRACT/APPLICATION/APPLICATIONAMOUNT02, '#,##0')"/></fo:block></fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                  <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt"><fo:block>RBS Sweaty Global Fund USA</fo:block></fo:table-cell>
                  <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt" font-weight="bold"><fo:block>$<xsl:value-of select="format-number (EXTRACT/APPLICATION/APPLICATIONAMOUNT03, '#,##0')"/></fo:block></fo:table-cell>
                </fo:table-row>
              </fo:table-body>
            </fo:table>

            <fo:block space-after="10pt">
              If you are borrowing from BIS Switzerland,
              the minimum loan application is $50,000 with increments of $10,000 thereafter
              (this can be spread across each of the Funds subject to the minimum Application Amount for each Fund being $10,000 with $10,000 increments thereafter):
            </fo:block>

            <xsl:variable name="totalInvestmentAmount" select="EXTRACT/APPLICATION/APPLICATIONAMOUNT01 + EXTRACT/APPLICATION/APPLICATIONAMOUNT02 + EXTRACT/APPLICATION/APPLICATIONAMOUNT03"/>
            <fo:table table-layout="fixed" keep-together="always" space-after="10pt" border-style="solid" border-width="0.5pt">
              <fo:table-column column-width="35%"/>
              <fo:table-column column-width="65%"/>
              <fo:table-body display-align="center">
                <fo:table-row>
                  <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt"><fo:block>Total Investment Amount</fo:block></fo:table-cell>
                  <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt" font-weight="bold"><fo:block>$<xsl:value-of select="format-number ($totalInvestmentAmount, '#,##0')"/></fo:block></fo:table-cell>
                </fo:table-row>
              </fo:table-body>
            </fo:table>
          </fo:block>

          <fo:block space-after="18pt" keep-together="always">
            <fo:block font-size="10pt" font-weight="bold" space-after="10pt">2B - Account Designation</fo:block>

            <fo:block space-after="10pt">
              This is the name in which Units will be registered.&nbsp;
              This should correspond to and contain the name of the Applicant in Section&nbsp;3.
            </fo:block>
            <fo:table table-layout="fixed" keep-together="always" space-after="10pt" border-style="solid" border-width="0.5pt">
              <fo:table-column column-width="100%"/>
              <fo:table-body display-align="center">
                <fo:table-row>
                  <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt" font-weight="bold"><fo:block><xsl:value-of select="EXTRACT/APPLICATION/ACCOUNTDESIGNATION"/></fo:block></fo:table-cell>
                </fo:table-row>
              </fo:table-body>
            </fo:table>
          </fo:block>

          <fo:block space-after="18pt" keep-together="always">
            <fo:block font-size="10pt" font-weight="bold" space-after="10pt">2C - Account Contact Details</fo:block>

            <fo:table table-layout="fixed" keep-together="always" space-after="10pt" border-style="solid" border-width="0.5pt">
              <fo:table-column column-width="35%"/>
              <fo:table-column column-width="65%"/>
              <fo:table-body display-align="center">
                <fo:table-row>
                  <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt"><fo:block>Contact Person</fo:block></fo:table-cell>
                  <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt" font-weight="bold"><fo:block>
                    <xsl:call-template name="pad"><xsl:with-param name="text" select="EXTRACT/APPLICATION/CONTACTFIRSTNAME"/></xsl:call-template>
                    <xsl:value-of select="EXTRACT/APPLICATION/CONTACTLASTNAME"/>
                  </fo:block></fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                  <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt"><fo:block>Postal Address</fo:block></fo:table-cell>
                  <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt" font-weight="bold">
                    <fo:block><xsl:value-of select="EXTRACT/APPLICATION/POSTALADDRESS1"/></fo:block>
                    <fo:block><xsl:value-of select="EXTRACT/APPLICATION/POSTALADDRESS2"/></fo:block>
                    <fo:block>
                      <xsl:call-template name="pad3"><xsl:with-param name="text" select="EXTRACT/APPLICATION/POSTALSUBURB"/></xsl:call-template>
                      <xsl:call-template name="pad3"><xsl:with-param name="text" select="EXTRACT/APPLICATION/POSTALSTATE"/></xsl:call-template>
                      <xsl:value-of select="EXTRACT/APPLICATION/POSTALPOSTCODE"/>
                    </fo:block>
                    <fo:block><xsl:value-of select="EXTRACT/APPLICATION/POSTALCOUNTRY"/></fo:block>
                  </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                  <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt"><fo:block>Phone Numbers</fo:block></fo:table-cell>
                  <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt" font-weight="bold"><fo:block>
                    <xsl:if test="EXTRACT/APPLICATION/HOMEPHONE != ''">Home: <xsl:value-of select="EXTRACT/APPLICATION/HOMEPHONE"/>&nbsp;</xsl:if>
                    <xsl:if test="EXTRACT/APPLICATION/WORKPHONE != ''">Work: <xsl:value-of select="EXTRACT/APPLICATION/WORKPHONE"/>&nbsp;</xsl:if>
                    <xsl:if test="EXTRACT/APPLICATION/FAX != ''">FAX: <xsl:value-of select="EXTRACT/APPLICATION/FAX"/></xsl:if>
                  </fo:block></fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                  <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt"><fo:block>Email</fo:block></fo:table-cell>
                  <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt" font-weight="bold"><fo:block><xsl:value-of select="EXTRACT/APPLICATION/EMAIL"/></fo:block></fo:table-cell>
                </fo:table-row>
              </fo:table-body>
            </fo:table>
          </fo:block>

          <!-- Section 3 -->

          <fo:block font-size="12pt" color="white" background-color="#004780" line-height="16pt" text-align="left" space-after="10pt" keep-with-next="always" padding-top="2pt" padding-left="2pt" padding-right="2pt">3.&nbsp;&nbsp;Applicant Details</fo:block>

          <fo:block font-size="10pt" font-weight="bold" space-after="10pt" keep-with-next="always" >3A - Individuals</fo:block>

          <fo:table space-after="10pt" table-layout="fixed" keep-together="always">
            <fo:table-column column-width="36mm"/>
            <fo:table-column column-width="100mm"/>
            <fo:table-body>
              <fo:table-row>
                <fo:table-cell text-align="right"><fo:block>Please provide details for</fo:block></fo:table-cell>
                <fo:table-cell padding-left="5mm"><fo:block>Individual Applicant(s)</fo:block></fo:table-cell>
              </fo:table-row>
              <fo:table-row>
                <fo:table-cell text-align="right"><fo:block>or</fo:block></fo:table-cell>
                <fo:table-cell padding-left="5mm"><fo:block>Individual Trustee(s) of Trust Applicant</fo:block></fo:table-cell>
              </fo:table-row>
              <fo:table-row>
                <fo:table-cell text-align="right"><fo:block>or</fo:block></fo:table-cell>
                <fo:table-cell padding-left="5mm"><fo:block>Director(s) / Secretary of Company Applicant </fo:block></fo:table-cell>
              </fo:table-row>
              <fo:table-row>
                <fo:table-cell text-align="right"><fo:block>or</fo:block></fo:table-cell>
                <fo:table-cell padding-left="5mm"><fo:block>Director(s) / Secretary of Corporate Trustee Applicant</fo:block></fo:table-cell>
              </fo:table-row>
            </fo:table-body>
          </fo:table>

          <fo:block font-weight="bold" space-after="10pt">
            Important information:&nbsp;
            If the Applicant is a company,
            at least one of the directors of the company is required to act as guarantor for the applicant -
            please identify the guarantor by ticking the relevant box.
          </fo:block>
          <fo:block font-weight="bold" space-after="10pt">
            If the Applicant is a trust,
            at least one of the individual trustees,
            or one of the directors of the corporate trustee is required to act as guarantor for the applicant -
            please specify the guarantor by ticking the relevant box.
          </fo:block>
          <fo:block space-after="10pt">
            * The collection of TFNs and ABNs is authorised by law.&nbsp;
            You can provide your ABN if you have made this investment in the course or furtherance of an enterprise
            that you carry on in Switzerland.&nbsp;
            It is not an offence if you choose not to quote your TFN or ABN.&nbsp;
            If you do not supply your TFN or a valid exemption
            (or in certain circumstances an ABN),
            tax will be deducted by RBS from any Distributions paid to you at the highest marginal tax rate
            (plus Medicare Levy)
            and forwarded to the Swiss Tax Office.
          </fo:block>

          <xsl:for-each select="EXTRACT/APPLICANT">
            <xsl:call-template name="onePerson"><xsl:with-param name="personNumber" select="position ()"/><xsl:with-param name="beneficialOwnerSection" select="false ()"/><xsl:with-param name="individualApplication" select="$individualApplication"/><xsl:with-param name="privateIndividualsApplying" select="$privateIndividualsApplying"/></xsl:call-template>
          </xsl:for-each>

          <fo:block space-after="18pt" keep-together="always">
            <fo:block font-size="10pt" font-weight="bold" space-after="10pt">3B - Companies and Corporate Trustees</fo:block>

            <fo:table space-after="10pt" table-layout="fixed" keep-together="always">
              <fo:table-column column-width="36mm"/>
              <fo:table-column column-width="100mm"/>
              <fo:table-body>
                <fo:table-row>
                  <fo:table-cell text-align="right"><fo:block>Please provide details for</fo:block></fo:table-cell>
                  <fo:table-cell padding-left="5mm"><fo:block>Company Applicant</fo:block></fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                  <fo:table-cell text-align="right"><fo:block>or</fo:block></fo:table-cell>
                  <fo:table-cell padding-left="5mm"><fo:block>Corporate Trustee of Trust Applicant</fo:block></fo:table-cell>
                </fo:table-row>
              </fo:table-body>
            </fo:table>

            <xsl:choose>
              <xsl:when test="$companyApplying">
                <fo:table table-layout="fixed" space-after="10pt" border-style="solid" border-width="0.5pt">
                  <fo:table-column column-width="35%"/>
                  <fo:table-column column-width="65%"/>
                  <fo:table-body display-align="center">
                    <fo:table-row>
                      <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt"><fo:block>Name of Company</fo:block></fo:table-cell>
                      <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt" font-weight="bold"><fo:block><xsl:value-of select="EXTRACT/APPLICATION/COMPANYNAME"/></fo:block></fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                      <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt"><fo:block>TFN / ABN *</fo:block></fo:table-cell>
                      <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt" font-weight="bold"><fo:block>
                        <xsl:value-of select="EXTRACT/APPLICATION/COMPANYTFN" /> / <xsl:value-of select="EXTRACT/APPLICATION/COMPANYABN" />
                      </fo:block></fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                      <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt"><fo:block>Country and Date of Incorporation</fo:block></fo:table-cell>
                      <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt" font-weight="bold"><fo:block>
                        <xsl:value-of select="EXTRACT/APPLICATION/COMPANYCOUNTRY"/>,&nbsp;&nbsp;&nbsp;
                        <xsl:call-template name="formatDate"><xsl:with-param name="date" select="EXTRACT/APPLICATION/COMPANYDATE"/></xsl:call-template>
                      </fo:block></fo:table-cell>
                    </fo:table-row>
                  </fo:table-body>
                </fo:table>

                <fo:block space-after="10pt" font-weight="bold">Declaration of Beneficial Ownership</fo:block>
                <fo:block space-after="10pt">
                  This section must be completed by the beneficial owners of company and corporate trust applicants.&nbsp;
                  Beneficial Owners are persons who control 25% or more of the shares in the company or corporate trustee.
                </fo:block>
                <fo:block space-after="10pt">
                  For the purpose of this declaration a Beneficial Owner is the person(s) who owns or benefits from this account.&nbsp;
                  The Beneficial Owner(s) of this account is/are those Applicants identified in Section 3A above and marked "Beneficial Owner".&nbsp;
                  Any additional Beneficial Owners identified are listed below.
                </fo:block>
                <xsl:for-each select="EXTRACT/BENEFICIALOWNER">
                  <xsl:call-template name="onePerson"><xsl:with-param name="personNumber" select="position ()"/><xsl:with-param name="beneficialOwnerSection" select="true ()"/><xsl:with-param name="individualApplication" select="$individualApplication"/><xsl:with-param name="privateIndividualsApplying" select="$privateIndividualsApplying"/></xsl:call-template>
                </xsl:for-each>
              </xsl:when>
              <xsl:otherwise>
                <fo:block font-size="10pt" font-weight="bold" start-indent="1cm">Not a Company Application.</fo:block>
              </xsl:otherwise>
            </xsl:choose>
          </fo:block>

          <fo:block space-after="18pt" keep-together="always">
            <fo:block font-size="10pt" font-weight="bold" space-after="10pt" keep-with-next="always">3C - Trusts (Including Superannuation Funds)</fo:block>

            <fo:table space-after="10pt" table-layout="fixed" keep-together="always">
              <fo:table-column column-width="36mm"/>
              <fo:table-column column-width="100mm"/>
              <fo:table-body>
                <fo:table-row>
                  <fo:table-cell text-align="right"><fo:block>Please provide details for</fo:block></fo:table-cell>
                  <fo:table-cell padding-left="5mm"><fo:block>Trust Applicant</fo:block></fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                  <fo:table-cell text-align="right"><fo:block>or</fo:block></fo:table-cell>
                  <fo:table-cell padding-left="5mm"><fo:block>Superannuation Fund Applicant</fo:block></fo:table-cell>
                </fo:table-row>
              </fo:table-body>
            </fo:table>

            <xsl:choose>
              <xsl:when test="$privateOrCorporateTrust">
                <fo:table table-layout="fixed" space-after="10pt" border-style="solid" border-width="0.5pt">
                  <fo:table-column column-width="35%"/>
                  <fo:table-column column-width="65%"/>
                  <fo:table-body display-align="center">
                    <fo:table-row>
                      <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt"><fo:block>Name of Trust or Superannuation Fund</fo:block></fo:table-cell>
                      <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt" font-weight="bold"><fo:block><xsl:value-of select="EXTRACT/APPLICATION/TRUSTNAME"/></fo:block></fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                      <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt"><fo:block>TFN / ABN *</fo:block></fo:table-cell>
                      <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt" font-weight="bold"><fo:block>
                        <xsl:value-of select="EXTRACT/APPLICATION/TRUSTTFN" /> / <xsl:value-of select="EXTRACT/APPLICATION/TRUSTABN" />
                      </fo:block></fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                      <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt"><fo:block>ARBN</fo:block></fo:table-cell>
                      <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt" font-weight="bold"><fo:block><xsl:value-of select="EXTRACT/APPLICATION/TRUSTARBN"/></fo:block></fo:table-cell>
                    </fo:table-row>
                  <fo:table-row>
                    <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt"><fo:block>Source of Wealth</fo:block></fo:table-cell>
                    <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt" font-weight="bold"><fo:block>
                      <xsl:call-template name="sourceOfWealth">
                        <xsl:with-param name="employment" select="EXTRACT/APPLICATION/TRUSTWEALTHBYEMPLOYMENT"/>
                        <xsl:with-param name="investments" select="EXTRACT/APPLICATION/TRUSTWEALTHBYINVESTMENTS"/>
                        <xsl:with-param name="other" select="EXTRACT/APPLICATION/TRUSTWEALTHBYOTHER"/>
                        <xsl:with-param name="otherInfo" select="EXTRACT/APPLICATION/TRUSTWEALTHBYOTHERINFO"/>
                      </xsl:call-template>
                    </fo:block></fo:table-cell>
                  </fo:table-row>
                  </fo:table-body>
                </fo:table>
                <fo:block>
                  <fo:block>
                    If you are a trust applicant AND you intend to borrow from BIS Switzerland to finance the purchase of Units,
                    BIS Switzerland will need to confirm your ability to borrow and grant a mortgage under your trust deed.&nbsp;
                    Consequently, you must either:
                  </fo:block>
                  <fo:list-block provisional-distance-between-starts="5mm">
                    <fo:list-item>
                      <fo:list-item-label end-indent="label-end ()"><fo:block>a)</fo:block></fo:list-item-label>
                      <fo:list-item-body start-indent="body-start ()"><fo:block>arrange for your solicitor to complete the declaration set out in Appendix A, and submit that signed declaration with your Application Form; OR</fo:block></fo:list-item-body>
                    </fo:list-item>
                    <fo:list-item>
                      <fo:list-item-label end-indent="label-end ()"><fo:block>b)</fo:block></fo:list-item-label>
                      <fo:list-item-body start-indent="body-start ()"><fo:block>provide a complete and current copy of your trust deed to BIS Switzerland, who will arrange for a review of the relevant terms for a fee of A$250, to be deducted from your account specified in Section 6.</fo:block></fo:list-item-body>
                    </fo:list-item>
                  </fo:list-block>
                  <fo:block>This requirement is not applicable to superannuation funds or trust applicants who are only buying Units or Units and a Put Option.</fo:block>
                  <fo:table table-layout="fixed" space-before="12pt">
                  <fo:table-column column-width="9%"/>
                  <fo:table-column column-width="91%"/>
                    <fo:table-body display-align="top" font-size="10pt">
                      <fo:table-row>
                        <fo:table-cell><xsl:call-template name="yesNoBox"><xsl:with-param name="testTrue" select="$trustReviewDeeds"/></xsl:call-template></fo:table-cell>
                        <fo:table-cell border-style="none">
                          <fo:block>Please indicate if you would like BIS Switzerland to arrange for a review of your trust deed.</fo:block>
                        </fo:table-cell>
                      </fo:table-row>
                    </fo:table-body>
                  </fo:table>
                </fo:block>
              </xsl:when>
              <xsl:otherwise>
                <fo:block font-size="10pt" font-weight="bold" start-indent="1cm">Not a Trust or Superannuation Fund Application.</fo:block>
              </xsl:otherwise>
            </xsl:choose>
          </fo:block>

          <!-- Section 4 -->

          <fo:block space-after="18pt" keep-together="always">
            <fo:block font-size="12pt" color="white" background-color="#004780" line-height="16pt" text-align="left" space-after="10pt" padding-top="2pt" padding-left="2pt" padding-right="2pt">4.&nbsp;&nbsp;How Will You be Paying For Your Investment</fo:block>

            <fo:block space-after="10pt">I will be funding my subscription for Units in the RBS Sweaty Global Fund as follows:</fo:block>
            <fo:table table-layout="fixed" space-after="10pt">
              <fo:table-column column-width="9%"/>
              <fo:table-column column-width="91%"/>
              <fo:table-body display-align="top">
                <fo:table-row>
                  <fo:table-cell><xsl:call-template name="yesNoBox"><xsl:with-param name="testTrue" select="$isBorrowingFromUBS"/></xsl:call-template></fo:table-cell>
                  <fo:table-cell border-style="none">
                    <fo:block>Obtaining a Loan from BIS Switzerland - you must complete Sections 5 and 6 of this Application Form.</fo:block>
                    <fo:block font-weight="bold" space-after="10pt">IMPORTANT - SUPERANNUATION FUNDS CANNOT APPLY FOR A LOAN.</fo:block>
                  </fo:table-cell>
                </fo:table-row>
                <fo:table-row><fo:table-cell><fo:block>&nbsp;</fo:block></fo:table-cell></fo:table-row>
                <fo:table-row>
                  <fo:table-cell><xsl:call-template name="yesNoBox"><xsl:with-param name="testTrue" select="not ($isBorrowingFromUBS)"/></xsl:call-template></fo:table-cell>
                  <fo:table-cell border-style="none">
                    <fo:block>Payment out of my own funds, to be deducted by RBS from my nominated account specified in Appendix C, pursuant to the RBS Direct Debit Service Agreement. (Please complete Appendix C)</fo:block>
                  </fo:table-cell>
                </fo:table-row>
              </fo:table-body>
            </fo:table>
            <xsl:if test="EXTRACT/APPLICATION/ISBORROWINGFROMUBS != 'true'">
              <fo:table table-layout="fixed" space-after="10pt">
                <fo:table-column column-width="9%"/>
                <fo:table-column column-width="91%"/>
                <fo:table-body display-align="top">
                  <fo:table-row space-after="10pt">
                    <fo:table-cell><fo:block>&nbsp;</fo:block></fo:table-cell>
                    <fo:table-cell border-style="none">
                      <fo:block>
                        If you are not drawing down a Loan from BIS Switzerland to fund your investment in the RBS Sweaty Global Fund,
                        you may still acquire a Put Option from BIS Switzerland to protect the value of your investment.&nbsp;
                        Please indicate below if you would like to purchase a Put Option from BIS Switzerland.
                      </fo:block>
                      <fo:block>&nbsp;</fo:block>
                    </fo:table-cell>
                  </fo:table-row>
                  <fo:table-row>
                    <fo:table-cell><xsl:call-template name="yesNoBox"><xsl:with-param name="testTrue" select="$isPurchasingPutFromUBS"/></xsl:call-template></fo:table-cell>
                    <fo:table-cell border-style="none"><fo:block>
                      Purchase a Put Option from BIS Switzerland.&nbsp;
                      (Please complete Appendix C and Section 6.)
                    </fo:block></fo:table-cell>
                  </fo:table-row>
                  <fo:table-row>
                    <fo:table-cell><fo:block>&nbsp;</fo:block></fo:table-cell>
                    <fo:table-cell border-style="none">
                      <fo:block>&nbsp;</fo:block>
                      <fo:block>
                        If you are not a Borrower and you do not select this box,
                        BIS Switzerland will assume that you DO NOT want to purchase a Put Option from BIS Switzerland to protect your investment.
                      </fo:block>
                    </fo:table-cell>
                  </fo:table-row>
                </fo:table-body>
              </fo:table>
            </xsl:if>
            <fo:block font-weight="bold" space-after="10pt">
              IF YOU ARE DRAWING A LOAN OR PURCHASING A PUT OPTION FROM BIS AUSTRALIA,
              YOU MUST COMPLETE SECTION 6 TO PROVIDE YOUR BANK ACCOUNT DETAILS FOR DIRECT DEBIT OF INTEREST AND PROTECTION FEE PAYMENTS.
            </fo:block>
          </fo:block>

          <!-- Section 5 -->

          <fo:block space-after="6pt" keep-together="always">
            <fo:block font-size="12pt" color="white" background-color="#004780" line-height="16pt" text-align="left" space-after="10pt" padding-top="2pt" padding-left="2pt" padding-right="2pt">5.&nbsp;&nbsp;Loan Details</fo:block>

            <xsl:if test="EXTRACT/APPLICATION/ISBORROWINGFROMUBS = 'true'">
              <fo:block space-after="10pt">
                If you are applying for a Loan from BIS Switzerland to fund the purchase of Units in the RBS Sweaty Global Fund,
                please indicate also whether you would like to apply for an Interest Assistance Loan.
              </fo:block>
              <fo:table table-layout="fixed" space-after="10pt">
                <fo:table-column column-width="9%"/>
                <fo:table-column column-width="91%"/>
                <fo:table-body display-align="top">
                  <fo:table-row>
                    <fo:table-cell><xsl:call-template name="yesNoBox"><xsl:with-param name="testTrue" select="$isIAL"/></xsl:call-template></fo:table-cell>
                    <fo:table-cell border-style="none"><fo:block>Apply for an Interest Assistance Loan from BIS Switzerland to fund 100% of the First Interest Amount due on my Loan.*</fo:block></fo:table-cell>
                  </fo:table-row>
                  <fo:table-row>
                    <fo:table-cell><fo:block>&nbsp;</fo:block></fo:table-cell>
                    <fo:table-cell border-style="none">
                      <fo:block>&nbsp;</fo:block>
                      <fo:block>* You are required to pay interest on the Loan and Protection Fee on the Put Option annually in advance.</fo:block></fo:table-cell>
                  </fo:table-row>
                </fo:table-body>
              </fo:table>
            </xsl:if>

            <fo:block>
              To enable BIS Switzerland to make an assessment of your Loan application, please provide:
            </fo:block>
            <fo:list-block provisional-distance-between-starts="5mm">
              <fo:list-item>
                <fo:list-item-label end-indent="label-end ()"><fo:block>a)</fo:block></fo:list-item-label>
                <fo:list-item-body start-indent="body-start ()"><fo:block>A copy of the <fo:inline font-weight="bold">most recent payslip or tax return</fo:inline> for the applicant and the guarantor (if applicable); and</fo:block></fo:list-item-body>
              </fo:list-item>
              <fo:list-item>
                <fo:list-item-label end-indent="label-end ()"><fo:block>b)</fo:block></fo:list-item-label>
                <fo:list-item-body start-indent="body-start ()"><fo:block>
                  The following information in respect of the applicant and the guarantor (if applicable).&nbsp;
                  Financial data should be provided by reference to the applicant's current status,
                  without including the Loan and/or Put Option being applied for in this application.
                </fo:block></fo:list-item-body>
              </fo:list-item>
            </fo:list-block>
          </fo:block>

          <fo:block space-after="6pt" keep-together="always">
            <fo:block space-after="6pt">
              <fo:inline font-size="11pt" font-weight="bold">Applicant's asset and income details</fo:inline> -
              in the case of joint applicants,
              please provide aggregate asset and income information.&nbsp;
              <xsl:if test="$companyApplying">
                In the case of a company or trust application,
                please provide asset and income information for the company or the trust respectively.
              </xsl:if>
            </fo:block>
            <xsl:call-template name="financials">
              <xsl:with-param name="cash" select="EXTRACT/APPLICATION/ICASH"/>
              <xsl:with-param name="shares" select="EXTRACT/APPLICATION/ISHARES"/>
              <xsl:with-param name="otherliquid" select="EXTRACT/APPLICATION/IOTHERLIQUID"/>
              <xsl:with-param name="residentialProperty" select="EXTRACT/APPLICATION/IRESIDENTIALPROPERTY"/>
              <xsl:with-param name="investmentProperty" select="EXTRACT/APPLICATION/IINVESTMENTPROPERTY"/>
              <xsl:with-param name="otherAssets" select="EXTRACT/APPLICATION/IOTHERASSETS"/>
              <xsl:with-param name="otherAssetsDetails" select="EXTRACT/APPLICATION/IOTHERASSETSDETAILS"/>
              <xsl:with-param name="otherLoansSecured" select="EXTRACT/APPLICATION/IOTHERLOANSSECURED"/>
              <xsl:with-param name="loansResidentialProperty" select="EXTRACT/APPLICATION/ILOANSRESIDENTIALPROPERTY"/>
              <xsl:with-param name="loansInvestmentProperty" select="EXTRACT/APPLICATION/ILOANSINVESTMENTPROPERTY"/>
              <xsl:with-param name="loansPersonalUnsecured" select="EXTRACT/APPLICATION/ILOANSPERSONALUNSECURED"/>
              <xsl:with-param name="guaranteesGranted" select="EXTRACT/APPLICATION/IGUARANTEESGRANTED"/>
              <xsl:with-param name="otherLiabilities" select="EXTRACT/APPLICATION/IOTHERLIABILITIES"/>
              <xsl:with-param name="otherLiabilitiesDetails" select="EXTRACT/APPLICATION/IOTHERLIABILITIESDETAILS"/>
              <xsl:with-param name="salary" select="EXTRACT/APPLICATION/ISALARY"/>
              <xsl:with-param name="rentalAndDividend" select="EXTRACT/APPLICATION/IRENTALANDDIVIDEND"/>
              <xsl:with-param name="otherIncome" select="EXTRACT/APPLICATION/IOTHERINCOME"/>
              <xsl:with-param name="otherIncomeDetails" select="EXTRACT/APPLICATION/IOTHERINCOMEDETAILS"/>
              <xsl:with-param name="taxPayable" select="EXTRACT/APPLICATION/ITAXPAYABLE"/>
              <xsl:with-param name="taxPayableDate" select="EXTRACT/APPLICATION/ITAXPAYABLEDATE"/>
              <xsl:with-param name="interestOnSecuredLoans" select="EXTRACT/APPLICATION/IINTERESTONSECUREDLOANS"/>
              <xsl:with-param name="interestOnUnsecuredLoans" select="EXTRACT/APPLICATION/IINTERESTONUNSECUREDLOANS"/>
              <xsl:with-param name="livingExpenses" select="EXTRACT/APPLICATION/ILIVINGEXPENSES"/>
              <xsl:with-param name="otherExpenses" select="EXTRACT/APPLICATION/IOTHEREXPENSES"/>
              <xsl:with-param name="otherExpensesDetails" select="EXTRACT/APPLICATION/IOTHEREXPENSESDETAILS"/>
            </xsl:call-template>

            <xsl:if test="$companyApplying">
              <fo:block font-size="11pt" font-weight="bold" space-after="6pt">Guarantor's asset and income details.</fo:block>
              <xsl:call-template name="financials">
                <xsl:with-param name="cash" select="EXTRACT/APPLICATION/GCASH"/>
                <xsl:with-param name="shares" select="EXTRACT/APPLICATION/GSHARES"/>
                <xsl:with-param name="otherliquid" select="EXTRACT/APPLICATION/GOTHERLIQUID"/>
                <xsl:with-param name="residentialProperty" select="EXTRACT/APPLICATION/GRESIDENTIALPROPERTY"/>
                <xsl:with-param name="investmentProperty" select="EXTRACT/APPLICATION/GINVESTMENTPROPERTY"/>
                <xsl:with-param name="otherAssets" select="EXTRACT/APPLICATION/GOTHERASSETS"/>
                <xsl:with-param name="otherAssetsDetails" select="EXTRACT/APPLICATION/GOTHERASSETSDETAILS"/>
                <xsl:with-param name="otherLoansSecured" select="EXTRACT/APPLICATION/GOTHERLOANSSECURED"/>
                <xsl:with-param name="loansResidentialProperty" select="EXTRACT/APPLICATION/GLOANSRESIDENTIALPROPERTY"/>
                <xsl:with-param name="loansInvestmentProperty" select="EXTRACT/APPLICATION/GLOANSINVESTMENTPROPERTY"/>
                <xsl:with-param name="loansPersonalUnsecured" select="EXTRACT/APPLICATION/GLOANSPERSONALUNSECURED"/>
                <xsl:with-param name="guaranteesGranted" select="EXTRACT/APPLICATION/GGUARANTEESGRANTED"/>
                <xsl:with-param name="otherLiabilities" select="EXTRACT/APPLICATION/GOTHERLIABILITIES"/>
                <xsl:with-param name="otherLiabilitiesDetails" select="EXTRACT/APPLICATION/GOTHERLIABILITIESDETAILS"/>
                <xsl:with-param name="salary" select="EXTRACT/APPLICATION/GSALARY"/>
                <xsl:with-param name="rentalAndDividend" select="EXTRACT/APPLICATION/GRENTALANDDIVIDEND"/>
                <xsl:with-param name="otherIncome" select="EXTRACT/APPLICATION/GOTHERINCOME"/>
                <xsl:with-param name="otherIncomeDetails" select="EXTRACT/APPLICATION/GOTHERINCOMEDETAILS"/>
                <xsl:with-param name="taxPayable" select="EXTRACT/APPLICATION/GTAXPAYABLE"/>
                <xsl:with-param name="taxPayableDate" select="EXTRACT/APPLICATION/GTAXPAYABLEDATE"/>
                <xsl:with-param name="interestOnSecuredLoans" select="EXTRACT/APPLICATION/GINTERESTONSECUREDLOANS"/>
                <xsl:with-param name="interestOnUnsecuredLoans" select="EXTRACT/APPLICATION/GINTERESTONUNSECUREDLOANS"/>
                <xsl:with-param name="livingExpenses" select="EXTRACT/APPLICATION/GLIVINGEXPENSES"/>
                <xsl:with-param name="otherExpenses" select="EXTRACT/APPLICATION/GOTHEREXPENSES"/>
                <xsl:with-param name="otherExpensesDetails" select="EXTRACT/APPLICATION/GOTHEREXPENSESDETAILS"/>
              </xsl:call-template>
            </xsl:if>
          </fo:block>
         </fo:flow>

      </fo:page-sequence>


      <!-- Section 6 -->


      <fo:page-sequence master-reference="Normal">


         <fo:static-content flow-name="xsl-region-before">
          <fo:block font-size="12pt" font-weight="bold" color="#004780" text-align="center">RBS <fo:inline color="gray">SWEATY</fo:inline> GLOBAL FUND</fo:block>
        </fo:static-content>

        <fo:static-content flow-name="xsl-region-after">
          <fo:table table-layout="fixed">
            <fo:table-column column-width="33%"/>
            <fo:table-column column-width="34%"/>
            <fo:table-column column-width="33%"/>
            <fo:table-body font-size="9pt" font-style="italic">
              <fo:table-row>
                <fo:table-cell text-align="left"><fo:block>RBS Sweaty Global Fund</fo:block></fo:table-cell>
                <fo:table-cell text-align="center"><fo:block>Application Form</fo:block></fo:table-cell>
                <fo:table-cell text-align="right"><fo:block>Page <fo:page-number/> of <fo:page-number-citation ref-id="TheEnd"/></fo:block></fo:table-cell>
              </fo:table-row>
            </fo:table-body>
          </fo:table>
        </fo:static-content>

        <fo:flow flow-name="xsl-region-body" font-size="9pt">
         <fo:block space-after="18pt" keep-together="always">
            <fo:block font-size="12pt" color="white" background-color="#004780" line-height="16pt" text-align="left" space-after="10pt" padding-top="2pt" padding-left="2pt" padding-right="2pt">6.&nbsp;&nbsp;Direct Debit Authorisation for Payments to BIS Switzerland</fo:block>

            <xsl:choose>
              <xsl:when test="$isBorrowingFromUBS or $isPurchasingPutFromUBS">
                <fo:block space-after="10pt">
                  Interest rates in relation to your Loan and Interest Assistance Loan will be set by BIS Switzerland on or around
                  15 December 2012,
                  and will be posted on the RBS website at
                  <fo:basic-link color="purple" text-decoration="underline" external-destination="http://www.rbs.co.uk/personal/investments.ashx">www.rbs.co.uk</fo:basic-link>.
                </fo:block>
                <fo:block space-after="10pt">
                  BIS Switzerland will direct debit interest due under your Loan and Interest Assistance Loan
                  as well as the Protection Fee for Applicants buying a Put Option
                  from the bank account specified below if and when your application is accepted.
                </fo:block>
                <fo:block space-after="10pt">
                  BIS Switzerland will also direct debit a fee of A$250 from the following account
                  for trust applicants who have requested a review of their trust deed (refer Section 3C).
                </fo:block>
                <fo:block space-after="10pt">
                  Direct debits are expected to be processed between
                  15 June 2012 and 26 June 2012
                  upon your Application Acceptance,
                  but may be processed on any other date
                  in accorance with the terms of the Direct Debit Request.
                </fo:block>
                <fo:block space-after="10pt" font-weight="bold">
                  An amount sufficient to cover your total payment obligations must be in the specified account by no later than
                  15 June 2012.
                </fo:block>
                <fo:block space-after="10pt" font-weight="bold">
                  PLEASE NOTE THAT YOU CANNOT SUPPLY A THIRD PARTY BANK ACCOUNT.&nbsp;
                  THIS MEANS THAT THE BANK ACCOUNT BELOW MUST BE IN THE NAME OF THE INVESTOR MAKING THIS APPLICATION.
                </fo:block>

                <fo:table table-layout="fixed" space-after="10pt" border-style="solid" border-width="0.5pt">
                  <fo:table-column column-width="25%"/>
                  <fo:table-column column-width="75%"/>
                  <fo:table-body display-align="top">
                    <fo:table-row>
                      <fo:table-cell number-columns-spanned="2" border-style="solid" border-width="0.5pt" padding="2pt">
                        <fo:block text-align="left" font-style="italic" space-after="10pt">Request and Authority to debit the account named below to pay</fo:block>
                        <fo:block text-align="center">BIS AG, Switzerland Branch</fo:block>
                      </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                      <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt"><fo:block>Request and Authority to debit</fo:block></fo:table-cell>
                      <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt">
                        <fo:block space-after="10pt">
                          Applicant name: <fo:inline font-weight="bold"><xsl:value-of select="EXTRACT/APPLICATION/ACCOUNTDESIGNATION"/></fo:inline>
                          <xsl:if test="EXTRACT/APPLICATION/COMPANYABN != ''">, ACN / ABN: <fo:inline font-weight="bold"><xsl:value-of select="EXTRACT/APPLICATION/COMPANYABN"/></fo:inline>,</xsl:if>
                          ("YOU")
                        </fo:block>
                        <fo:block space-after="10pt">
                          request and authorise BIS AG, Switzerland Branch (User ID number 328400 or 181243) to arrange,
                          through its own financial institution,
                          for any amount BIS AG, Switzerland Branch may debit or charge you to be debited through the Bulk Electronic Clearing System
                          from an account held at the financial institution identified below and paid to
                          BIS AG, Switzerland Branch, subject to the terms and conditions of the Direct Debit Request Service Agreement.
                        </fo:block>
                        <fo:block space-after="10pt">
                          BIS AG, Switzerland Branch will only arrange for funds to be debited from your account
                          if we have notified you or your financial adviser of the amount payable by you and when it is due.&nbsp;
                          Such notification can be given verbally, by email or in writing.
                        </fo:block>
                      </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                      <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt"><fo:block>Name and address of financial institution at which account is held</fo:block></fo:table-cell>
                      <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt">
                        <fo:block>Financial institution name: <fo:inline font-weight="bold"><xsl:value-of select="EXTRACT/APPLICATION/DDINSTITUTION"/></fo:inline></fo:block>
                        <fo:block>
                          Address:
                          <fo:inline font-weight="bold">
                            <xsl:call-template name="pad"><xsl:with-param name="text" select="EXTRACT/APPLICATION/DDINSTITUTIONADDRESS"/></xsl:call-template>
                            <xsl:call-template name="pad"><xsl:with-param name="text" select="EXTRACT/APPLICATION/DDINSTITUTIONSUBURB"/></xsl:call-template>
                            <xsl:call-template name="pad"><xsl:with-param name="text" select="EXTRACT/APPLICATION/DDINSTITUTIONPOSTCODE"/></xsl:call-template>
                            <xsl:value-of select="EXTRACT/APPLICATION/DDINSTITUTIONSTATE"/>
                          </fo:inline>
                        </fo:block>
                      </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                      <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt"><fo:block>Details of account to be debited</fo:block></fo:table-cell>
                      <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt">
                        <fo:block>
                          Note:
                          This must be the same account as that provided in Appendix C, RBS Direct Debit Request Form,
                          if you complete Appendix C
                          (i.e. if you purchase a Put Option but do not take out a Loan to purchase your Units).
                        </fo:block>
                        <fo:block>&nbsp;</fo:block>
                        <fo:block>Name of account: <fo:inline font-weight="bold"><xsl:value-of select="EXTRACT/APPLICATION/DDACCOUNTNAME"/></fo:inline></fo:block>
                        <fo:block>
                          BSB:
                          <fo:inline font-weight="bold"><xsl:value-of select="substring (EXTRACT/APPLICATION/DDBSB, 1, 3)"/></fo:inline>-<fo:inline font-weight="bold"><xsl:value-of select="substring (EXTRACT/APPLICATION/DDBSB, 4, 3)"/></fo:inline>&nbsp;&nbsp;&nbsp;
                          Account number: <fo:inline font-weight="bold"><xsl:value-of select="EXTRACT/APPLICATION/DDACCOUNTNO"/></fo:inline>
                        </fo:block>
                      </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                      <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt"><fo:block>Acknowledgment</fo:block></fo:table-cell>
                      <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt"><fo:block>
                        By signing this Direct Debit Request
                        you acknowledge having read and understood the terms and conditions governing the debit arrangements
                        between you and BIS AG, Switzerland
                        as set out in this Request and in your Direct Debit Request Service Agreement
                        <fo:inline font-weight="bold">(refer to Appendix B of this Application Form)</fo:inline>.
                      </fo:block></fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                      <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt">
                        <fo:block>Insert your signature and address</fo:block>
                        <fo:block>&nbsp;</fo:block>
                        <fo:block>Note: Please ensure that all persons in the account name have signed below.</fo:block>
                      </fo:table-cell>
                      <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt">
                        <fo:table>
                          <fo:table-column column-width="50%"/>
                          <fo:table-column column-width="50%"/>
                          <fo:table-body>
                            <fo:table-row>
                              <fo:table-cell>
                                <fo:block padding-bottom="0" padding-top="5mm"><fo:inline padding-top="4mm" background-color="yellow">x _____________________________</fo:inline></fo:block>
                                <fo:block>Signature</fo:block>
                                <fo:block padding-bottom="0" padding-top="5mm"><fo:inline padding-top="4mm" background-color="yellow">x _____________________________</fo:inline></fo:block>
                                <fo:block>Name (please print)</fo:block>
                              </fo:table-cell>
                              <fo:table-cell>
                                <fo:block padding-bottom="0" padding-top="5mm"><fo:inline padding-top="4mm" background-color="yellow">x _____________________________</fo:inline></fo:block>
                                <fo:block>Signature</fo:block>
                                <fo:block padding-bottom="0" padding-top="5mm"><fo:inline padding-top="4mm" background-color="yellow">x _____________________________</fo:inline></fo:block>
                                <fo:block>Name (please print)</fo:block>
                              </fo:table-cell>
                            </fo:table-row>
                          </fo:table-body>
                        </fo:table>
                        <xsl:if test="$companyApplying">
                          <fo:block space-before="1mm">(If signing for a company, sign and print full name and capacity for signing e.g. Director)</fo:block>
                        </xsl:if>
                        <fo:table>
                          <fo:table-column column-width="15%"/>
                          <fo:table-column column-width="85%"/>
                          <fo:table-body>
                            <fo:table-row>
                              <fo:table-cell>
                                <fo:block padding-top="5mm">Address:</fo:block>
                                <fo:block padding-top="5mm">Date:</fo:block>
                              </fo:table-cell>
                              <fo:table-cell>
                                <fo:block padding-top="5mm"><fo:inline padding-top="4mm" background-color="yellow">____________________________________________________________</fo:inline></fo:block>
                                <fo:block padding-top="5mm"><fo:inline padding-top="4mm" background-color="yellow">____/____</fo:inline>/2012</fo:block>
                              </fo:table-cell>
                            </fo:table-row>
                          </fo:table-body>
                        </fo:table>
                      </fo:table-cell>
                    </fo:table-row>
                  </fo:table-body>
                </fo:table>
              </xsl:when>
              <xsl:otherwise>
                <fo:block font-size="10pt" font-weight="bold" start-indent="1cm">Not borrowing or purchasing Puts from BIS.</fo:block>
              </xsl:otherwise>
            </xsl:choose>
          </fo:block>

          <!-- Section 7 -->

          <fo:block space-after="18pt" keep-together="always">
            <fo:block font-size="12pt" color="white" background-color="#004780" line-height="16pt" text-align="left" space-after="10pt" padding-top="2pt" padding-left="2pt" padding-right="2pt">7.&nbsp;&nbsp;Payments To You</fo:block>

            <fo:block space-after="10pt">
              Amounts may be payable to you during the term of your investment in the RBS Sweaty Global Fund,
              e.g. Distributions from the Fund or Put Option exercise proceeds from BIS .
            </fo:block>
            <fo:block space-after="10pt">
              Distributions may be required to be reinvested back into the RBS Sweaty Global Fund
              in order to preserve the CPPT feature within the Notes held by the RBS Sweaty Global Fund.&nbsp;
              Furthermore, if you have borrowed from BIS Switzerland,
              BIS Switzerland may direct you to apply any Income Distributions towards
              repayment of your Interest Obligations and Interest Assistance Loan Balance (if applicable).&nbsp;
              The following instructions are valid only to the extent they are consistent with the terms of the Loan Agreement and Put Option Agreement.&nbsp;
              These instructions can be changed at any time over the term of the investment.
            </fo:block>
            <fo:block font-weight="bold" space-after="10pt">
              In the event that a cash distribution becomes payable by the RBS Sweaty Global Fund to you,
              please select what you would like to happen to your cash distribution:
            </fo:block>
            <fo:table table-layout="fixed" space-after="10pt">
              <fo:table-column column-width="9%"/>
              <fo:table-column column-width="91%"/>
              <fo:table-body display-align="top">
                <fo:table-row>
                  <fo:table-cell><xsl:call-template name="yesNoBox"><xsl:with-param name="testTrue" select="$reinvestDistribution"/></xsl:call-template></fo:table-cell>
                  <fo:table-cell border-style="none"><fo:block>Reinvest my distribution in the RBS Sweaty Global Fund.</fo:block></fo:table-cell>
                </fo:table-row>
                <fo:table-row><fo:table-cell><fo:block>&nbsp;</fo:block></fo:table-cell></fo:table-row>
                <fo:table-row>
                  <fo:table-cell><xsl:call-template name="yesNoBox"><xsl:with-param name="testTrue" select="$directCreditDistribution"/></xsl:call-template></fo:table-cell>
                  <fo:table-cell border-style="none"><fo:block>Direct credit my Distribution to the account nominated in Section 6 of this Application Form.</fo:block></fo:table-cell>
                </fo:table-row>
              </fo:table-body>
            </fo:table>
            <fo:block font-weight="bold" space-after="10pt">
              In the event of an amount being due to you from BIS Switzerland,
              BIS Switzerland will direct credit the amount to the account nominated in Section 6 of this Application Form.
            </fo:block>
          </fo:block>

          <!-- Section 8 -->

          <fo:block space-after="18pt" keep-together="always">
            <fo:block font-size="12pt" color="white" background-color="#004780" line-height="16pt" text-align="left" space-after="10pt" padding-top="2pt" padding-left="2pt" padding-right="2pt">8.&nbsp;&nbsp;Other Investor Information</fo:block>

            <fo:block font-size="11pt" font-weight="bold" space-after="10pt">Annual Reports</fo:block>
            <fo:block space-after="10pt">
              Would you like to receive a paper copy of the annual report for the RBS Sweaty Global Fund each year?&nbsp;
              An electronic copy will be made available on RBS website at
              <fo:basic-link color="purple" text-decoration="underline" external-destination="http://www.rbs.co.uk/personal/investments.ashx">www.rbs.co.uk</fo:basic-link>.
            </fo:block>
            <fo:table table-layout="fixed" space-after="10pt">
              <fo:table-column column-width="9%"/>
              <fo:table-column column-width="91%"/>
              <fo:table-body display-align="top">
                <fo:table-row>
                  <fo:table-cell><xsl:call-template name="yesNoBox"><xsl:with-param name="testTrue" select="$isPaperCopyWanted"/></xsl:call-template></fo:table-cell>
                  <fo:table-cell border-style="none"><fo:block>Provide a paper copy of the annual financial report.</fo:block></fo:table-cell>
                </fo:table-row>
              </fo:table-body>
            </fo:table>

            <fo:block font-size="11pt" font-weight="bold" space-after="10pt">Other RBS Investments</fo:block>
            <fo:block space-after="10pt">Please indicate below if you are currently an Investor in any fund managed by RBS</fo:block>
            <fo:table table-layout="fixed" space-after="10pt">
              <fo:table-column column-width="9%"/>
              <fo:table-column column-width="91%"/>
              <fo:table-body display-align="top">
                <fo:table-row>
                  <fo:table-cell><xsl:call-template name="yesNoBox"><xsl:with-param name="testTrue" select="$isProviderCustomer"/></xsl:call-template></fo:table-cell>
                  <fo:table-cell border-style="none">
                    <fo:block>Unit holder number: <fo:inline font-weight="bold"><xsl:value-of select="EXTRACT/APPLICATION/PROVIDERUNITHOLDERNUMBER"/></fo:inline></fo:block>
                    <fo:block>Fund name: <fo:inline font-weight="bold"><xsl:value-of select="EXTRACT/APPLICATION/PROVIDERFUNDNAME"/></fo:inline></fo:block>
                  </fo:table-cell>
                </fo:table-row>
              </fo:table-body>
            </fo:table>
            <fo:block space-after="10pt">Please indicate below if you have previously obtained a loan or put option from BIS Switzerland in relation to any fund managed by RBS</fo:block>
            <fo:table table-layout="fixed" space-after="10pt">
              <fo:table-column column-width="9%"/>
              <fo:table-column column-width="91%"/>
              <fo:table-body display-align="top">
                <fo:table-row>
                  <fo:table-cell><xsl:call-template name="yesNoBox"><xsl:with-param name="testTrue" select="$isUBSCustomer"/></xsl:call-template></fo:table-cell>
                  <fo:table-cell border-style="none">
                    <fo:block>Unit holder number: <fo:inline font-weight="bold"><xsl:value-of select="EXTRACT/APPLICATION/UBSUNITHOLDERNUMBER"/></fo:inline></fo:block>
                    <fo:block>Fund name: <fo:inline font-weight="bold"><xsl:value-of select="EXTRACT/APPLICATION/UBSFUNDNAME"/></fo:inline></fo:block>
                  </fo:table-cell>
                </fo:table-row>
              </fo:table-body>
            </fo:table>

            <xsl:if test="not ($individualApplication)">
              <fo:block font-size="11pt" font-weight="bold" space-after="10pt">Account Operating Instructions</fo:block>
              <xsl:choose>
                <xsl:when test="$privateIndividualsApplying">
                  <fo:block space-after="10pt">Joint Applicants: <fo:inline font-size="11pt" font-weight="bold">
                    <xsl:call-template name="yesNoText"><xsl:with-param name="testTrue" select="$isEitherToSign"/><xsl:with-param name="yesText" select="'Either to sign'"/><xsl:with-param name="noText" select="'Both to sign together'"/></xsl:call-template>
                  </fo:inline></fo:block>
                </xsl:when>
                <xsl:otherwise>
                  <fo:block space-after="10pt">Company Applicants: <fo:inline font-size="11pt" font-weight="bold">
                    <xsl:call-template name="yesNoText"><xsl:with-param name="testTrue" select="$isEitherToSign"/><xsl:with-param name="yesText" select="'Any one officer to sign'"/><xsl:with-param name="noText" select="'All directors or director and company secretary to sign'"/></xsl:call-template>
                  </fo:inline></fo:block>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:if>
          </fo:block>

          <!-- Section 9 -->

          <fo:block font-size="12pt" color="white" background-color="#004780" line-height="16pt" text-align="left" space-after="10pt" keep-with-next="always" padding-top="2pt" padding-left="2pt" padding-right="2pt">9.&nbsp;&nbsp;Signatures and Acknowledgements</fo:block>

          <fo:block font-size="11pt" font-weight="bold" space-after="6pt" keep-with-next="always">All Applicants</fo:block>
          <fo:block space-after="6pt" keep-with-next="always">All applicants, by signing this Application Form:</fo:block>
          <fo:list-block space-after="6pt" provisional-distance-between-starts="5mm">
            <fo:list-item space-after="6pt" keep-together="always">
              <fo:list-item-label end-indent="label-end ()"><fo:block>(a)</fo:block></fo:list-item-label>
              <fo:list-item-body start-indent="body-start ()">
                <fo:block>acknowledge that:</fo:block>
                <fo:list-block provisional-distance-between-starts="5mm">
                  <fo:list-item>
                    <fo:list-item-label end-indent="label-end ()"><fo:block>i.</fo:block></fo:list-item-label>
                    <fo:list-item-body start-indent="body-start ()"><fo:block>until Units are allocated to me on the Allocation Date, RBS may accept or reject my/our application for Units in the RBS Sweaty Global Fund at its complete discretion and may with my/our consent amend my/our Application Form; and</fo:block></fo:list-item-body>
                  </fo:list-item>
                  <fo:list-item>
                    <fo:list-item-label end-indent="label-end ()"><fo:block>ii.</fo:block></fo:list-item-label>
                    <fo:list-item-body start-indent="body-start ()"><fo:block>until any Units are allocated to me I will have no interest in the RBS Sweaty Global Fund.</fo:block></fo:list-item-body>
                  </fo:list-item>
                </fo:list-block>
              </fo:list-item-body>
            </fo:list-item>
            <fo:list-item space-after="6pt" keep-together="always">
              <fo:list-item-label end-indent="label-end ()"><fo:block>(b)</fo:block></fo:list-item-label>
              <fo:list-item-body start-indent="body-start ()">
                <fo:block>declare that:</fo:block>
                <fo:list-block provisional-distance-between-starts="5mm">
                  <fo:list-item>
                    <fo:list-item-label end-indent="label-end ()"><fo:block>i.</fo:block></fo:list-item-label>
                    <fo:list-item-body start-indent="body-start ()"><fo:block>if signing as an attorney, the power of attorney authorises the signing of this Application Form and no notice of revocation has been received;</fo:block></fo:list-item-body>
                  </fo:list-item>
                  <fo:list-item>
                    <fo:list-item-label end-indent="label-end ()"><fo:block>ii.</fo:block></fo:list-item-label>
                    <fo:list-item-body start-indent="body-start ()"><fo:block>I/We am/are not minor(s) and do not suffer from any other legal disability preventing the execution of this Application Form;</fo:block></fo:list-item-body>
                  </fo:list-item>
                  <fo:list-item>
                    <fo:list-item-label end-indent="label-end ()"><fo:block>iii.</fo:block></fo:list-item-label>
                    <fo:list-item-body start-indent="body-start ()"><fo:block>if signing in a capacity other than a personal capacity, in addition to being bound in that other capacity, I/we agree to be bound in an unlimited personal capacity; and</fo:block></fo:list-item-body>
                  </fo:list-item>
                  <fo:list-item>
                    <fo:list-item-label end-indent="label-end ()"><fo:block>iv.</fo:block></fo:list-item-label>
                    <fo:list-item-body start-indent="body-start ()"><fo:block>I/We have full legal capacity to complete and lodge this Application Form and be bound by the Loan Agreement and Put Option Agreement (if applicable) and have taken all action that is necessary to authorise this Application and be bound by the Loan Agreement and Put Option Agreement (if applicable).</fo:block></fo:list-item-body>
                  </fo:list-item>
                </fo:list-block>
              </fo:list-item-body>
            </fo:list-item>
            <fo:list-item space-after="6pt">
              <fo:list-item-label end-indent="label-end ()"><fo:block>(c)</fo:block></fo:list-item-label>
              <fo:list-item-body start-indent="body-start ()"><fo:block>declare that before completing this Application Form, I/we have received a copy of the PDS inviting subscriptions for Units in the RBS Sweaty Global Fund and I/we have fully read and understood the PDS.</fo:block></fo:list-item-body>
            </fo:list-item>
            <fo:list-item space-after="6pt">
              <fo:list-item-label end-indent="label-end ()"><fo:block>(d)</fo:block></fo:list-item-label>
              <fo:list-item-body start-indent="body-start ()"><fo:block>represent that I/we have reviewed the PDS and Application Form to the extent that I/we consider necessary, and have made my/our own independent investigation and appraisal of the taxation, legal, economic and credit aspects associated with this investment, including obtaining independent advice where I/we deem necessary.</fo:block></fo:list-item-body>
            </fo:list-item>
            <fo:list-item space-after="6pt">
              <fo:list-item-label end-indent="label-end ()"><fo:block>(e)</fo:block></fo:list-item-label>
              <fo:list-item-body start-indent="body-start ()"><fo:block>represent that I/we have not relied in any way whatsoever on any statements made by, or purported to be made by, RBS or BIS AG or their related entities or any of their respective servants, agents, employees or representatives in relation to this investment, other than as set out in the PDS and Application Form, and acknowledge that RBS and BIS AG have not made any representations to me/us with regard to the suitability or appropriateness of this investment to my/our individual circumstances or the tax consequences of making this investment or drawing down the Loan or purchasing the Put Option.</fo:block></fo:list-item-body>
            </fo:list-item>
            <fo:list-item space-after="6pt">
              <fo:list-item-label end-indent="label-end ()"><fo:block>(f)</fo:block></fo:list-item-label>
              <fo:list-item-body start-indent="body-start ()"><fo:block>declare that all information provided in this Application Form is true and correct to the best of my/our knowledge, acknowledge that RBS and BIS AG may and will rely on this information, and I/we agree to indemnify BIS AG against any loss or claim of or against RBS and BIS AG to the extent that the loss or claim arises from or is connected with any breach of any of the representations contained in this Application Form.</fo:block></fo:list-item-body>
            </fo:list-item>
            <fo:list-item space-after="6pt">
              <fo:list-item-label end-indent="label-end ()"><fo:block>(g)</fo:block></fo:list-item-label>
              <fo:list-item-body start-indent="body-start ()"><fo:block>agree to accept the issuance of Units in the RBS Sweaty Global Fund on the terms and conditions of the constitution of the RBS Sweaty Global Fund (and be bound by such constitution) and the PDS to which this Application Form is attached.</fo:block></fo:list-item-body>
            </fo:list-item>
            <fo:list-item space-after="6pt" keep-together="always">
              <fo:list-item-label end-indent="label-end ()"><fo:block>(h)</fo:block></fo:list-item-label>
              <fo:list-item-body start-indent="body-start ()">
                <fo:block>acknowledge that neither RBS or BIS AG or their related bodies corporate, affiliates, associates or officers:</fo:block>
                <fo:list-block provisional-distance-between-starts="5mm">
                  <fo:list-item>
                    <fo:list-item-label end-indent="label-end ()"><fo:block>i.</fo:block></fo:list-item-label>
                    <fo:list-item-body start-indent="body-start ()"><fo:block>guarantees the performance of the RBS Sweaty Global Fund;</fo:block></fo:list-item-body>
                  </fo:list-item>
                  <fo:list-item>
                    <fo:list-item-label end-indent="label-end ()"><fo:block>ii.</fo:block></fo:list-item-label>
                    <fo:list-item-body start-indent="body-start ()"><fo:block>guarantees that the RBS Sweaty Global Fund will achieve a particular rate of return; or</fo:block></fo:list-item-body>
                  </fo:list-item>
                  <fo:list-item>
                    <fo:list-item-label end-indent="label-end ()"><fo:block>iii.</fo:block></fo:list-item-label>
                    <fo:list-item-body start-indent="body-start ()"><fo:block>guarantees the repayment of capital from an investment in the RBS Sweaty Global Fund.</fo:block></fo:list-item-body>
                  </fo:list-item>
                </fo:list-block>
              </fo:list-item-body>
            </fo:list-item>
            <fo:list-item space-after="6pt">
              <fo:list-item-label end-indent="label-end ()"><fo:block>(i)</fo:block></fo:list-item-label>
              <fo:list-item-body start-indent="body-start ()"><fo:block>understand that nothing in the PDS or Application Form can be considered investment advice or a recommendation to invest in Units or to obtain the Loan and/or Put Option.</fo:block></fo:list-item-body>
            </fo:list-item>
            <fo:list-item space-after="6pt">
              <fo:list-item-label end-indent="label-end ()"><fo:block>(j)</fo:block></fo:list-item-label>
              <fo:list-item-body start-indent="body-start ()"><fo:block>acknowledge that investments in the RBS Sweaty Global Fund are not deposits with or other liabilities of BIS AG, RBS Asset Management Limited ABN 25 082 862 375 or related bodies corporate, affiliates, associates or officers of any of the above entities and are subject to investment risk, including possible delays in repayment and loss of income and capital invested.</fo:block></fo:list-item-body>
            </fo:list-item>
            <fo:list-item space-after="6pt">
              <fo:list-item-label end-indent="label-end ()"><fo:block>(k)</fo:block></fo:list-item-label>
              <fo:list-item-body start-indent="body-start ()"><fo:block>declare and represent that the credit or other financial accommodation to be provided to me/us by BIS Switzerland is to be applied wholly or predominantly for business or investment purposes (or for both purposes).</fo:block></fo:list-item-body>
            </fo:list-item>
          </fo:list-block>
          <fo:block font-weight="bold" space-after="6pt">IMPORTANT - Individual applicants and individual trustee applicants should not sign this declaration unless the loan or other financial accommodation is wholly or predominantly for business or investment purposes. By signing this declaration you may lose your protection under the Consumer Credit Code.</fo:block>
          <fo:list-block space-after="6pt" provisional-distance-between-starts="5mm">
            <fo:list-item space-after="6pt">
              <fo:list-item-label end-indent="label-end ()"><fo:block>(l)</fo:block></fo:list-item-label>
              <fo:list-item-body start-indent="body-start ()"><fo:block>acknowledge that my/our application may be accepted by BIS Switzerland verbally communicating such acceptance to BIS and RBS notifying me/us or my/our adviser of such acceptance.&nbsp; Upon BIS Switzerland verbally communicating such acceptance to RBS I/we acknowledge that I/we shall be bound by the terms of the constitution of the RBS Sweaty Global Fund and the PDS to which the Application Form is attached.</fo:block></fo:list-item-body>
            </fo:list-item>
            <fo:list-item space-after="6pt">
              <fo:list-item-label end-indent="label-end ()"><fo:block>(m)</fo:block></fo:list-item-label>
              <fo:list-item-body start-indent="body-start ()"><fo:block>represent that I/we am/are Australian resident(s) for tax purposes.</fo:block></fo:list-item-body>
            </fo:list-item>
          </fo:list-block>

          <fo:block font-size="11pt" font-weight="bold" space-after="6pt" keep-with-next="always">Put Option Applicants</fo:block>
          <fo:block space-after="6pt" keep-with-next="always">Applicants who have applied for a Put Option also:</fo:block>
          <fo:list-block space-after="6pt" provisional-distance-between-starts="5mm">
            <fo:list-item space-after="6pt">
              <fo:list-item-label end-indent="label-end ()"><fo:block>(n)</fo:block></fo:list-item-label>
              <fo:list-item-body start-indent="body-start ()"><fo:block>represent I/we have read and understood the Put Option Agreement in Section 16 of this PDS to which this Application Form is attached and agree to be bound by, and in the case of joint Applicants, agree to be jointly and severally bound by, the provisions of the Put Option Agreement.</fo:block></fo:list-item-body>
            </fo:list-item>
            <fo:list-item space-after="6pt">
              <fo:list-item-label end-indent="label-end ()"><fo:block>(o)</fo:block></fo:list-item-label>
              <fo:list-item-body start-indent="body-start ()"><fo:block>acknowledge the Put Option will be granted subject to the terms and conditions of the Put Option Agreement.</fo:block></fo:list-item-body>
            </fo:list-item>
            <fo:list-item space-after="6pt">
              <fo:list-item-label end-indent="label-end ()"><fo:block>(p)</fo:block></fo:list-item-label>
              <fo:list-item-body start-indent="body-start ()"><fo:block>acknowledge BIS Switzerland may accept or reject my/our application for a Put Option at its complete discretion and may with my/our consent amend my/our Application Form.</fo:block></fo:list-item-body>
            </fo:list-item>
          </fo:list-block>

          <fo:block font-size="11pt" font-weight="bold" space-after="6pt" keep-with-next="always">Loan Applicants</fo:block>
          <fo:block space-after="6pt" keep-with-next="always">Applicants who have applied for a Loan also:</fo:block>
          <fo:list-block space-after="6pt" provisional-distance-between-starts="5mm">
            <fo:list-item space-after="6pt">
              <fo:list-item-label end-indent="label-end ()"><fo:block>(q)</fo:block></fo:list-item-label>
              <fo:list-item-body start-indent="body-start ()"><fo:block>represent they have read and understood the Loan Agreement in Section 15 of this PDS to which this Application Form is attached, and agree to be bound by, and in the case of joint Applicants, agree to be jointly and severally bound by, the provisions of the Loan Agreement.</fo:block></fo:list-item-body>
            </fo:list-item>
            <fo:list-item space-after="6pt">
              <fo:list-item-label end-indent="label-end ()"><fo:block>(r)</fo:block></fo:list-item-label>
              <fo:list-item-body start-indent="body-start ()"><fo:block>acknowledge the Loan will be granted subject to the terms and conditions of the Loan Agreement.</fo:block></fo:list-item-body>
            </fo:list-item>
            <fo:list-item space-after="6pt">
              <fo:list-item-label end-indent="label-end ()"><fo:block>(s)</fo:block></fo:list-item-label>
              <fo:list-item-body start-indent="body-start ()"><fo:block>acknowledge BIS Switzerland may accept or reject my/our application for a Loan and Put Option at its complete discretion and may with my/our consent amend my/our Application Form.</fo:block></fo:list-item-body>
            </fo:list-item>
            <fo:list-item space-after="6pt" keep-together="always">
              <fo:list-item-label end-indent="label-end ()"><fo:block>(t)</fo:block></fo:list-item-label>
              <fo:list-item-body start-indent="body-start ()">
                <fo:block>acknowledge that my/our obligations under the Loan Agreement including my/our obligation to repay the Loan and pay interest costs, break costs and any other fees and charges that may apply are not affected by:</fo:block>
                <fo:list-block provisional-distance-between-starts="5mm">
                  <fo:list-item>
                    <fo:list-item-label end-indent="label-end ()"><fo:block>i.</fo:block></fo:list-item-label>
                    <fo:list-item-body start-indent="body-start ()"><fo:block>the success or failure of BIS AG or RBS;</fo:block></fo:list-item-body>
                  </fo:list-item>
                  <fo:list-item>
                    <fo:list-item-label end-indent="label-end ()"><fo:block>ii.</fo:block></fo:list-item-label>
                    <fo:list-item-body start-indent="body-start ()"><fo:block>the level of return from or loss of money from an investment in Units in the RBS Sweaty Global Fund; or</fo:block></fo:list-item-body>
                  </fo:list-item>
                  <fo:list-item>
                    <fo:list-item-label end-indent="label-end ()"><fo:block>iii.</fo:block></fo:list-item-label>
                    <fo:list-item-body start-indent="body-start ()"><fo:block>any illegality in connection with BIS AG, RBS or the PDS offering inviting subscription for Units in the RBS Sweaty Global Fund.</fo:block></fo:list-item-body>
                  </fo:list-item>
                </fo:list-block>
              </fo:list-item-body>
            </fo:list-item>
            <fo:list-item space-after="6pt">
              <fo:list-item-label end-indent="label-end ()"><fo:block>(u)</fo:block></fo:list-item-label>
              <fo:list-item-body start-indent="body-start ()"><fo:block>acknowledge that if my/our application for a Loan is accepted, the Loan Agreement is deemed to be entered into between myself/ourselves, the Guarantor (if any) and BIS Switzerland, and I/we shall become bound by the terms of the Loan Agreement and Mortgage referred to in the Loan Agreement upon BIS Switzerland communicating its acceptance to RBS in accordance with paragraph (l).</fo:block></fo:list-item-body>
            </fo:list-item>
          </fo:list-block>

          <fo:block font-size="11pt" font-weight="bold" space-after="6pt" keep-with-next="always">Guarantors</fo:block>
          <fo:list-block space-after="6pt" provisional-distance-between-starts="5mm">
            <fo:list-item space-after="6pt" keep-together="always">
              <fo:list-item-label end-indent="label-end ()"><fo:block>(v)</fo:block></fo:list-item-label>
              <fo:list-item-body start-indent="body-start ()">
                <fo:block>Guarantors by signing this Application Form agree that where more than one Guarantor signs this form:</fo:block>
                <fo:list-block provisional-distance-between-starts="5mm">
                  <fo:list-item>
                    <fo:list-item-label end-indent="label-end ()"><fo:block>i.</fo:block></fo:list-item-label>
                    <fo:list-item-body start-indent="body-start ()"><fo:block>each Guarantor agrees to be bound by the terms of the Loan Agreement as a Guarantor;</fo:block></fo:list-item-body>
                  </fo:list-item>
                  <fo:list-item>
                    <fo:list-item-label end-indent="label-end ()"><fo:block>ii.</fo:block></fo:list-item-label>
                    <fo:list-item-body start-indent="body-start ()"><fo:block>the obligations of each Guarantor under the Loan Agreement are joint and several;</fo:block></fo:list-item-body>
                  </fo:list-item>
                  <fo:list-item>
                    <fo:list-item-label end-indent="label-end ()"><fo:block>iii.</fo:block></fo:list-item-label>
                    <fo:list-item-body start-indent="body-start ()"><fo:block>the Loan Agreement binds each Guarantor notwithstanding that one or more of them may not be or may cease to be bound by the terms of the Loan Agreement;</fo:block></fo:list-item-body>
                  </fo:list-item>
                  <fo:list-item>
                    <fo:list-item-label end-indent="label-end ()"><fo:block>iv.</fo:block></fo:list-item-label>
                    <fo:list-item-body start-indent="body-start ()"><fo:block>the obligations of each Guarantor under the Loan Agreement will not be affected by any obligation of any one or more of them being or becoming wholly or partially illegal, voidable or unenforceable for any reason whatsoever (whether or not BIS AG knew or ought to have known of such reason); and</fo:block></fo:list-item-body>
                  </fo:list-item>
                  <fo:list-item>
                    <fo:list-item-label end-indent="label-end ()"><fo:block>v.</fo:block></fo:list-item-label>
                    <fo:list-item-body start-indent="body-start ()"><fo:block>each reference to the Guarantor in the Loan Agreement shall include each Guarantor.</fo:block></fo:list-item-body>
                  </fo:list-item>
                </fo:list-block>
              </fo:list-item-body>
            </fo:list-item>
          </fo:list-block>

          <fo:block font-size="11pt" font-weight="bold" space-after="6pt" keep-with-next="always">Advisers</fo:block>
          <fo:list-block space-after="6pt" provisional-distance-between-starts="5mm">
            <fo:list-item space-after="6pt" keep-together="always">
              <fo:list-item-label end-indent="label-end ()"><fo:block>(w)</fo:block></fo:list-item-label>
              <fo:list-item-body start-indent="body-start ()">
                <fo:block>Advisers by adding their Adviser Stamp to this Application Form:</fo:block>
                <fo:list-block provisional-distance-between-starts="5mm">
                  <fo:list-item>
                    <fo:list-item-label end-indent="label-end ()"><fo:block>i.</fo:block></fo:list-item-label>
                    <fo:list-item-body start-indent="body-start ()"><fo:block>acknowledge that I am either an Australian Financial Services Licensee or an authorised representatives of an Australian Financial Services Licensee and that, in relation to this application, I have only provided financial services that are within the scope of the Australian Financial Services Licence applicable to me;</fo:block></fo:list-item-body>
                  </fo:list-item>
                  <fo:list-item>
                    <fo:list-item-label end-indent="label-end ()"><fo:block>ii.</fo:block></fo:list-item-label>
                    <fo:list-item-body start-indent="body-start ()"><fo:block>acknowledge that I have complied with the relevant disclosure requirements, including all relevant requirements in relation to the disclosure of fees, and any requirement to provide Product Disclosure Statements, Financial Services Guides, Statements of Advice or any other disclosures required by the Corporations Act;</fo:block></fo:list-item-body>
                  </fo:list-item>
                  <fo:list-item>
                    <fo:list-item-label end-indent="label-end ()"><fo:block>iii.</fo:block></fo:list-item-label>
                    <fo:list-item-body start-indent="body-start ()"><fo:block>represent that I have taken adequate steps to check and verify the Applicant's identity (including the directors, beneficial owners and trustees listed in the Application) by checking and verifying the identity, nationality, residential address and signature of the Applicant;</fo:block></fo:list-item-body>
                  </fo:list-item>
                  <fo:list-item>
                    <fo:list-item-label end-indent="label-end ()"><fo:block>iv.</fo:block></fo:list-item-label>
                    <fo:list-item-body start-indent="body-start ()"><fo:block>represent that I have taken adequate steps to assist in the prevention of money laundering activities which steps may include, without limitation identifying the Applicant's source of wealth and monitoring of any unusual transactions;</fo:block></fo:list-item-body>
                  </fo:list-item>
                  <fo:list-item>
                    <fo:list-item-label end-indent="label-end ()"><fo:block>v.</fo:block></fo:list-item-label>
                    <fo:list-item-body start-indent="body-start ()"><fo:block>represent that I have, in relation to Loan and Interest Assistance Loan Applicants, assessed and confirmed their capacity to pay all present and future interest and principal amounts; and</fo:block></fo:list-item-body>
                  </fo:list-item>
                  <fo:list-item>
                    <fo:list-item-label end-indent="label-end ()"><fo:block>vi.</fo:block></fo:list-item-label>
                    <fo:list-item-body start-indent="body-start ()"><fo:block>represent that I have assessed the suitability of this product and other relevant factors for the Applicant and have only recommended or distributed it as I consider it suitable for the Applicant, taking into account the Applicant's investment objectives, financial situation and particular needs.</fo:block></fo:list-item-body>
                  </fo:list-item>
                </fo:list-block>
              </fo:list-item-body>
            </fo:list-item>
          </fo:list-block>

          <fo:block font-size="11pt" font-weight="bold" space-after="6pt" keep-with-next="always">Privacy</fo:block>
          <fo:block space-after="6pt">The personal information we ask you to supply in this Application Form is not required by law but we may not be able to accept your application if the information is not supplied.&nbsp; The personal information collected from you will not be used or disclosed except for a purpose set out below, in accordance with an authority given by you, for a purpose you would reasonably expect, or where required or permitted by law.&nbsp; If at any time you wish to access the personal information held about you by BIS, you are welcome to request that information.</fo:block>
          <fo:list-block space-after="6pt" provisional-distance-between-starts="5mm">
            <fo:list-item space-after="6pt">
              <fo:list-item-label end-indent="label-end ()"><fo:block>1)</fo:block></fo:list-item-label>
              <fo:list-item-body start-indent="body-start ()">
                <fo:block keep-with-next="always">I/We acknowledge that the personal information about me/us provided to BIS and RBS in this Application Form is collected and used for the following purposes (as relevant):</fo:block>
                <fo:list-block provisional-distance-between-starts="5mm">
                  <fo:list-item>
                    <fo:list-item-label end-indent="label-end ()"><fo:block>&bullet;</fo:block></fo:list-item-label>
                    <fo:list-item-body start-indent="body-start ()"><fo:block>to assess whether to accept my/our application and to provide and administer the Loan and Interest Assistance Loan and Put Option (if applicable) or whether to accept me as Guarantor;</fo:block></fo:list-item-body>
                  </fo:list-item>
                  <fo:list-item>
                    <fo:list-item-label end-indent="label-end ()"><fo:block>&bullet;</fo:block></fo:list-item-label>
                    <fo:list-item-body start-indent="body-start ()"><fo:block>to prepare any documentation relevant to and to maintain the Loan, and Interest Funding Loan (if applicable) investment or guarantee under the Loan and Put Option Agreements (the "Guarantee");</fo:block></fo:list-item-body>
                  </fo:list-item>
                  <fo:list-item>
                    <fo:list-item-label end-indent="label-end ()"><fo:block>&bullet;</fo:block></fo:list-item-label>
                    <fo:list-item-body start-indent="body-start ()"><fo:block>to effect investments in Units in my/our name(s);</fo:block></fo:list-item-body>
                  </fo:list-item>
                  <fo:list-item>
                    <fo:list-item-label end-indent="label-end ()"><fo:block>&bullet;</fo:block></fo:list-item-label>
                    <fo:list-item-body start-indent="body-start ()"><fo:block>to communicate with me/us in relation to the Units, Loan, Interest Funding Loan and Put Option (if applicable) or Guarantee;</fo:block></fo:list-item-body>
                  </fo:list-item>
                  <fo:list-item>
                    <fo:list-item-label end-indent="label-end ()"><fo:block>&bullet;</fo:block></fo:list-item-label>
                    <fo:list-item-body start-indent="body-start ()"><fo:block>to comply with legislative or regulatory requirements; and</fo:block></fo:list-item-body>
                  </fo:list-item>
                  <fo:list-item>
                    <fo:list-item-label end-indent="label-end ()"><fo:block>&bullet;</fo:block></fo:list-item-label>
                    <fo:list-item-body start-indent="body-start ()"><fo:block>to perform BIS' and RBS's administrative operations.</fo:block></fo:list-item-body>
                  </fo:list-item>
                </fo:list-block>
              </fo:list-item-body>
            </fo:list-item>
            <fo:list-item space-after="6pt" keep-together="always">
              <fo:list-item-label end-indent="label-end ()"><fo:block>2)</fo:block></fo:list-item-label>
              <fo:list-item-body start-indent="body-start ()">
                <fo:block keep-with-next="always">I/We agree that BIS and/or RBS:</fo:block>
                <fo:list-block provisional-distance-between-starts="5mm">
                  <fo:list-item>
                    <fo:list-item-label end-indent="label-end ()"><fo:block>&bullet;</fo:block></fo:list-item-label>
                    <fo:list-item-body start-indent="body-start ()"><fo:block>may give certain information about me/us to a credit reporting agency in order to obtain a credit report about me/us.&nbsp; The information which may be given is covered by s18E(1) of the Privacy Act 1988 (Cth) (the "Act") and may include, as relevant, identity particulars and the fact that I/we applied for credit or have offered to act as a Guarantor;</fo:block></fo:list-item-body>
                  </fo:list-item>
                  <fo:list-item>
                    <fo:list-item-label end-indent="label-end ()"><fo:block>&bullet;</fo:block></fo:list-item-label>
                    <fo:list-item-body start-indent="body-start ()"><fo:block>may, in assessing whether to accept my application and to provide the Loan, Interest Funding Loan and Put Option (if applicable) to me or to accept me as a Guarantor, seek and obtain information about me from a credit reporting agency or another credit provider and give information about me to another credit provider including, in each case, information about credit worthiness, history, standing or capacity which credit providers are permitted by the Act to obtain or receive;</fo:block></fo:list-item-body>
                  </fo:list-item>
                  <fo:list-item>
                    <fo:list-item-label end-indent="label-end ()"><fo:block>&bullet;</fo:block></fo:list-item-label>
                    <fo:list-item-body start-indent="body-start ()"><fo:block>(for Applicants only) may give such information about me to any of BIS' or RBS's related bodies corporate or any person proposing to be a Guarantor or who is a Guarantor for purposes of managing the investment or any returns on the investment held on my/our behalf;</fo:block></fo:list-item-body>
                  </fo:list-item>
                  <fo:list-item>
                    <fo:list-item-label end-indent="label-end ()"><fo:block>&bullet;</fo:block></fo:list-item-label>
                    <fo:list-item-body start-indent="body-start ()">
                      <fo:block>may give personal information about me/us to:</fo:block>
                      <fo:list-block provisional-distance-between-starts="5mm">
                        <fo:list-item>
                          <fo:list-item-label end-indent="label-end ()"><fo:block>a)</fo:block></fo:list-item-label>
                          <fo:list-item-body start-indent="body-start ()"><fo:block>BIS' and RBS's agents, contractors and external advisers;</fo:block></fo:list-item-body>
                        </fo:list-item>
                        <fo:list-item>
                          <fo:list-item-label end-indent="label-end ()"><fo:block>b)</fo:block></fo:list-item-label>
                          <fo:list-item-body start-indent="body-start ()"><fo:block>regulatory bodies, government agencies, law enforcement bodies and courts; and</fo:block></fo:list-item-body>
                        </fo:list-item>
                        <fo:list-item>
                          <fo:list-item-label end-indent="label-end ()"><fo:block>c)</fo:block></fo:list-item-label>
                          <fo:list-item-body start-indent="body-start ()"><fo:block>the entities in which investments are made and/or to any agents or contractors for the purpose of administering or enforcing the Loan and Interest Funding Loan (if applicable) or Guarantee;</fo:block></fo:list-item-body>
                        </fo:list-item>
                      </fo:list-block>
                    </fo:list-item-body>
                  </fo:list-item>
                  <fo:list-item>
                    <fo:list-item-label end-indent="label-end ()"><fo:block>&bullet;</fo:block></fo:list-item-label>
                    <fo:list-item-body start-indent="body-start ()"><fo:block>may collect personal information about me/us from, and give it to, my/our executor, administrator, trustee, guardian or attorney and my/our agents and representatives (including my finance broker, legal and financial adviser); and</fo:block></fo:list-item-body>
                  </fo:list-item>
                  <fo:list-item>
                    <fo:list-item-label end-indent="label-end ()"><fo:block>&bullet;</fo:block></fo:list-item-label>
                    <fo:list-item-body start-indent="body-start ()"><fo:block>is authorised to provide my/our TFN/ABN to the Nominee as required, even if the disclosure of my/our personal information is to an organisation overseas which is not subject to privacy obligations equivalent to those which apply to BIS.</fo:block></fo:list-item-body>
                  </fo:list-item>
                </fo:list-block>
              </fo:list-item-body>
            </fo:list-item>
          </fo:list-block>
          <fo:list-block space-after="6pt" provisional-distance-between-starts="5mm">
            <fo:list-item space-after="6pt">
              <fo:list-item-label end-indent="label-end ()"><fo:block>3)</fo:block></fo:list-item-label>
              <fo:list-item-body start-indent="body-start ()"><fo:block>I/We represent that, if at any time I/we supply BIS and RBS with personal information about another individual, I am/we are authorised to do so and agree to inform that individual of who BIS and RBS are and of the matters set out in this section of the Application Form.</fo:block></fo:list-item-body>
            </fo:list-item>
          </fo:list-block>

          <fo:block font-size="12pt" color="white" background-color="#004780" line-height="16pt" text-align="left" space-after="10pt" keep-with-next="always" padding-top="2pt" padding-left="2pt" padding-right="2pt">9.&nbsp;&nbsp;Signatures and Acknowledgements (continued)</fo:block>

          <fo:block space-before="6pt" keep-together="always">
            <fo:block font-size="11pt" font-weight="bold">ONLY PERSONS WITHIN AUSTRALIA MAY APPLY UNDER THIS PDS.</fo:block>
            <fo:block font-size="11pt" font-weight="bold" padding-top="5mm">Dated: <fo:inline padding-top="4mm" background-color="yellow">____/____</fo:inline>/2012</fo:block>
            <fo:block font-size="11pt" font-weight="bold" space-before="5mm" space-after="6pt">SIGNED, SEALED AND DELIVERED by:</fo:block>

            <xsl:if test="$privateIndividualsApplying">
              <fo:block font-size="11pt" font-weight="bold" space-after="6pt">(Individual Applicant, Joint Applicants or Individual Trustee Applicant)</fo:block>
              <fo:table space-after="6pt">
                <fo:table-column column-width="50%"/>
                <fo:table-column column-width="50%"/>
                <fo:table-body>
                  <xsl:for-each select="EXTRACT/APPLICANT[position () mod 2 = 1]">
                    <fo:table-row>
                      <xsl:for-each select=". | following-sibling::APPLICANT[position ()]">
                        <xsl:if test="position () &lt; 3">
                          <fo:table-cell>
                            <fo:block>&nbsp;</fo:block>
                            <fo:block padding-top="5mm" padding-bottom="0"><fo:inline padding-top="4mm" background-color="yellow">x _______________________________________</fo:inline></fo:block>
                            <fo:block space-after="6pt">Signature</fo:block>
                            <fo:block font-weight="bold">
                              <xsl:call-template name="pad"><xsl:with-param name="text" select="FIRSTNAME"/></xsl:call-template>
                              <xsl:value-of select="LASTNAME"/>
                            </fo:block>
                          </fo:table-cell>
                        </xsl:if>
                        <!--fo:table-cell><xsl:apply-templates select="." /></fo:table-cell-->
                      </xsl:for-each>
                    </fo:table-row>
                  </xsl:for-each>
                </fo:table-body>
              </fo:table>
            </xsl:if>

            <xsl:if test="$companyApplying">
              <fo:block font-size="11pt" font-weight="bold" space-before="6pt" space-after="6pt">(Company Applicant or Corporate Trustee Applicant)</fo:block>
              <fo:block font-size="11pt" font-weight="bold" space-after="6pt">Executed by: <fo:inline font-size="13pt"><xsl:value-of select="EXTRACT/APPLICATION/COMPANYNAME"/></fo:inline></fo:block>
              <fo:table space-after="16pt">
                <fo:table-column column-width="26%"/>
                <fo:table-column column-width="37%"/>
                <fo:table-column column-width="37%"/>
                <fo:table-body>
                  <fo:table-row>
                    <fo:table-cell number-columns-spanned="3"><fo:block>Affix Company Seal (if you have one)</fo:block></fo:table-cell>
                  </fo:table-row>
                  <xsl:for-each select="EXTRACT/APPLICANT[position () mod 2 = 1]">
                    <fo:table-row>
                      <fo:table-cell><fo:block>&nbsp;</fo:block></fo:table-cell>
                      <xsl:for-each select=". | following-sibling::APPLICANT[position ()]">
                        <xsl:if test="position () &lt; 3">
                          <fo:table-cell>
                            <fo:block>&nbsp;</fo:block>
                            <fo:block padding-top="5mm" padding-bottom="0"><fo:inline padding-top="4mm" background-color="yellow">x _________________________</fo:inline></fo:block>
                            <fo:block space-after="6pt">Signature</fo:block>
                            <fo:block font-weight="bold">
                              <xsl:call-template name="pad"><xsl:with-param name="text" select="FIRSTNAME"/></xsl:call-template>
                              <xsl:value-of select="LASTNAME"/>
                            </fo:block>
                          </fo:table-cell>
                        </xsl:if>
                        <!--fo:table-cell><xsl:apply-templates select="." /></fo:table-cell-->
                      </xsl:for-each>
                    </fo:table-row>
                  </xsl:for-each>
                </fo:table-body>
              </fo:table>
            </xsl:if>

            <xsl:if test="$companyApplying or $privateOrCorporateTrust">
              <fo:block font-size="11pt" font-weight="bold" space-before="6pt" space-after="6pt">(Guarantor for Company or Trust Applicants)</fo:block>
              <fo:table space-after="6pt">
                <fo:table-column column-width="50%"/>
                <fo:table-column column-width="50%"/>
                <fo:table-body>
                  <fo:table-row>
                    <fo:table-cell>
                      <fo:block padding-top="10mm" padding-bottom="0" margin-right="18mm" background-color="yellow">x ______________________________________</fo:block>
                      <fo:block>Guarantor's Signature</fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                      <fo:block padding-top="10mm" padding-bottom="0" margin-right="18mm" background-color="yellow">x ______________________________________</fo:block>
                      <fo:block>Guarantor's Name</fo:block>
                    </fo:table-cell>
                  </fo:table-row>
                </fo:table-body>
              </fo:table>
            </xsl:if>

            <fo:block space-before="1cm" background-color="#9DAFCE" padding="2mm">
              <fo:block font-size="11pt" font-weight="bold">For office use only</fo:block>
              <fo:block space-before="8mm">Loan Agreement and Put Option Agreement dated: ____/____/2012</fo:block>
              <fo:block space-before="8mm">OR</fo:block>
              <fo:block space-before="8mm">Put Agreement dated: ____/____/2012</fo:block>
              <fo:block space-before="8mm">SIGNED for BIS AG, Switzerland Branch by its authorised representatives:</fo:block>
            </fo:block>
          </fo:block>
          <fo:block>&nbsp;</fo:block>

          <!-- Section 10 -->

          <fo:block font-size="12pt" color="white" background-color="#004780" line-height="16pt" text-align="left" space-after="10pt" keep-with-next="always" padding-top="2pt" padding-left="2pt" padding-right="2pt">10.&nbsp;&nbsp;Checklist</fo:block>
          <fo:block font-size="10pt" font-weight="bold" space-after="18pt">Please ensure the checklist on the cover page of this application has been completed.</fo:block>

          <!-- Appendix A -->

          <fo:block font-size="12pt" color="white" background-color="#004780" line-height="16pt" text-align="left" space-after="10pt" keep-with-next="always" padding-top="2pt" padding-left="2pt" padding-right="2pt">Appendix A - Solicitor's Declaration for Trustee Applicants</fo:block>

          <fo:block space-after="18pt" keep-together="always">
            <xsl:choose>
              <xsl:when test="$privateOrCorporateTrust and $trustReviewDeeds">
                <fo:block font-size="10pt" font-weight="bold" start-indent="1cm">BIS to review trust deed.</fo:block>
              </xsl:when>
              <xsl:when test="$privateOrCorporateTrust">
                <fo:block font-size="11pt" font-weight="bold" space-after="10pt">This section is to be completed by the Trustee Applicant's Solicitor</fo:block>
                <fo:block space-before="5mm">I, ____________________________________________________, am a solicitor holding an unrestricted practising certificate.</fo:block>
                <fo:block start-indent="25mm">[ insert name of solicitor ]</fo:block>
                <fo:block space-before="5mm">I act for _________________________________________________________________________________ (the "Trustee")</fo:block>
                <fo:block space-before="5mm">and the ___________________________________________________________________________________ (the "Trust"),</fo:block>
                <fo:block start-indent="70mm">[ insert name of trust ]</fo:block>
                <fo:block space-before="5mm">for which the settlor is ________________________________________________________________________________,</fo:block>
                <fo:block start-indent="70mm">[ insert name of settlor ]</fo:block>
                <fo:block space-before="5mm">and the beneficiaries are: ______________________________________________________________________________</fo:block>
                <fo:block space-before="5mm">___________________________________________________________________________________________________</fo:block>
                <fo:block start-indent="70mm">[ insert name(s) ]</fo:block>
                <fo:block>&nbsp;</fo:block>
                <fo:block space-after="6pt">I have examined the following documents:</fo:block>
                <fo:list-block space-after="6pt" provisional-distance-between-starts="5mm">
                  <fo:list-item space-after="6pt" keep-together="always">
                    <fo:list-item-label end-indent="label-end ()"><fo:block>1.</fo:block></fo:list-item-label>
                    <fo:list-item-body start-indent="body-start ()">
                      <fo:block>
                        this Product Disclosure Statement and any supplemental product disclosure statements relating to the RBS Sweaty Global Fund
                        (together the "Product Disclosure Statement"),
                        including the Loan Agreement and Put Option Agreement set out therein;
                      </fo:block>
                    </fo:list-item-body>
                  </fo:list-item>
                  <fo:list-item space-after="6pt" keep-together="always">
                    <fo:list-item-label end-indent="label-end ()"><fo:block>2.</fo:block></fo:list-item-label>
                    <fo:list-item-body start-indent="body-start ()">
                      <fo:block>
                        the application by the Trustee in its capacity as trustee of the Trust for units in the RBS Sweaty Global Fund,
                        and for the Loan and Put Option or Put Option as applicable (the "Application");
                      </fo:block>
                    </fo:list-item-body>
                  </fo:list-item>
                  <fo:list-item space-after="6pt" keep-together="always">
                    <fo:list-item-label end-indent="label-end ()"><fo:block>3.</fo:block></fo:list-item-label>
                    <fo:list-item-body start-indent="body-start ()">
                      <fo:block>the trust deed establishing the Trust (the "Trust Deed"); and</fo:block>
                    </fo:list-item-body>
                  </fo:list-item>
                  <fo:list-item space-after="6pt" keep-together="always">
                    <fo:list-item-label end-indent="label-end ()"><fo:block>4.</fo:block></fo:list-item-label>
                    <fo:list-item-body start-indent="body-start ()">
                      <fo:block>all other documents necessary for me to give the opinion in this letter.</fo:block>
                    </fo:list-item-body>
                  </fo:list-item>
                </fo:list-block>
                <fo:block space-after="6pt">Based on my examination of those documents, it is my opinion that the Trustee:</fo:block>
                <fo:list-block space-after="6pt" provisional-distance-between-starts="5mm">
                  <fo:list-item space-after="6pt" keep-together="always">
                    <fo:list-item-label end-indent="label-end ()"><fo:block>1.</fo:block></fo:list-item-label>
                    <fo:list-item-body start-indent="body-start ()">
                      <fo:block>has full legal capacity and power under the Trust Deed to:</fo:block>
                      <fo:list-block provisional-distance-between-starts="5mm">
                        <fo:list-item>
                          <fo:list-item-label end-indent="label-end ()"><fo:block>(a)</fo:block></fo:list-item-label>
                          <fo:list-item-body start-indent="body-start ()"><fo:block>lodge the Application; and</fo:block></fo:list-item-body>
                        </fo:list-item>
                        <fo:list-item>
                          <fo:list-item-label end-indent="label-end ()"><fo:block>(b)</fo:block></fo:list-item-label>
                          <fo:list-item-body start-indent="body-start ()"><fo:block>carry out the transactions that the Application, Product Disclosure Statement, Loan Agreement and Put Option Agreement contemplate;</fo:block></fo:list-item-body>
                        </fo:list-item>
                      </fo:list-block>
                    </fo:list-item-body>
                  </fo:list-item>
                  <fo:list-item space-after="6pt" keep-together="always">
                    <fo:list-item-label end-indent="label-end ()"><fo:block>2.</fo:block></fo:list-item-label>
                    <fo:list-item-body start-indent="body-start ()">
                      <fo:block>has taken all action that is necessary or desirable under the Trust Deed or at law to:</fo:block>
                      <fo:list-block provisional-distance-between-starts="5mm">
                        <fo:list-item>
                          <fo:list-item-label end-indent="label-end ()"><fo:block>(a)</fo:block></fo:list-item-label>
                          <fo:list-item-body start-indent="body-start ()"><fo:block>authorise the Application;</fo:block></fo:list-item-body>
                        </fo:list-item>
                        <fo:list-item>
                          <fo:list-item-label end-indent="label-end ()"><fo:block>(b)</fo:block></fo:list-item-label>
                          <fo:list-item-body start-indent="body-start ()"><fo:block>carry out the transactions that the Application, Product Disclosure Statement, Loan Agreement and Put Option Agreement contemplate; and</fo:block></fo:list-item-body>
                        </fo:list-item>
                        <fo:list-item>
                          <fo:list-item-label end-indent="label-end ()"><fo:block>(c)</fo:block></fo:list-item-label>
                          <fo:list-item-body start-indent="body-start ()"><fo:block>ensure that the Application, Loan Agreement and Put Option Agreement are legal, valid and binding on it;</fo:block></fo:list-item-body>
                        </fo:list-item>
                      </fo:list-block>
                    </fo:list-item-body>
                  </fo:list-item>
                  <fo:list-item space-after="6pt" keep-together="always">
                    <fo:list-item-label end-indent="label-end ()"><fo:block>3.</fo:block></fo:list-item-label>
                    <fo:list-item-body start-indent="body-start ()">
                      <fo:block>
                        has the right to be fully indemnified out of the assets of the Trust to satisfy any liability arising under,
                        or in connection with,
                        the transactions that the Application, Product Disclosure Statement, Loan Agreement and Put Option Agreement contemplate.
                      </fo:block>
                    </fo:list-item-body>
                  </fo:list-item>
                </fo:list-block>
                <fo:block space-after="6pt">
                  I have not advised on the commerciality of the transactions that the Application and Product Disclosure Statement contemplate.
                </fo:block>
                <fo:block space-after="6pt">
                  This letter is for the sole benefit of BIS AG, Switzerland Branch and its related entities (together "BIS"),
                  and BIS may rely on this letter in deciding whether to accept the Application
                  and may do so whether or not it has been given or seen a copy of the Trust Deed.
                </fo:block>
                <fo:block space-before="10mm">Solicitor Name ______________________________________________________________________________</fo:block>
                <fo:block space-before="5mm">Solicitor Firm  _______________________________________________________________________________</fo:block>
                <fo:block space-before="5mm">Street Number &amp; Name or PO Box ______________________________________________________________</fo:block>
                <fo:block space-before="5mm">Suburb / City, State, Postcode ______________________________________&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;________&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;________</fo:block>
                <fo:block space-before="5mm">
                  Signature _______________________________________________&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  Date: ____/____/2012
                </fo:block>
              </xsl:when>
              <xsl:otherwise>
                <fo:block font-size="10pt" font-weight="bold" start-indent="1cm">Not a Trust Application.</fo:block>
              </xsl:otherwise>
            </xsl:choose>
          </fo:block>

          <!-- Appendix B -->

          <fo:block font-size="12pt" color="white" background-color="#004780" line-height="16pt" text-align="left" space-after="10pt" keep-with-next="always" padding-top="2pt" padding-left="2pt" padding-right="2pt">Appendix B - BIS Switzerland Direct Debit Request Service Agreement</fo:block>

          <xsl:choose>
            <xsl:when test="$isBorrowingFromUBS or $isPurchasingPutFromUBS">
              <xsl:call-template name="labelledLead"><xsl:with-param name="label" select="'1.'"/><xsl:with-param name="text">Debiting Your Account</xsl:with-param></xsl:call-template>
                <xsl:call-template name="labelledItem"><xsl:with-param name="label" select="'1.1'"/><xsl:with-param name="text">By completing a Direct Debit Request, you authorise BIS Switzerland to arrange for funds to be debited from the Account.</xsl:with-param></xsl:call-template>
                <xsl:call-template name="labelledItem"><xsl:with-param name="label" select="'1.2'"/><xsl:with-param name="text">BIS Switzerland will only arrange for funds to be debited from the Account as authorised in the Direct Debit Request.</xsl:with-param></xsl:call-template>
                <xsl:call-template name="labelledItem"><xsl:with-param name="label" select="'1.3'"/><xsl:with-param name="text">If the Debit Day falls on a day that is not a Banking Day, BIS Switzerland may direct Your Financial Institution to debit the Account on the following Banking Day. If you are unsure about the day on which the Account has or will be debited, you should ask Your Financial Institution.</xsl:with-param></xsl:call-template>
              <xsl:call-template name="labelledLead"><xsl:with-param name="label" select="'2.'"/><xsl:with-param name="text">Accounts</xsl:with-param></xsl:call-template>
                <xsl:call-template name="labelledItem"><xsl:with-param name="label" select="'2.1'"/><xsl:with-param name="text">You should check with Your Financial Institution whether direct debiting is available from the Account as direct debiting may not be available on all accounts offered by Your Financial Institution.</xsl:with-param></xsl:call-template>
                <xsl:call-template name="labelledItem"><xsl:with-param name="label" select="'2.2'"/><xsl:with-param name="text">You should also check that the Account details provided to BIS Switzerland are correct by checking them against a recent Account statement.</xsl:with-param></xsl:call-template>
              <xsl:call-template name="labelledLead"><xsl:with-param name="label" select="'3.'"/><xsl:with-param name="text">Your obligations</xsl:with-param></xsl:call-template>
                <xsl:call-template name="labelledItem"><xsl:with-param name="label" select="'3.1'"/><xsl:with-param name="text">It is your responsibility to ensure that there are sufficient clear funds available in the Account to allow a Debit Payment to be made in accordance with the Direct Debit Request.</xsl:with-param></xsl:call-template>
                <xsl:call-template name="labelledItem"><xsl:with-param name="label" select="'3.2'"/><xsl:with-param name="text">If there are insufficient funds in the Account to meet a Debit Payment:</xsl:with-param></xsl:call-template>
                  <xsl:call-template name="labelledSubItem"><xsl:with-param name="label" select="'a)'"/><xsl:with-param name="text">you may be charged a fee and/or interest by Your Financial Institution;</xsl:with-param></xsl:call-template>
                  <xsl:call-template name="labelledSubItem"><xsl:with-param name="label" select="'b)'"/><xsl:with-param name="text">you may also incur fees or charges imposed or incurred by BIS Switzerland; and</xsl:with-param></xsl:call-template>
                  <xsl:call-template name="labelledSubItem"><xsl:with-param name="label" select="'c)'"/><xsl:with-param name="text">you must immediately arrange for sufficient clear funds to be in the Account by an agreed time so that BIS Switzerland can process the Debit Payment.</xsl:with-param></xsl:call-template>
                <xsl:call-template name="labelledItem"><xsl:with-param name="label" select="'3.3'"/><xsl:with-param name="text">You should check the Account statement to verify that the amounts debited from the Account are correct.</xsl:with-param></xsl:call-template>
                <xsl:call-template name="labelledItem"><xsl:with-param name="label" select="'3.4'"/><xsl:with-param name="text">If BIS Switzerland is liable to pay Goods and Services Tax (GST) on a supply made in connection with this agreement, then you agree to pay BIS Switzerland on demand an additional amount equal to the consideration payable for the supply multiplied by the prevailing GST rate.</xsl:with-param></xsl:call-template>
              <xsl:call-template name="labelledLead"><xsl:with-param name="label" select="'4.'"/><xsl:with-param name="text">Errors</xsl:with-param></xsl:call-template>
                <xsl:call-template name="labelledItem"><xsl:with-param name="label" select="'4.1'"/><xsl:with-param name="text">If you believe that there has been an error in debiting the Account, you should notify BIS Switzerland directly on 1800 633 100 and confirm that notice in writing as soon as possible.</xsl:with-param></xsl:call-template>
                <xsl:call-template name="labelledItem"><xsl:with-param name="label" select="'4.2'"/><xsl:with-param name="text">If BIS Switzerland concludes as a result of our investigations that the Account has been incorrectly debited BIS Switzerland will arrange for Your Financial Institution to adjust the Account accordingly.</xsl:with-param></xsl:call-template>
                <xsl:call-template name="labelledItem"><xsl:with-param name="label" select="'4.3'"/><xsl:with-param name="text">If BIS Switzerland concludes as a result of our investigations that the Account has not been incorrectly debited BIS Switzerland will provide you with reasons and any evidence for this finding.</xsl:with-param></xsl:call-template>
                <xsl:call-template name="labelledItem"><xsl:with-param name="label" select="'4.4'"/><xsl:with-param name="text">Any queries about an error made in debiting the Account should be directed to BIS Switzerland in the first instance so that BIS Switzerland can attempt to resolve the matter with you. If the matter cannot be resolved in this manner BIS Switzerland may refer it to Your Financial Institution, which will obtain details from you of the disputed transaction.</xsl:with-param></xsl:call-template>
              <xsl:call-template name="labelledLead"><xsl:with-param name="label" select="'5.'"/><xsl:with-param name="text">Cancellation and changes</xsl:with-param></xsl:call-template>
                <xsl:call-template name="labelledItem"><xsl:with-param name="label" select="'5.1'"/><xsl:with-param name="text">You may cancel your authority for BIS Switzerland to debit the Account at any time by giving BIS Switzerland 30 days notice in writing. This notice should be given to BIS Switzerland in the first instance.</xsl:with-param></xsl:call-template>
                <xsl:call-template name="labelledItem"><xsl:with-param name="label" select="'5.2'"/><xsl:with-param name="text">BIS Switzerland may terminate these arrangements at any time by giving 10 days notice in writing to you.</xsl:with-param></xsl:call-template>
              <xsl:call-template name="labelledLead"><xsl:with-param name="label" select="'6.'"/><xsl:with-param name="text">Confidentiality</xsl:with-param></xsl:call-template>
                <xsl:call-template name="labelledItem"><xsl:with-param name="label" select="'6.1'"/><xsl:with-param name="text">BIS Switzerland will keep any information (including Account details) in your Direct Debit Request confidential.</xsl:with-param></xsl:call-template>
                <xsl:call-template name="labelledItem"><xsl:with-param name="label" select="'6.2'"/><xsl:with-param name="text">BIS Switzerland will only disclose information that it has about you:</xsl:with-param></xsl:call-template>
                  <xsl:call-template name="labelledSubItem"><xsl:with-param name="label" select="'a)'"/><xsl:with-param name="text">to the extent specifically required by law;</xsl:with-param></xsl:call-template>
                  <xsl:call-template name="labelledSubItem"><xsl:with-param name="label" select="'b)'"/><xsl:with-param name="text">for the purposes of this Direct Debit Agreement (including disclosing information in connection with any query or claim); or</xsl:with-param></xsl:call-template>
                  <xsl:call-template name="labelledSubItem"><xsl:with-param name="label" select="'c)'"/><xsl:with-param name="text">as permitted by the BIS Switzerland Loan Agreement.</xsl:with-param></xsl:call-template>
              <xsl:call-template name="labelledLead"><xsl:with-param name="label" select="'7.'"/><xsl:with-param name="text">Amendment</xsl:with-param></xsl:call-template>
                <xsl:call-template name="unlabelledItem"><xsl:with-param name="text">BIS Switzerland may amend this Direct Debit Agreement from time to time. BIS Switzerland will give you 10 Business Days notice of any amendment after which time the amendment is effective.</xsl:with-param></xsl:call-template>
              <xsl:call-template name="labelledLead"><xsl:with-param name="label" select="'8.'"/><xsl:with-param name="text">Governing Law</xsl:with-param></xsl:call-template>
                <xsl:call-template name="unlabelledItem"><xsl:with-param name="text">This Direct Debit Agreement is governed by and construed in accordance with the laws in force in New South Wales and you and BIS Switzerland submit to the non-exclusive jurisdiction of the courts of New South Wales (and courts which may hear appeals from those courts).</xsl:with-param></xsl:call-template>
              <xsl:call-template name="labelledLead"><xsl:with-param name="label" select="'9.'"/><xsl:with-param name="text">Notice</xsl:with-param></xsl:call-template>
                <xsl:call-template name="labelledItem"><xsl:with-param name="label" select="'9.1'"/><xsl:with-param name="text">If you wish to notify us in writing about anything relating to this agreement, you should write to us at the following address:</xsl:with-param></xsl:call-template>
                  <xsl:call-template name="unlabelledIndentedItemBold"><xsl:with-param name="text">BIS AG, Switzerland Branch</xsl:with-param></xsl:call-template>
                  <xsl:call-template name="unlabelledIndentedItemBold"><xsl:with-param name="text">Equity Operations - RBS Sweaty Global Fund</xsl:with-param></xsl:call-template>
                  <xsl:call-template name="unlabelledIndentedItemBold"><xsl:with-param name="text">GPO Box 4151</xsl:with-param></xsl:call-template>
                  <xsl:call-template name="unlabelledIndentedItemBold"><xsl:with-param name="text">Sydney NSW 2001</xsl:with-param></xsl:call-template>
                <xsl:call-template name="labelledItem"><xsl:with-param name="label" select="'9.2'"/><xsl:with-param name="text">We will notify you by sending a notice in the ordinary post to the address you have given us in the direct debit request.</xsl:with-param></xsl:call-template>
                <xsl:call-template name="labelledItem"><xsl:with-param name="label" select="'9.3'"/><xsl:with-param name="text">Any notice will be deemed to have been received on the third banking day after posting.</xsl:with-param></xsl:call-template>
              <xsl:call-template name="labelledLead"><xsl:with-param name="label" select="'10.'"/><xsl:with-param name="text">Interpretation</xsl:with-param></xsl:call-template>
                <xsl:call-template name="unlabelledItem"><xsl:with-param name="text">In this Direct Debit Request Service Agreement (Direct Debit Agreement) words have the meaning given to them below.</xsl:with-param></xsl:call-template>
                <xsl:call-template name="unlabelledItem"><xsl:with-param name="text"><fo:inline font-weight="bold">Account</fo:inline> means an account held at Your Financial Institution from which BIS Switzerland is authorised to arrange for funds to be debited.</xsl:with-param></xsl:call-template>
                <xsl:call-template name="unlabelledItem"><xsl:with-param name="text"><fo:inline font-weight="bold">Banking Day</fo:inline> means a day other than a Saturday or a Sunday or a public holiday throughout Switzerland.</xsl:with-param></xsl:call-template>
                <xsl:call-template name="unlabelledItem"><xsl:with-param name="text"><fo:inline font-weight="bold">Debit Day</fo:inline> means the day that payment is due from you to BIS Switzerland.</xsl:with-param></xsl:call-template>
                <xsl:call-template name="unlabelledItem"><xsl:with-param name="text"><fo:inline font-weight="bold">Debit Payment</fo:inline> means a particular transaction where a debit is made.</xsl:with-param></xsl:call-template>
                <xsl:call-template name="unlabelledItem"><xsl:with-param name="text"><fo:inline font-weight="bold">Direct Debit Request</fo:inline> means your direct debit request, which you make by completing and signing either:</xsl:with-param></xsl:call-template>
                  <xsl:call-template name="labelledItem"><xsl:with-param name="label" select="'(i)'"/><xsl:with-param name="text">the relevant part of the Application Form; or</xsl:with-param></xsl:call-template>
                  <xsl:call-template name="labelledItem"><xsl:with-param name="label" select="'(ii)'"/><xsl:with-param name="text">a separate document to a similar effect,</xsl:with-param></xsl:call-template>
                <xsl:call-template name="unlabelledItem"><xsl:with-param name="text">under which you authorise BIS Switzerland to arrange for funds to be debited from the Account to satisfy your obligations under the Loan Agreement and Put Option Agreement.</xsl:with-param></xsl:call-template>
                <xsl:call-template name="unlabelledItem"><xsl:with-param name="text"><fo:inline font-weight="bold">Your Financial Institution</fo:inline> means the Financial Institution at which the Account is kept.</xsl:with-param></xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
              <fo:block font-size="10pt" font-weight="bold" start-indent="1cm">Not borrowing or purchasing Puts from BIS.</fo:block>
            </xsl:otherwise>
          </xsl:choose>
          <fo:block>&nbsp;</fo:block>

          <!-- Appendix C -->

          <fo:block font-size="12pt" color="white" background-color="#004780" line-height="16pt" text-align="left" space-after="10pt" keep-with-next="always" padding-top="2pt" padding-left="2pt" padding-right="2pt">Appendix C - RBS Direct Debit Request Service Agreement</fo:block>

          <xsl:choose>
            <xsl:when test="not ($isBorrowingFromUBS)">
              <fo:block space-after="18pt" keep-together="always">
                <fo:table table-layout="fixed" space-after="10pt" border-style="solid" border-width="0.5pt">
                  <fo:table-column column-width="25%"/>
                  <fo:table-column column-width="75%"/>
                  <fo:table-body display-align="top">
                    <fo:table-row>
                      <fo:table-cell number-columns-spanned="2" border-style="solid" border-width="0.5pt" padding="2pt">
                        <fo:block text-align="left" font-style="italic" space-after="10pt">Request and Authority to debit the account named below to pay</fo:block>
                        <fo:block text-align="center">RBS Asset Management Limited</fo:block>
                      </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                      <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt"><fo:block>Request and Authority to debit</fo:block></fo:table-cell>
                      <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt">
                        <fo:block padding-top="5mm">Surname or company name <fo:inline padding-top="4mm" background-color="yellow">________________________________________</fo:inline></fo:block>
                        <fo:block padding-top="5mm" space-after="6pt">Given Names or ACN / ARBN <fo:inline padding-top="4mm" background-color="yellow">________________________________________</fo:inline> ("YOU")</fo:block>
                        <fo:block>
                          request and authorise <fo:inline font-weight="bold">RBS Asset Management Limited (Direct Debit ID 338844)</fo:inline> to arrange,
                          through its own financial institution,
                          for any amount RBS Asset Management Limited has deemed payable by you.
                          This debit or charge will be made through the Bulk Electronic Clearing System (BECS)
                          from your account held at the financial institution you have nominated below
                          and will be subject to the terms and conditions of the Direct Debit Request Service Agreement.
                        </fo:block>
                      </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                      <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt">
                        <fo:block>Details of Direct Debit</fo:block>
                        <fo:block>-application amount</fo:block>
                      </fo:table-cell>
                      <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt">
                        <fo:block font-weight="bold">Single Direct Debit of your nominated account in favour of the RBS Sweaty Global Fund Applications Account.</fo:block>
                        <fo:block text-align="right">
                          <fo:table>
                            <fo:table-body>
                              <fo:table-row display-align="center">
                                <fo:table-cell text-align="right"><fo:block>$</fo:block></fo:table-cell>
                                <fo:table-cell width="51mm"><fo:block>
                                  <fo:instream-foreign-object>
                                    <svg:svg width="50mm" height="8mm" xmlns:svg="http://www.w3.org/2000/svg">
                                      <svg:rect x="2%" y="2%" width="98%" height="98%" stroke="#004780" stroke-width="0.2pt" fill="yellow"/>
                                    </svg:svg>
                                  </fo:instream-foreign-object>
                                </fo:block></fo:table-cell>
                              </fo:table-row>
                            </fo:table-body>
                          </fo:table>
                        </fo:block>
                      </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                      <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt"><fo:block>Name and address of financial institution at which account is held</fo:block></fo:table-cell>
                      <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt">
                        <fo:block>Financial institution name: <fo:inline font-weight="bold"><xsl:value-of select="EXTRACT/APPLICATION/DDINSTITUTION"/></fo:inline></fo:block>
                        <fo:block>
                          Address:
                          <fo:inline font-weight="bold">
                            <xsl:call-template name="pad"><xsl:with-param name="text" select="EXTRACT/APPLICATION/DDINSTITUTIONADDRESS"/></xsl:call-template>
                            <xsl:call-template name="pad"><xsl:with-param name="text" select="EXTRACT/APPLICATION/DDINSTITUTIONSUBURB"/></xsl:call-template>
                            <xsl:call-template name="pad"><xsl:with-param name="text" select="EXTRACT/APPLICATION/DDINSTITUTIONPOSTCODE"/></xsl:call-template>
                            <xsl:value-of select="EXTRACT/APPLICATION/DDINSTITUTIONSTATE"/>
                          </fo:inline>
                        </fo:block>
                      </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                      <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt"><fo:block>Details of account to be debited</fo:block></fo:table-cell>
                      <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt">
                        <fo:block>
                          Note:
                          If also purchasing a Put Option this bank account must be the same as that provided in Section 6.
                        </fo:block>
                        <fo:block>&nbsp;</fo:block>
                        <fo:block>Name of account: <fo:inline font-weight="bold"><xsl:value-of select="EXTRACT/APPLICATION/DDACCOUNTNAME"/></fo:inline></fo:block>
                        <fo:block>
                          BSB:
                          <fo:inline font-weight="bold"><xsl:value-of select="substring (EXTRACT/APPLICATION/DDBSB, 1, 3)"/></fo:inline>-<fo:inline font-weight="bold"><xsl:value-of select="substring (EXTRACT/APPLICATION/DDBSB, 4, 3)"/></fo:inline>&nbsp;&nbsp;&nbsp;
                          Account number: <fo:inline font-weight="bold"><xsl:value-of select="EXTRACT/APPLICATION/DDACCOUNTNO"/></fo:inline>
                        </fo:block>
                      </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                      <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt"><fo:block>Acknowledgment</fo:block></fo:table-cell>
                      <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt"><fo:block>
                        By signing <fo:inline font-style="italic">and/or</fo:inline> providing us with a <fo:inline font-weight="bold">valid instruction</fo:inline> in respect to <fo:inline font-style="italic">your</fo:inline> Direct Debit
                        Request, you have understood and agreed to the terms and conditions governing
                        the debit arrangements between you and <fo:inline font-weight="bold">RBS Asset Management Limited</fo:inline> as set out
                        in this Request and in your Direct Debit Request Service Agreement.
                      </fo:block></fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                      <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt"><fo:block>Insert your signature and address</fo:block></fo:table-cell>
                      <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt">
                        <fo:block padding-top="5mm">Signature <fo:inline padding-top="4mm" background-color="yellow">__________________________________________________________</fo:inline></fo:block>
                        <fo:block space-before="5mm">(If signing for a company, sign and print full name and capacity for signing e.g. Director)</fo:block>
                        <fo:block padding-top="5mm">Address: <fo:inline padding-top="4mm" background-color="yellow">____________________________________________________________</fo:inline></fo:block>
                        <fo:block padding-top="5mm">Date: <fo:inline padding-top="4mm" background-color="yellow">____/____</fo:inline>/2012</fo:block>
                      </fo:table-cell>
                    </fo:table-row>
                  </fo:table-body>
                </fo:table>
              </fo:block>

              <xsl:call-template name="unlabelledItem"><xsl:with-param name="text">The following is your Direct Debit Service Agreement with RBS Asset Management Limited. The agreement is designed to explain what your obligations are when undertaking a Direct Debit arrangement with us. It also details what our obligations are to you as your Direct Debit Provider.</xsl:with-param></xsl:call-template>
              <xsl:call-template name="unlabelledItem"><xsl:with-param name="text">We recommend you keep this agreement in a safe place for future reference. It forms part of the terms and conditions of your Direct Debit Request (DDR) and should be read in conjunction with your DDR form.</xsl:with-param></xsl:call-template>
              <xsl:call-template name="boldLead"><xsl:with-param name="text">Definitions</xsl:with-param></xsl:call-template>
                <xsl:call-template name="unlabelledItem"><xsl:with-param name="text"><fo:inline font-weight="bold">account</fo:inline> means the account held at <fo:inline font-style="italic">your financial institution</fo:inline> from which <fo:inline font-style="italic">we</fo:inline> are authorised to arrange for funds to be debited.</xsl:with-param></xsl:call-template>
                <xsl:call-template name="unlabelledItem"><xsl:with-param name="text"><fo:inline font-weight="bold">agreement</fo:inline> means this Direct Debit Request Service Agreement between <fo:inline font-style="italic">you</fo:inline> and <fo:inline font-style="italic">us</fo:inline>.</xsl:with-param></xsl:call-template>
                <xsl:call-template name="unlabelledItem"><xsl:with-param name="text"><fo:inline font-weight="bold">banking day</fo:inline> means a day other than a Saturday or a Sunday or a public holiday listed throughout Switzerland.</xsl:with-param></xsl:call-template>
                <xsl:call-template name="unlabelledItem"><xsl:with-param name="text"><fo:inline font-weight="bold">debit day</fo:inline> means the day that payment by <fo:inline font-style="italic">you</fo:inline> to <fo:inline font-style="italic">us</fo:inline> is due.</xsl:with-param></xsl:call-template>
                <xsl:call-template name="unlabelledItem"><xsl:with-param name="text"><fo:inline font-weight="bold">debit payment</fo:inline> means a particular transaction where a debit is made.</xsl:with-param></xsl:call-template>
                <xsl:call-template name="unlabelledItem"><xsl:with-param name="text"><fo:inline font-weight="bold">direct debit request</fo:inline> means the Direct Debit Request between <fo:inline font-style="italic">us</fo:inline> and <fo:inline font-style="italic">you</fo:inline>.</xsl:with-param></xsl:call-template>
                <xsl:call-template name="unlabelledItem"><xsl:with-param name="text"><fo:inline font-weight="bold">us or we</fo:inline> means National Nominees Limited ACF RBS Asset Management Limited, (the Debit User) <fo:inline font-style="italic">you</fo:inline> have authorised by signing a <fo:inline font-style="italic">Direct Debit Request</fo:inline>.</xsl:with-param></xsl:call-template>
                <xsl:call-template name="unlabelledItem"><xsl:with-param name="text"><fo:inline font-weight="bold">you</fo:inline> means the customer who signed the <fo:inline font-style="italic">Direct Debit Request</fo:inline>.</xsl:with-param></xsl:call-template>
                <xsl:call-template name="unlabelledItem"><xsl:with-param name="text"><fo:inline font-weight="bold">your financial institution</fo:inline> means the financial institution nominated by <fo:inline font-style="italic">you</fo:inline> on the DDR at which the <fo:inline font-style="italic">account</fo:inline> is maintained.</xsl:with-param></xsl:call-template>
                <xsl:call-template name="labelledLead"><xsl:with-param name="label" select="'1.'"/><xsl:with-param name="text">Debiting your account</xsl:with-param></xsl:call-template>
                <xsl:call-template name="labelledItem"><xsl:with-param name="label" select="'1.1'"/><xsl:with-param name="text">By signing a <fo:inline font-style="italic">Direct Debit Request</fo:inline>, <fo:inline font-style="italic">you</fo:inline> have authorised <fo:inline font-style="italic">us</fo:inline> to arrange for funds to be debited from <fo:inline font-style="italic">your account</fo:inline>. <fo:inline font-style="italic">You</fo:inline> should refer to the <fo:inline font-style="italic">Direct Debit Request</fo:inline> and this <fo:inline font-style="italic">agreement</fo:inline> for the terms of the arrangement between <fo:inline font-style="italic">us</fo:inline> and <fo:inline font-style="italic">you</fo:inline>.</xsl:with-param></xsl:call-template>
                <xsl:call-template name="labelledItem"><xsl:with-param name="label" select="'1.2'"/><xsl:with-param name="text"><fo:inline font-style="italic">We</fo:inline> will only arrange for funds to be debited from <fo:inline font-style="italic">your account</fo:inline> as authorised in the <fo:inline font-style="italic">Direct Debit Request</fo:inline>, or <fo:inline font-style="italic">We</fo:inline> will only arrange for funds to be debited from <fo:inline font-style="italic">your account</fo:inline> if <fo:inline font-style="italic">we</fo:inline> have sent to the address nominated by <fo:inline font-style="italic">you</fo:inline> in the <fo:inline font-style="italic">Direct Debit Request</fo:inline>, a billing advice which specifies the amount payable by <fo:inline font-style="italic">you</fo:inline> to <fo:inline font-style="italic">us</fo:inline> and when it is due.</xsl:with-param></xsl:call-template>
                <xsl:call-template name="labelledItem"><xsl:with-param name="label" select="'1.3'"/><xsl:with-param name="text">If the <fo:inline font-style="italic">debit day</fo:inline> falls on a day that is not a <fo:inline font-style="italic">banking day</fo:inline>, <fo:inline font-style="italic">we</fo:inline> may direct <fo:inline font-style="italic">your financial institution</fo:inline> to debit <fo:inline font-style="italic">your account</fo:inline> on the following <fo:inline font-style="italic">banking day</fo:inline>. If <fo:inline font-style="italic">you</fo:inline> are unsure about which day <fo:inline font-style="italic">your account</fo:inline> has or will be debited <fo:inline font-style="italic">you</fo:inline> should ask <fo:inline font-style="italic">your financial institution</fo:inline>.</xsl:with-param></xsl:call-template>
              <xsl:call-template name="labelledLead"><xsl:with-param name="label" select="'2.'"/><xsl:with-param name="text">Amendments by us</xsl:with-param></xsl:call-template>
                <xsl:call-template name="labelledItem"><xsl:with-param name="label" select="'2.1'"/><xsl:with-param name="text"><fo:inline font-style="italic">We</fo:inline> may vary any details of this <fo:inline font-style="italic">agreement</fo:inline> or a <fo:inline font-style="italic">Direct Debit Request</fo:inline> at any time by giving <fo:inline font-style="italic">you</fo:inline> at least fourteen (14) days written notice.</xsl:with-param></xsl:call-template>
              <xsl:call-template name="labelledLead"><xsl:with-param name="label" select="'3.'"/><xsl:with-param name="text">Amendments by you</xsl:with-param></xsl:call-template>
                <xsl:call-template name="labelledItem"><xsl:with-param name="label" select="'3.1'"/><xsl:with-param name="text"><fo:inline font-style="italic">You</fo:inline> may change, stop or defer a <fo:inline font-style="italic">debit payment</fo:inline>, or terminate this <fo:inline font-style="italic">agreement</fo:inline> by providing <fo:inline font-style="italic">us</fo:inline> with at least fourteen (14 days) notification by writing to: <fo:inline font-weight="bold">RBS Asset Management Limited, GPO Box 101, Edinborough UK 10B0YT</fo:inline>, or by telephoning <fo:inline font-style="italic">us</fo:inline> on <fo:inline font-weight="bold">1300 12 90 92</fo:inline> during business hours; or arranging it through <fo:inline font-style="italic">your</fo:inline> own <fo:inline font-style="italic">financial institution</fo:inline>.</xsl:with-param></xsl:call-template>
              <xsl:call-template name="labelledLead"><xsl:with-param name="label" select="'4.'"/><xsl:with-param name="text">Your obligations</xsl:with-param></xsl:call-template>
                <xsl:call-template name="labelledItem"><xsl:with-param name="label" select="'4.1'"/><xsl:with-param name="text">It is <fo:inline font-style="italic">your</fo:inline> responsibility to ensure that there are sufficient clear funds available in <fo:inline font-style="italic">your account</fo:inline> to allow a <fo:inline font-style="italic">debit payment</fo:inline> to be made in accordance with the <fo:inline font-style="italic">Direct Debit Request</fo:inline>.</xsl:with-param></xsl:call-template>
                <xsl:call-template name="labelledItem"><xsl:with-param name="label" select="'4.2'"/><xsl:with-param name="text">If there are insufficient clear funds in <fo:inline font-style="italic">your account</fo:inline> to meet a <fo:inline font-style="italic">debit payment</fo:inline>:</xsl:with-param></xsl:call-template>
                  <xsl:call-template name="labelledSubItem"><xsl:with-param name="label" select="'(a)'"/><xsl:with-param name="text"><fo:inline font-style="italic">you</fo:inline> may be charged a fee and/or interest by <fo:inline font-style="italic">your financial institution</fo:inline>;</xsl:with-param></xsl:call-template>
                  <xsl:call-template name="labelledSubItem"><xsl:with-param name="label" select="'(b)'"/><xsl:with-param name="text"><fo:inline font-style="italic">you</fo:inline> may also incur fees or charges imposed or incurred by <fo:inline font-style="italic">us</fo:inline>; and</xsl:with-param></xsl:call-template>
                  <xsl:call-template name="labelledSubItem"><xsl:with-param name="label" select="'(c)'"/><xsl:with-param name="text"><fo:inline font-style="italic">you</fo:inline> must arrange for the <fo:inline font-style="italic">debit payment</fo:inline> to be made by another method or arrange for sufficient clear funds to be in <fo:inline font-style="italic">your account</fo:inline> by an agreed time so that <fo:inline font-style="italic">we</fo:inline> can process the <fo:inline font-style="italic">debit payment</fo:inline>.</xsl:with-param></xsl:call-template>
                <xsl:call-template name="labelledItem"><xsl:with-param name="label" select="'4.3'"/><xsl:with-param name="text"><fo:inline font-style="italic">You</fo:inline> should check <fo:inline font-style="italic">your account</fo:inline> statement to verify that the amounts debited from <fo:inline font-style="italic">your account</fo:inline> are correct</xsl:with-param></xsl:call-template>
                <xsl:call-template name="labelledItem"><xsl:with-param name="label" select="'4.4'"/><xsl:with-param name="text">If RBS Asset Management Limited is liable to pay Goods and Services Tax (GST) on a supply made in connection with this <fo:inline font-style="italic">agreement</fo:inline>, then <fo:inline font-style="italic">you</fo:inline> agree to pay RBS Asset Management Limited on demand an amount equal to the consideration payable for the supply multiplied by the prevailing GST rate.</xsl:with-param></xsl:call-template>
              <xsl:call-template name="labelledLead"><xsl:with-param name="label" select="'5.'"/><xsl:with-param name="text">Dispute</xsl:with-param></xsl:call-template>
                <xsl:call-template name="labelledItem"><xsl:with-param name="label" select="'5.1'"/><xsl:with-param name="text">If <fo:inline font-style="italic">you</fo:inline> believe that there has been an error in debiting <fo:inline font-style="italic">your account</fo:inline>, <fo:inline font-style="italic">you</fo:inline> should notify <fo:inline font-style="italic">us</fo:inline> directly on 1300 12 90 92 and confirm that notice in writing with <fo:inline font-style="italic">us</fo:inline> as soon as possible so that <fo:inline font-style="italic">we</fo:inline> can resolve <fo:inline font-style="italic">your</fo:inline> query more quickly. Alternatively <fo:inline font-style="italic">you</fo:inline> can take it up with <fo:inline font-style="italic">your financial institution</fo:inline> direct.</xsl:with-param></xsl:call-template>
                <xsl:call-template name="labelledItem"><xsl:with-param name="label" select="'5.2'"/><xsl:with-param name="text">If <fo:inline font-style="italic">we</fo:inline> conclude as a result of <fo:inline font-style="italic">our</fo:inline> investigations that <fo:inline font-style="italic">your account</fo:inline> has been incorrectly debited <fo:inline font-style="italic">we</fo:inline> will respond to <fo:inline font-style="italic">your</fo:inline> query by arranging for <fo:inline font-style="italic">your financial institution</fo:inline> to adjust <fo:inline font-style="italic">your account</fo:inline> (including interest and charges) accordingly. <fo:inline font-style="italic">We</fo:inline> will also notify <fo:inline font-style="italic">you</fo:inline> in writing of the amount by which <fo:inline font-style="italic">your account</fo:inline> has been adjusted.</xsl:with-param></xsl:call-template>
                <xsl:call-template name="labelledItem"><xsl:with-param name="label" select="'5.3'"/><xsl:with-param name="text">If <fo:inline font-style="italic">we</fo:inline> conclude as a result of <fo:inline font-style="italic">our</fo:inline> investigations that <fo:inline font-style="italic">your account</fo:inline> has not been incorrectly debited <fo:inline font-style="italic">we</fo:inline> will respond to <fo:inline font-style="italic">your</fo:inline> query by providing <fo:inline font-style="italic">you</fo:inline> with reasons and any evidence for this finding in writing.</xsl:with-param></xsl:call-template>
              <xsl:call-template name="labelledLead"><xsl:with-param name="label" select="'6.'"/><xsl:with-param name="text">Accounts</xsl:with-param></xsl:call-template>
                <xsl:call-template name="unlabelledItem"><xsl:with-param name="text"><fo:inline font-style="italic">You</fo:inline> should check:</xsl:with-param></xsl:call-template>
                  <xsl:call-template name="labelledItem"><xsl:with-param name="label" select="'(a)'"/><xsl:with-param name="text">with <fo:inline font-style="italic">your financial institution</fo:inline> whether direct debiting is available from <fo:inline font-style="italic">your account</fo:inline> as direct debiting is not available on all accounts offered by financial institutions.</xsl:with-param></xsl:call-template>
                  <xsl:call-template name="labelledItem"><xsl:with-param name="label" select="'(b)'"/><xsl:with-param name="text"><fo:inline font-style="italic">your account</fo:inline> details which <fo:inline font-style="italic">you</fo:inline> have provided to <fo:inline font-style="italic">us</fo:inline> are correct by checking them against a recent <fo:inline font-style="italic">account</fo:inline> statement; and</xsl:with-param></xsl:call-template>
                  <xsl:call-template name="labelledItem"><xsl:with-param name="label" select="'(c)'"/><xsl:with-param name="text">with <fo:inline font-style="italic">your financial institution</fo:inline> before completing the <fo:inline font-style="italic">Direct Debit Request</fo:inline> if <fo:inline font-style="italic">you</fo:inline> have any queries about how to complete the <fo:inline font-style="italic">Direct Debit Request</fo:inline>.</xsl:with-param></xsl:call-template>
              <xsl:call-template name="labelledLead"><xsl:with-param name="label" select="'7.'"/><xsl:with-param name="text">Confidentiality</xsl:with-param></xsl:call-template>
                <xsl:call-template name="labelledItem"><xsl:with-param name="label" select="'7.1'"/><xsl:with-param name="text"><fo:inline font-style="italic">We</fo:inline> will keep any information (including <fo:inline font-style="italic">your account</fo:inline> details) in <fo:inline font-style="italic">your Direct Debit Request</fo:inline> confidential. <fo:inline font-style="italic">We</fo:inline> will make reasonable efforts to keep any such information that <fo:inline font-style="italic">we</fo:inline> have about <fo:inline font-style="italic">you</fo:inline> secure and to ensure that any of <fo:inline font-style="italic">our</fo:inline> employees or agents who have access to information about <fo:inline font-style="italic">you</fo:inline> do not make any unauthorised use, modification, reproduction or disclosure of that information.</xsl:with-param></xsl:call-template>
                <xsl:call-template name="labelledItem"><xsl:with-param name="label" select="'7.2'"/><xsl:with-param name="text"><fo:inline font-style="italic">We</fo:inline> will only disclose information that <fo:inline font-style="italic">we</fo:inline> have about <fo:inline font-style="italic">you</fo:inline>:</xsl:with-param></xsl:call-template>
                  <xsl:call-template name="labelledSubItem"><xsl:with-param name="label" select="'(a)'"/><xsl:with-param name="text">to the extent specifically required by law; or</xsl:with-param></xsl:call-template>
                  <xsl:call-template name="labelledSubItem"><xsl:with-param name="label" select="'(b)'"/><xsl:with-param name="text">for the purposes of this <fo:inline font-style="italic">agreement</fo:inline> (including disclosing information in connection with any query or claim).</xsl:with-param></xsl:call-template>
              <xsl:call-template name="labelledLead"><xsl:with-param name="label" select="'8.'"/><xsl:with-param name="text">Notice</xsl:with-param></xsl:call-template>
                <xsl:call-template name="labelledItem"><xsl:with-param name="label" select="'8.1'"/><xsl:with-param name="text">If <fo:inline font-style="italic">you</fo:inline> wish to notify <fo:inline font-style="italic">us</fo:inline> in writing about anything relating to this <fo:inline font-style="italic">agreement</fo:inline>, <fo:inline font-style="italic">you</fo:inline> should write to RBS Asset Management Limited, GPO Box 101, Edinborough UK 10B0YT</xsl:with-param></xsl:call-template>
                <xsl:call-template name="labelledItem"><xsl:with-param name="label" select="'8.2'"/><xsl:with-param name="text"><fo:inline font-style="italic">We</fo:inline> will notify <fo:inline font-style="italic">you</fo:inline> by sending a notice in the ordinary post to the address <fo:inline font-style="italic">you</fo:inline> have given <fo:inline font-style="italic">us</fo:inline> in the <fo:inline font-style="italic">Direct Debit Request</fo:inline>.</xsl:with-param></xsl:call-template>
                <xsl:call-template name="labelledItem"><xsl:with-param name="label" select="'8.3'"/><xsl:with-param name="text">Any notice will be deemed to have been received on the third <fo:inline font-style="italic">banking day</fo:inline> after posting.</xsl:with-param></xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
              <fo:block font-size="10pt" font-weight="bold" start-indent="1cm">Not purchasing directly from RBS.</fo:block>
            </xsl:otherwise>
          </xsl:choose>
          <fo:block>&nbsp;</fo:block>

          <fo:block id="TheEnd"/>
        </fo:flow>
      </fo:page-sequence>
    </fo:root>
  </xsl:template>

  <xsl:template name="onePerson">
    <xsl:param name="personNumber"/>
    <xsl:param name="beneficialOwnerSection"/>
    <xsl:param name="individualApplication"/>
    <xsl:param name="privateIndividualsApplying"/>
    <xsl:variable name="sequenceLetter" select="substring ('abcdefghijklmnopqrstuvwxyz', $personNumber, 1)"/>
    <xsl:variable name="title">
      <xsl:choose>
        <xsl:when test="$beneficialOwnerSection">Beneficial Owner</xsl:when>
        <xsl:otherwise>Applicant</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <fo:block keep-together="always" space-after="18pt">
      <fo:block font-size="10pt" font-weight="bold" space-after="10pt">
        (<xsl:value-of select="$sequenceLetter"/>)&nbsp;<xsl:value-of select="$title"/>&nbsp;<xsl:value-of select="$personNumber"/>
        <xsl:if test="$beneficialOwnerSection">&nbsp;(in addition to or instead of persons identified in 3A, above)</xsl:if>
      </fo:block>
      <fo:table table-layout="fixed" border-style="solid" border-width="0.5pt">
        <fo:table-column column-width="35%"/>
        <fo:table-column column-width="65%"/>
        <fo:table-body display-align="center">
          <xsl:if test="not ($beneficialOwnerSection)">
            <xsl:if test="not ($privateIndividualsApplying)">
              <fo:table-row>
                <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt"><fo:block>Applicant is the guarantor for a company or trust applicant?</fo:block></fo:table-cell>
                <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt" font-weight="bold"><fo:block>
                  <xsl:call-template name="yesNo"><xsl:with-param name="testTrue" select="ISGUARANTOR = 'true'"/></xsl:call-template>
                </fo:block></fo:table-cell>
              </fo:table-row>
            </xsl:if>
            <fo:table-row>
              <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt"><fo:block>Applicant Type</fo:block></fo:table-cell>
              <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt" font-weight="bold"><fo:block>
                <xsl:call-template name="applicantType">
                  <xsl:with-param name="isApplicant" select="ISAPPLICANT"/>
                  <xsl:with-param name="isGuarantor" select="ISGUARANTOR"/>
                  <xsl:with-param name="isDirector" select="ISDIRECTOR"/>
                  <xsl:with-param name="isSoleDirector" select="ISSOLEDIRECTOR"/>
                  <xsl:with-param name="isCompanySecretary" select="ISCOMPANYSECRETARY"/>
                  <xsl:with-param name="isTrustee" select="ISTRUSTEE"/>
                  <xsl:with-param name="isBeneficiary" select="ISBENEFICIARY"/>
                  <xsl:with-param name="individualApplication" select="$individualApplication"/>
                </xsl:call-template>
              </fo:block></fo:table-cell>
            </fo:table-row>
          </xsl:if>
          <fo:table-row>
            <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt"><fo:block><xsl:value-of select="$title"/> Name</fo:block></fo:table-cell>
            <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt" font-weight="bold"><fo:block>
              <xsl:call-template name="pad"><xsl:with-param name="text" select="TITLE"/></xsl:call-template>
              <xsl:call-template name="pad"><xsl:with-param name="text" select="FIRSTNAME"/></xsl:call-template>
              <xsl:call-template name="pad"><xsl:with-param name="text" select="MIDDLENAME"/></xsl:call-template>
              <xsl:value-of select="LASTNAME"/>
            </fo:block></fo:table-cell>
          </fo:table-row>
          <fo:table-row>
            <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt"><fo:block>Residential Address</fo:block></fo:table-cell>
            <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt" font-weight="bold">
              <fo:block><xsl:value-of select="ADDRESS1"/></fo:block>
              <fo:block><xsl:value-of select="ADDRESS2"/></fo:block>
              <fo:block>
                <xsl:call-template name="pad3"><xsl:with-param name="text" select="SUBURB"/></xsl:call-template>
                <xsl:call-template name="pad3"><xsl:with-param name="text" select="STATE"/></xsl:call-template>
                <xsl:call-template name="pad3"><xsl:with-param name="text" select="POSTCODE"/></xsl:call-template>
                <xsl:value-of select="COUNTRY"/>
              </fo:block>
            </fo:table-cell>
          </fo:table-row>
          <fo:table-row>
            <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt"><fo:block>TFN / ABN *</fo:block></fo:table-cell>
            <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt" font-weight="bold"><fo:block>
              <xsl:value-of select="TFN" /> / <xsl:value-of select="ABN" />
            </fo:block></fo:table-cell>
          </fo:table-row>
          <fo:table-row>
            <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt"><fo:block>Date of Birth</fo:block></fo:table-cell>
            <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt" font-weight="bold"><fo:block>
              <xsl:call-template name="formatDate"><xsl:with-param name="date" select="DATEOFBIRTH"/></xsl:call-template>
            </fo:block></fo:table-cell>
          </fo:table-row>
          <fo:table-row>
            <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt"><fo:block>Place of Birth</fo:block></fo:table-cell>
            <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt" font-weight="bold"><fo:block><xsl:value-of select="TOWNOFBIRTH"/>,&nbsp;&nbsp;<xsl:value-of select="COUNTRYOFBIRTH"/></fo:block></fo:table-cell>
          </fo:table-row>
          <fo:table-row>
            <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt"><fo:block>Nationality</fo:block></fo:table-cell>
            <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt" font-weight="bold"><fo:block><xsl:value-of select="NATIONALITY"/></fo:block></fo:table-cell>
          </fo:table-row>
          <fo:table-row>
            <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt"><fo:block>Passport Number</fo:block></fo:table-cell>
            <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt" font-weight="bold"><fo:block><xsl:value-of select="PASSPORTNO"/></fo:block></fo:table-cell>
          </fo:table-row>
          <fo:table-row>
            <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt"><fo:block>Driver's Licence Number</fo:block></fo:table-cell>
            <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt" font-weight="bold"><fo:block><xsl:value-of select="DRIVERSLICENCENO"/></fo:block></fo:table-cell>
          </fo:table-row>
          <fo:table-row>
            <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt"><fo:block>Occupation and Employer</fo:block></fo:table-cell>
            <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt" font-weight="bold"><fo:block><xsl:value-of select="OCCUPATION"/>&nbsp;&nbsp;---&nbsp;&nbsp;<xsl:value-of select="EMPLOYER"/></fo:block></fo:table-cell>
          </fo:table-row>
          <fo:table-row>
            <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt"><fo:block>Source of Wealth</fo:block></fo:table-cell>
            <fo:table-cell border-style="solid" border-width="0.5pt" padding="2pt" font-weight="bold"><fo:block>
              <xsl:call-template name="sourceOfWealth">
                <xsl:with-param name="employment" select="WEALTHBYEMPLOYMENT"/>
                <xsl:with-param name="investments" select="WEALTHBYINVESTMENTS"/>
                <xsl:with-param name="other" select="WEALTHBYOTHER"/>
                <xsl:with-param name="otherInfo" select="WEALTHBYOTHERINFO"/>
              </xsl:call-template>
            </fo:block></fo:table-cell>
          </fo:table-row>
        </fo:table-body>
      </fo:table>
    </fo:block>
  </xsl:template>

  <xsl:template name="financials">
    <xsl:param name="cash"/>
    <xsl:param name="shares"/>
    <xsl:param name="otherliquid"/>
    <xsl:param name="residentialProperty"/>
    <xsl:param name="investmentProperty"/>
    <xsl:param name="otherAssets"/>
    <xsl:param name="otherAssetsDetails"/>
    <xsl:param name="otherLoansSecured"/>
    <xsl:param name="loansResidentialProperty"/>
    <xsl:param name="loansInvestmentProperty"/>
    <xsl:param name="loansPersonalUnsecured"/>
    <xsl:param name="guaranteesGranted"/>
    <xsl:param name="otherLiabilities"/>
    <xsl:param name="otherLiabilitiesDetails"/>
    <xsl:param name="salary"/>
    <xsl:param name="rentalAndDividend"/>
    <xsl:param name="otherIncome"/>
    <xsl:param name="otherIncomeDetails"/>
    <xsl:param name="taxPayable"/>
    <xsl:param name="taxPayableDate"/>
    <xsl:param name="interestOnSecuredLoans"/>
    <xsl:param name="interestOnUnsecuredLoans"/>
    <xsl:param name="livingExpenses"/>
    <xsl:param name="otherExpenses"/>
    <xsl:param name="otherExpensesDetails"/>
    <xsl:variable name="totalAssets" select="$cash + $shares + $otherliquid + $residentialProperty + $investmentProperty + $otherAssets"/>
    <xsl:variable name="totalLiabilities" select="$otherLoansSecured + $loansResidentialProperty + $loansInvestmentProperty + $loansPersonalUnsecured + $guaranteesGranted + $otherLiabilities"/>
    <xsl:variable name="totalNettAssets" select="$totalAssets - $totalLiabilities"/>
    <xsl:variable name="totalGrossIncome" select="$salary + $rentalAndDividend + $otherIncome"/>
    <xsl:variable name="totalAfterTaxIncome" select="$totalGrossIncome - $taxPayable"/>
    <xsl:variable name="totalExpenditure" select="$interestOnSecuredLoans + $interestOnUnsecuredLoans + $livingExpenses + $otherExpenses"/>
    <xsl:variable name="totalNettIncomeAvailable" select="$totalAfterTaxIncome - $totalExpenditure"/>
    <fo:block space-after="18pt" keep-together="always">
      <fo:table>
        <fo:table-column column-width="38%"/>
        <fo:table-column column-width="12%"/>
        <fo:table-column column-width="38%"/>
        <fo:table-column column-width="12%"/>
        <fo:table-body display-align="center">
          <fo:table-row>
            <fo:table-cell text-align="center" font-weight="bold" number-columns-spanned="2" padding-left="2mm" padding-right="2mm"><fo:block>Assets</fo:block></fo:table-cell>
            <fo:table-cell text-align="center" font-weight="bold" number-columns-spanned="2" padding-left="2mm" padding-right="2mm"><fo:block>Liabilities</fo:block></fo:table-cell>
          </fo:table-row>
        </fo:table-body>
      </fo:table>
      <fo:table space-after="3pt" border-style="solid" border-width="0.5pt">
        <fo:table-column column-width="38%"/>
        <fo:table-column column-width="12%"/>
        <fo:table-column column-width="38%"/>
        <fo:table-column column-width="12%"/>
        <fo:table-body display-align="center">
          <fo:table-row>
            <fo:table-cell text-align="right" border-style="solid" border-width="0.5pt" padding-left="2mm" padding-right="2mm"><fo:block>Cash</fo:block></fo:table-cell>
            <fo:table-cell text-align="right" border-style="solid" border-width="0.5pt" padding-left="2mm" padding-right="2mm"><fo:block><xsl:value-of select="format-number ($cash, '#,##0')"/></fo:block></fo:table-cell>
            <fo:table-cell text-align="right" border-style="solid" border-width="0.5pt" padding-left="2mm" padding-right="2mm"><fo:block>Loans secured against shares and managed funds</fo:block></fo:table-cell>
            <fo:table-cell text-align="right" border-style="solid" border-width="0.5pt" padding-left="2mm" padding-right="2mm"><fo:block><xsl:value-of select="format-number ($otherLoansSecured, '#,##0')"/></fo:block></fo:table-cell>
          </fo:table-row>
          <fo:table-row>
            <fo:table-cell text-align="right" border-style="solid" border-width="0.5pt" padding-left="2mm" padding-right="2mm"><fo:block>Shares</fo:block></fo:table-cell>
            <fo:table-cell text-align="right" border-style="solid" border-width="0.5pt" padding-left="2mm" padding-right="2mm"><fo:block><xsl:value-of select="format-number ($shares, '#,##0')"/></fo:block></fo:table-cell>
            <fo:table-cell text-align="right" border-style="solid" border-width="0.5pt" padding-left="2mm" padding-right="2mm"><fo:block>Loans secured against residential property</fo:block></fo:table-cell>
            <fo:table-cell text-align="right" border-style="solid" border-width="0.5pt" padding-left="2mm" padding-right="2mm"><fo:block><xsl:value-of select="format-number ($loansResidentialProperty, '#,##0')"/></fo:block></fo:table-cell>
          </fo:table-row>
          <fo:table-row>
            <fo:table-cell text-align="right" border-style="solid" border-width="0.5pt" padding-left="2mm" padding-right="2mm"><fo:block>Managed funds and other liquid investments</fo:block></fo:table-cell>
            <fo:table-cell text-align="right" border-style="solid" border-width="0.5pt" padding-left="2mm" padding-right="2mm"><fo:block><xsl:value-of select="format-number ($otherliquid, '#,##0')"/></fo:block></fo:table-cell>
            <fo:table-cell text-align="right" border-style="solid" border-width="0.5pt" padding-left="2mm" padding-right="2mm"><fo:block>Loans secured against investment property</fo:block></fo:table-cell>
            <fo:table-cell text-align="right" border-style="solid" border-width="0.5pt" padding-left="2mm" padding-right="2mm"><fo:block><xsl:value-of select="format-number ($loansInvestmentProperty, '#,##0')"/></fo:block></fo:table-cell>
          </fo:table-row>
          <fo:table-row>
            <fo:table-cell text-align="right" border-style="solid" border-width="0.5pt" padding-left="2mm" padding-right="2mm"><fo:block>Residential property</fo:block></fo:table-cell>
            <fo:table-cell text-align="right" border-style="solid" border-width="0.5pt" padding-left="2mm" padding-right="2mm"><fo:block><xsl:value-of select="format-number ($residentialProperty, '#,##0')"/></fo:block></fo:table-cell>
            <fo:table-cell text-align="right" border-style="solid" border-width="0.5pt" padding-left="2mm" padding-right="2mm"><fo:block>Personal unsecured loans</fo:block></fo:table-cell>
            <fo:table-cell text-align="right" border-style="solid" border-width="0.5pt" padding-left="2mm" padding-right="2mm"><fo:block><xsl:value-of select="format-number ($loansPersonalUnsecured, '#,##0')"/></fo:block></fo:table-cell>
          </fo:table-row>
          <fo:table-row>
            <fo:table-cell text-align="right" border-style="solid" border-width="0.5pt" padding-left="2mm" padding-right="2mm"><fo:block>Investment property</fo:block></fo:table-cell>
            <fo:table-cell text-align="right" border-style="solid" border-width="0.5pt" padding-left="2mm" padding-right="2mm"><fo:block><xsl:value-of select="format-number ($investmentProperty, '#,##0')"/></fo:block></fo:table-cell>
            <fo:table-cell text-align="right" border-style="solid" border-width="0.5pt" padding-left="2mm" padding-right="2mm"><fo:block>Guarantees granted</fo:block></fo:table-cell>
            <fo:table-cell text-align="right" border-style="solid" border-width="0.5pt" padding-left="2mm" padding-right="2mm"><fo:block><xsl:value-of select="format-number ($guaranteesGranted, '#,##0')"/></fo:block></fo:table-cell>
          </fo:table-row>
          <fo:table-row>
            <fo:table-cell text-align="right" border-style="solid" border-width="0.5pt" padding-left="2mm" padding-right="2mm">
              <fo:block>Other assets</fo:block>
              <fo:block><xsl:if test="number ($otherAssets) != '0'">(<xsl:value-of select="$otherAssetsDetails"/>)</xsl:if></fo:block>
            </fo:table-cell>
            <fo:table-cell text-align="right" border-style="solid" border-width="0.5pt" padding-left="2mm" padding-right="2mm"><fo:block><xsl:value-of select="format-number ($otherAssets, '#,##0')"/></fo:block></fo:table-cell>
            <fo:table-cell text-align="right" border-style="solid" border-width="0.5pt" padding-left="2mm" padding-right="2mm">
              <fo:block>Other liabilities</fo:block>
              <fo:block><xsl:if test="number ($otherLiabilities) != '0'">(<xsl:value-of select="$otherLiabilitiesDetails"/>)</xsl:if></fo:block>
            </fo:table-cell>
            <fo:table-cell text-align="right" border-style="solid" border-width="0.5pt" padding-left="2mm" padding-right="2mm"><fo:block><xsl:value-of select="format-number ($otherLiabilities, '#,##0')"/></fo:block></fo:table-cell>
          </fo:table-row>
          <fo:table-row font-weight="bold">
            <fo:table-cell text-align="right" border-style="solid" border-width="0.5pt" padding-left="2mm" padding-right="2mm"><fo:block>Total assets</fo:block></fo:table-cell>
            <fo:table-cell text-align="right" border-style="solid" border-width="0.5pt" padding-left="2mm" padding-right="2mm"><fo:block><xsl:value-of select="format-number ($totalAssets, '$#,##0')"/></fo:block></fo:table-cell>
            <fo:table-cell text-align="right" border-style="solid" border-width="0.5pt" padding-left="2mm" padding-right="2mm"><fo:block>Total liabilities</fo:block></fo:table-cell>
            <fo:table-cell text-align="right" border-style="solid" border-width="0.5pt" padding-left="2mm" padding-right="2mm"><fo:block><xsl:value-of select="format-number ($totalLiabilities, '$#,##0')"/></fo:block></fo:table-cell>
          </fo:table-row>
          <fo:table-row font-weight="bold">
            <fo:table-cell text-align="right" number-columns-spanned="3" border-style="solid" border-width="0.5pt" padding-left="2mm" padding-right="2mm"><fo:block>Net assets</fo:block></fo:table-cell>
            <fo:table-cell text-align="right" border-style="solid" border-width="0.5pt" padding-left="2mm" padding-right="2mm"><fo:block><xsl:value-of select="format-number ($totalNettAssets, '$#,##0')"/></fo:block></fo:table-cell>
          </fo:table-row>
        </fo:table-body>
      </fo:table>
      <fo:table>
        <fo:table-column column-width="38%"/>
        <fo:table-column column-width="12%"/>
        <fo:table-column column-width="38%"/>
        <fo:table-column column-width="12%"/>
        <fo:table-body display-align="center">
          <fo:table-row>
            <fo:table-cell text-align="center" font-weight="bold" number-columns-spanned="2" padding-left="2mm" padding-right="2mm"><fo:block>Annual Income</fo:block></fo:table-cell>
            <fo:table-cell text-align="center" font-weight="bold" number-columns-spanned="2" padding-left="2mm" padding-right="2mm"><fo:block>Annual Expenditure</fo:block></fo:table-cell>
          </fo:table-row>
        </fo:table-body>
      </fo:table>
      <fo:table space-after="10pt" border-style="solid" border-width="0.5pt">
        <fo:table-column column-width="38%"/>
        <fo:table-column column-width="12%"/>
        <fo:table-column column-width="38%"/>
        <fo:table-column column-width="12%"/>
        <fo:table-body display-align="center">
          <fo:table-row>
            <fo:table-cell text-align="right" border-style="solid" border-width="0.5pt" padding-left="2mm" padding-right="2mm"><fo:block>Salary (gross)</fo:block></fo:table-cell>
            <fo:table-cell text-align="right" border-style="solid" border-width="0.5pt" padding-left="2mm" padding-right="2mm"><fo:block><xsl:value-of select="format-number ($salary, '#,##0')"/></fo:block></fo:table-cell>
            <fo:table-cell text-align="right" border-style="solid" border-width="0.5pt" padding-left="2mm" padding-right="2mm"><fo:block>Mortgage and interest payments on secured loans</fo:block></fo:table-cell>
            <fo:table-cell text-align="right" border-style="solid" border-width="0.5pt" padding-left="2mm" padding-right="2mm"><fo:block><xsl:value-of select="format-number ($interestOnSecuredLoans, '#,##0')"/></fo:block></fo:table-cell>
          </fo:table-row>
          <fo:table-row>
            <fo:table-cell text-align="right" border-style="solid" border-width="0.5pt" padding-left="2mm" padding-right="2mm"><fo:block>Rental and dividend income</fo:block></fo:table-cell>
            <fo:table-cell text-align="right" border-style="solid" border-width="0.5pt" padding-left="2mm" padding-right="2mm"><fo:block><xsl:value-of select="format-number ($rentalAndDividend, '#,##0')"/></fo:block></fo:table-cell>
            <fo:table-cell text-align="right" border-style="solid" border-width="0.5pt" padding-left="2mm" padding-right="2mm"><fo:block>Interest payments on unsecured loans</fo:block></fo:table-cell>
            <fo:table-cell text-align="right" border-style="solid" border-width="0.5pt" padding-left="2mm" padding-right="2mm"><fo:block><xsl:value-of select="format-number ($interestOnUnsecuredLoans, '#,##0')"/></fo:block></fo:table-cell>
          </fo:table-row>
          <fo:table-row>
            <fo:table-cell text-align="right" border-style="solid" border-width="0.5pt" padding-left="2mm" padding-right="2mm">
              <fo:block>Other income</fo:block>
              <fo:block><xsl:if test="number ($otherIncome) != '0'">(<xsl:value-of select="$otherIncomeDetails"/>)</xsl:if></fo:block>
            </fo:table-cell>
            <fo:table-cell text-align="right" border-style="solid" border-width="0.5pt" padding-left="2mm" padding-right="2mm"><fo:block><xsl:value-of select="format-number ($otherIncome, '#,##0')"/></fo:block></fo:table-cell>
            <fo:table-cell text-align="right" border-style="solid" border-width="0.5pt" padding-left="2mm" padding-right="2mm"><fo:block>Living expenses and school fees</fo:block></fo:table-cell>
            <fo:table-cell text-align="right" border-style="solid" border-width="0.5pt" padding-left="2mm" padding-right="2mm"><fo:block><xsl:value-of select="format-number ($livingExpenses, '#,##0')"/></fo:block></fo:table-cell>
          </fo:table-row>
          <fo:table-row>
            <fo:table-cell text-align="right" border-style="solid" border-width="0.5pt" padding-left="2mm" padding-right="2mm"><fo:block>Total Gross Income</fo:block></fo:table-cell>
            <fo:table-cell text-align="right" border-style="solid" border-width="0.5pt" padding-left="2mm" padding-right="2mm"><fo:block><xsl:value-of select="format-number ($totalGrossIncome, '#,##0')"/></fo:block></fo:table-cell>
            <fo:table-cell text-align="right" border-style="solid" border-width="0.5pt" padding-left="2mm" padding-right="2mm">
              <fo:block>Other expenses</fo:block>
              <fo:block><xsl:if test="number ($otherExpenses) != '0'">(<xsl:value-of select="$otherExpensesDetails"/>)</xsl:if></fo:block>
            </fo:table-cell>
            <fo:table-cell text-align="right" border-style="solid" border-width="0.5pt" padding-left="2mm" padding-right="2mm"><fo:block><xsl:value-of select="format-number ($otherExpenses, '#,##0')"/></fo:block></fo:table-cell>
          </fo:table-row>
          <fo:table-row>
            <fo:table-cell text-align="right" border-style="solid" border-width="0.5pt" padding-left="2mm" padding-right="2mm"><fo:block>
              Tax payable
              <xsl:if test="number ($taxPayable) != '0'">(<xsl:call-template name="formatDate"><xsl:with-param name="date" select="$taxPayableDate"/></xsl:call-template>)</xsl:if>
            </fo:block></fo:table-cell>
            <fo:table-cell text-align="right" border-style="solid" border-width="0.5pt" padding-left="2mm" padding-right="2mm"><fo:block><xsl:value-of select="format-number ($taxPayable, '#,##0')"/></fo:block></fo:table-cell>
            <fo:table-cell text-align="right" border-style="solid" border-width="0.5pt" padding-left="2mm" padding-right="2mm"><fo:block>&nbsp;</fo:block></fo:table-cell>
            <fo:table-cell text-align="right" border-style="solid" border-width="0.5pt" padding-left="2mm" padding-right="2mm"><fo:block>&nbsp;</fo:block></fo:table-cell>
          </fo:table-row>
          <fo:table-row font-weight="bold">
            <fo:table-cell text-align="right" border-style="solid" border-width="0.5pt" padding-left="2mm" padding-right="2mm"><fo:block>Total after-tax income</fo:block></fo:table-cell>
            <fo:table-cell text-align="right" border-style="solid" border-width="0.5pt" padding-left="2mm" padding-right="2mm"><fo:block><xsl:value-of select="format-number ($totalAfterTaxIncome, '$#,##0')"/></fo:block></fo:table-cell>
            <fo:table-cell text-align="right" border-style="solid" border-width="0.5pt" padding-left="2mm" padding-right="2mm"><fo:block>Total expenditure</fo:block></fo:table-cell>
            <fo:table-cell text-align="right" border-style="solid" border-width="0.5pt" padding-left="2mm" padding-right="2mm"><fo:block><xsl:value-of select="format-number ($totalExpenditure, '$#,##0')"/></fo:block></fo:table-cell>
          </fo:table-row>
          <fo:table-row font-weight="bold">
            <fo:table-cell text-align="right" number-columns-spanned="3" border-style="solid" border-width="0.5pt" padding-left="2mm" padding-right="2mm"><fo:block>Net income available</fo:block></fo:table-cell>
            <fo:table-cell text-align="right" border-style="solid" border-width="0.5pt" padding-left="2mm" padding-right="2mm"><fo:block><xsl:value-of select="format-number ($totalNettIncomeAvailable, '$#,##0')"/></fo:block></fo:table-cell>
          </fo:table-row>
        </fo:table-body>
      </fo:table>
    </fo:block>
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

  <xsl:template name="sourceOfWealth">
    <xsl:param name="employment"/>
    <xsl:param name="investments"/>
    <xsl:param name="other"/>
    <xsl:param name="otherInfo"/>
    <xsl:variable name="flags" select="concat ($employment, $investments, $other)"/>
    <xsl:choose>
      <xsl:when test="$flags = 'falsefalsefalse'"></xsl:when>
      <xsl:when test="$flags = 'falsefalsetrue'">Other (<xsl:value-of select="$otherInfo"/>)</xsl:when>
      <xsl:when test="$flags = 'falsetruefalse'">Personal Investments</xsl:when>
      <xsl:when test="$flags = 'falsetruetrue'">Personal Investments and Other (<xsl:value-of select="$otherInfo"/>)</xsl:when>
      <xsl:when test="$flags = 'truefalsefalse'">Employment</xsl:when>
      <xsl:when test="$flags = 'truefalsetrue'">Employment and Other (<xsl:value-of select="$otherInfo"/>)</xsl:when>
      <xsl:when test="$flags = 'truetruefalse'">Employment and Personal Investments</xsl:when>
      <xsl:when test="$flags = 'truetruetrue'">Employment, Personal Investments and Other (<xsl:value-of select="$otherInfo"/>)</xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="applicantType">
    <xsl:param name="isDirector"/>
    <xsl:param name="isSoleDirector"/>
    <xsl:param name="isCompanySecretary"/>
    <xsl:param name="isTrustee"/>
    <xsl:param name="isBeneficiary"/>
    <xsl:param name="individualApplication"/>
    <xsl:variable name="flags" select="concat ($isDirector, $isSoleDirector, $isCompanySecretary, $isTrustee)"/>
    <xsl:choose>
      <xsl:when test="$flags = 'falsefalsefalsefalse'">
        <xsl:call-template name="ifElse"><xsl:with-param name="testTrue" select="$individualApplication"/><xsl:with-param name="then" select="'Individual'"/><xsl:with-param name="else" select="'Joint'"/></xsl:call-template>
        Applicant
      </xsl:when>
      <xsl:when test="$flags = 'falsefalsefalsetrue'">Trustee Applicant</xsl:when>
      <xsl:when test="$flags = 'falsefalsetruefalse'">Company Secretary</xsl:when>
      <xsl:when test="$flags = 'falsefalsetruetrue'">Company Secretary / Trustee Applicant</xsl:when>
      <xsl:when test="$flags = 'falsetruefalsefalse'">Sole Director</xsl:when>
      <xsl:when test="$flags = 'falsetruefalsetrue'">Sole Director / Trustee Applicant</xsl:when>
      <xsl:when test="$flags = 'falsetruetruefalse'">Sole Director / Company Secretary</xsl:when>
      <xsl:when test="$flags = 'falsetruetruetrue'">Sole Director / Company Secretary / Trustee Applicant</xsl:when>
      <xsl:when test="$flags = 'truefalsefalsefalse'">Director</xsl:when>
      <xsl:when test="$flags = 'truefalsefalsetrue'">Director / Trustee Applicant</xsl:when>
      <xsl:when test="$flags = 'truefalsetruefalse'">Director / Company Secretary</xsl:when>
      <xsl:when test="$flags = 'truefalsetruetrue'">Director / Company Secretary / Trustee Applicant</xsl:when>
      <xsl:when test="$flags = 'truetruefalsefalse'">Sole Director</xsl:when>
      <xsl:when test="$flags = 'truetruefalsetrue'">Sole Director / Trustee Applicant</xsl:when>
      <xsl:when test="$flags = 'truetruetruefalse'">Sole Director / Company Secretary</xsl:when>
      <xsl:when test="$flags = 'truetruetruetrue'">Sole Director / Company Secretary / Trustee Applicant</xsl:when>
    </xsl:choose>
    <xsl:if test="$isBeneficiary = 'true'">, Beneficial Owner</xsl:if>
  </xsl:template>

  <xsl:template name="yesNoBox">
    <xsl:param name="testTrue"/>
    <fo:table>
      <fo:table-column column-width="10mm"/>
      <fo:table-body>
        <fo:table-row>
          <fo:table-cell font-weight="bold" border-style="solid" border-width="0.5pt" border-color="#004780" padding="2pt" text-align="center">
            <fo:block><xsl:call-template name="yesNo"><xsl:with-param name="testTrue" select="$testTrue"/></xsl:call-template></fo:block>
          </fo:table-cell>
        </fo:table-row>
      </fo:table-body>
    </fo:table>
  </xsl:template>

  <xsl:template name="yesNo">
    <xsl:param name="testTrue"/>
    <xsl:call-template name="yesNoText"><xsl:with-param name="testTrue" select="$testTrue"/><xsl:with-param name="yesText" select="'Yes'"/><xsl:with-param name="noText" select="'No'"/></xsl:call-template>
  </xsl:template>

  <xsl:template name="yesNoText">
    <xsl:param name="testTrue"/>
    <xsl:param name="yesText"/>
    <xsl:param name="noText"/>
    <xsl:call-template name="ifElse"><xsl:with-param name="testTrue" select="$testTrue"/><xsl:with-param name="then" select="$yesText"/><xsl:with-param name="else" select="$noText"/></xsl:call-template>
  </xsl:template>

  <xsl:template name="firstOrSecond">
    <xsl:param name="first"/>
    <xsl:param name="second"/>
    <xsl:call-template name="ifElse"><xsl:with-param name="testTrue" select="$first != ''"/><xsl:with-param name="then" select="$first"/><xsl:with-param name="else" select="$second"/></xsl:call-template>
  </xsl:template>
  

  <xsl:template name="ifElse">
    <xsl:param name="testTrue"/>
    <xsl:param name="then"/>
    <xsl:param name="else"/>
    <xsl:choose>
      <xsl:when test="$testTrue"><xsl:value-of select="$then"/></xsl:when>
      <xsl:otherwise><xsl:value-of select="$else"/></xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="pad">
    <xsl:param name="text"/>
    <xsl:variable name="copy" select="$text"/>
    <xsl:if test="$text != ''"><xsl:value-of select="$text"/>&nbsp;</xsl:if>
  </xsl:template>

  <xsl:template name="pad3">
    <xsl:param name="text"/>
    <xsl:if test="$text != ''"><xsl:value-of select="$text"/>&nbsp;&nbsp;&nbsp;</xsl:if>
  </xsl:template>

  <xsl:template name="checkBoxLead">
    <xsl:param name="text"/>
    <fo:block font-weight="bold" space-before="6pt" space-after="3pt" keep-with-next="always"><xsl:copy-of select="$text"/></fo:block>
  </xsl:template>

  <xsl:template name="checkBoxItem">
    <xsl:param name="text"/>
    <fo:table space-after="1mm" table-layout="fixed">
      <fo:table-column column-width="9mm"/>
      <fo:table-column column-width="171mm"/>
      <fo:table-body display-align="center">
        <fo:table-row>
          <fo:table-cell>
            <fo:block>
              <fo:instream-foreign-object>
                <svg:svg width="6mm" height="5mm" xmlns:svg="http://www.w3.org/2000/svg">
                  <svg:rect x="2%" y="2%" width="95%" height="95%" stroke="#004780" stroke-width="0.2pt" fill="white"/>
                </svg:svg>
              </fo:instream-foreign-object>
            </fo:block>
          </fo:table-cell>
          <fo:table-cell><fo:block><xsl:copy-of select="$text"/></fo:block></fo:table-cell>
        </fo:table-row>
      </fo:table-body>
    </fo:table>
  </xsl:template>

  <xsl:template name="boldLead">
    <xsl:param name="text"/>
    <fo:block font-weight="bold" space-before="6pt" space-after="3pt" keep-with-next="always"><xsl:copy-of select="$text"/></fo:block>
  </xsl:template>

  <xsl:template name="labelledLead">
    <xsl:param name="label"/>
    <xsl:param name="text"/>
    <fo:table font-weight="bold" space-before="3pt" space-after="3pt" keep-with-next="always" table-layout="fixed">
      <fo:table-column column-width="7mm"/>
      <fo:table-column column-width="173mm"/>
      <fo:table-body>
        <fo:table-row>
          <fo:table-cell><fo:block><xsl:value-of select="$label"/></fo:block></fo:table-cell>
          <fo:table-cell><fo:block><xsl:copy-of select="$text"/></fo:block></fo:table-cell>
        </fo:table-row>
      </fo:table-body>
    </fo:table>
  </xsl:template>

  <xsl:template name="labelledItem">
    <xsl:param name="label"/>
    <xsl:param name="text"/>
    <fo:table space-after="0" table-layout="fixed">
      <fo:table-column column-width="7mm"/>
      <fo:table-column column-width="173mm"/>
      <fo:table-body>
        <fo:table-row>
          <fo:table-cell><fo:block><xsl:value-of select="$label"/></fo:block></fo:table-cell>
          <fo:table-cell><fo:block><xsl:copy-of select="$text"/></fo:block></fo:table-cell>
        </fo:table-row>
      </fo:table-body>
    </fo:table>
  </xsl:template>

  <xsl:template name="labelledSubItem">
    <xsl:param name="label"/>
    <xsl:param name="text"/>
    <fo:table space-after="0" table-layout="fixed">
      <fo:table-column column-width="7mm"/>
      <fo:table-column column-width="5mm"/>
      <fo:table-column column-width="168mm"/>
      <fo:table-body>
        <fo:table-row>
          <fo:table-cell><fo:block>&nbsp;</fo:block></fo:table-cell>
          <fo:table-cell><fo:block><xsl:value-of select="$label"/></fo:block></fo:table-cell>
          <fo:table-cell><fo:block><xsl:copy-of select="$text"/></fo:block></fo:table-cell>
        </fo:table-row>
      </fo:table-body>
    </fo:table>
  </xsl:template>

  <xsl:template name="unlabelledItem">
    <xsl:param name="text"/>
    <fo:block><xsl:copy-of select="$text"/></fo:block>
  </xsl:template>

  <xsl:template name="unlabelledIndentedItemBold">
    <xsl:param name="text"/>
    <fo:block font-weight="bold" start-indent="7mm"><xsl:copy-of select="$text"/></fo:block>
  </xsl:template>

  <xsl:template name="ljBullet">
    <xsl:param name="text"/>
    <fo:table space-after="0" table-layout="fixed">
      <fo:table-column column-width="4mm"/>
      <fo:table-column column-width="176mm"/>
      <fo:table-body>
        <fo:table-row>
          <fo:table-cell><fo:block>&bullet;</fo:block></fo:table-cell>
          <fo:table-cell><fo:block><xsl:copy-of select="$text"/></fo:block></fo:table-cell>
        </fo:table-row>
      </fo:table-body>
    </fo:table>
  </xsl:template>
</xsl:stylesheet>