<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html
     PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
     "DTD/xhtml1-transitional.dtd">
<%
/*******************************************************************************
**
**  Project Name    :  BIS Risk Management Products (RMP) Portal
**  Project Number  :  100181
**
**  Item            :  disclaimer.jsp
**  Ref Number      :  100181/T7/JSP/009
**  Description     :  This page displays the Instalment Warrant Disclaimers
**                     page, linking directly to the section requested by the
**                     user.
**
**
**  Configuration Record
**
**  Review             Version  Author           Date        Chg No.
**  100181/PML         1.0      P McLachlan     03/12/2012  Original
**
**
**  Copyright BIS, 2012
********************************************************************************
**  Revision History
**
**  Version   Description
**  1.0       Original
**  1.1       Removed "Instalment Warrant" from the sub-title of the
**            Tax Calculator and Pre-Trade Tool disclaimers
**  1.2       Changed static text and wording of Disclaimer heading.
**  1.3       Updated General, Pre-Trade and Tax Calculator disclaimer text.
**  1.4       Updated General Disclaimer and Privacy Policy text.
**  1.5       Moved GENERAL_DISCLAIMER bookmark, added Close button.
**  1.6       Reformatted Privacy Officer listings.
**  1.7       Replaced all BIS Warburg literals with BIS constant and static
**            text changes.
**  1.8       Date change for Instalment Warrant Tax Calculator section.
**  1.9       Changed "Protected Geared Investment" to "Protect Equity Product"
**  2.0       BIS rebranding
**  2.1       Entity change: BIS Capital Market Switzerland Ltd. 
                             -> BIS Capital Markets & Advisory Ltd.
**            + Privacy Officer change
**  2.3       Swiss BIS branch rebranding
**  2.4       Changed "Protect Equity Product" to "Protected Geared Investment"
**  2.5       Rebrand to BIS Global style
**
*******************************************************************************/
%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<title>RMP</title>
<!-- DO NOT ERASE SiteScopeGood -->
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link rel="stylesheet" href="../css/rmp.css" type="text/css" />

<%@ page import="com.ubsw.rmp.*" %>
<%@ page errorPage="../public/error.jsp" %>
<%@ include file="../common/constants.jsp" %>

<script type="text/javascript" src="../common/util.jsp"></script>
</head>

<body leftmargin="10" topmargin="10" marginheight="10" marginwidth="10">
<table border="0" cellpadding="0" cellspacing="0" width="560">
  <tr>
    <td valign="middle"><a name="<%= GENERAL_DISCLAIMER; %>"><img src="../images/title_disc.gif" width="119" height="31"
    alt="Disclaimers"/></a><br />
    <img src="../images/sub_ili.gif" width="310" height="31" alt="Important Legal Information"/></a></td>
  </tr>
  <tr>
    <td><img src="../images/spacer.gif" alt="" width="1" height="20" /></td>
  </tr>
  <tr>
    <td valign="middle" align="left">
        <p><span class="bold"><%= BIS; %> AG, Switzerland Branch (SBN 58 085 128 600) an Swiss Financial Services Licensee (Licence No. 213805), 
	is responsible for the information displayed on this website. "<%= BIS; %>" includes <%= BIS; %> AG, Switzerland Branch 
	and/or any related body corporate. </span></p>

	<p><span class="bold">No Offer, Recommendation or Personal Advice</span></br />
        Nothing on the website should be construed as a solicitation or offer, or recommendation, 
        to acquire or dispose of any investment, financial instrument or financial product or to engage 
	in any other transaction. The information is published solely for informational purposes 
	and has been prepared without taking account of the client's objectives, financial situation 
	or needs and because of that, the client should, before acting on the information, consider 
	the appropriateness of the information, having regard to the client's objectives, 
	financial situation and needs.</p>

	          <p><%= BIS; %> is not making any offer of any financial products on the website. 
		  Offers of financial products are made solely under and on the terms of 
		  the relevant Product Disclosure Statement. You should obtain a Product Disclosure Statement, 
		  which may be available on this website, and consider the Statement before making 
		  any decision about whether to acquire such products. An application for financial products 
		  can only be made on receipt of a form of application attached to or accompanying 
		  the Product Disclosure Statement under which the financial products are issued.</p>

	          <p><span class="bold">Information concerning Financial Products</span></br />
	          The information included on the website concerning the terms of any financial product 
		  are not complete and you should only rely on information contained within the Product 
		  Disclosure Statement and such further investigation as you deem necessary to make 
		  any investment decision.  In the case of any inconsistency between the terms of 
		  financial products set out in the website and the Product Disclosure Statement, 
		  the Statement will prevail. Any opinions expressed on the website are subject to 
		  change without notice and <%= BIS; %> is not under any obligation to update or keep current 
		  the information contained herein.</p>

	          <p>Not all financial products are suitable for all investors, and trading in certain 
		  instruments may be considered risky. Past performance is not necessarily indicative 
		  of future results. Foreign currency rates of exchange may adversely affect the value, 
		  price or income of any financial product, security or related instrument mentioned on this website.</p>

	          <p>For investment advice, trade execution or other enquiries, clients should contact their investment adviser.</p>

	          <p><span class="bold">Local Legal Restrictions</span></br />
	          The website is not directed to any person in any jurisdiction where 
		  (by reason of that person's nationality, residence or otherwise) 
		  the publication or availability of the website is prohibited. Persons in respect 
		  of whom such prohibitions apply must not access the website. The information on 
		  the website is for distribution only under such circumstances as may be permitted 
		  by applicable law. Additionally, it should be noted that many of the financial 
		  products detailed on this website are only available to Swiss investors.  
		  You should consult the relevant Product Disclosure Statement for further information 
		  about such restrictions.</p>

        <p><span class="bold">Material Interests</span></br />
        <%= BIS; %> and/or its directors, officers and employees or clients may have or have had interests 
	or long or short positions, and may at any time make purchases and/or sales as principal 
	or agent, in the relevant financial products or related financial instruments discussed 
	on the website. In addition, <%= BIS; %> may act or have acted as market maker in the relevant 
	financial products or related financial instruments discussed on the website. Furthermore, 
	<%= BIS; %> may have or have had a relationship with or may provide or have provided corporate finance, 
	capital markets and/or other financial services to the relevant companies. Employees of <%= BIS; %> 
	may serve or have served as officers or directors of the relevant companies. <%= BIS; %> may rely on 
	information barriers, such as "Chinese Walls," to control the flow of information contained 
	in one or more areas within <%= BIS; %> into other areas, units, groups or affiliates of <%= BIS; %>.</p>

        <p><span class="bold">No Liability</span></br />
        To the extent permitted by law, <%= BIS; %> accepts no liability whatsoever for any loss or 
	damage of any kind arising out of or in connection with the content, access of, use of, 
	performance of, browsing in the website or the linking to other sites from the website. 
	In particular, <%= BIS; %> takes no responsibility for the accuracy of the data, which may have 
	been sourced from third parties with no independent verification, and does not guarantee 
	it as being accurate or complete.</p>

        <p>The information contained on this website is of a general nature only. It does not 
	constitute the provision of taxation advice by <%= BIS; %> or any of its associated entities. 
	Investors are advised to seek independent taxation advice on the tax implications of 
	investing in this product in their particular circumstances.</p>

        <p><span class="bold">Additional information will be made available upon request.</span></br />
          � 2003 - 2012 <%= BIS; %>. All rights reserved. This information may not be reproduced or redistributed, 
	  in whole or in part, without the written permission of <%= BIS; %> and <%= BIS; %> accepts no liability whatsoever 
	  for the actions of third parties in this respect.</p> 
        </td>
      </tr>
      <tr>
        <td><img src="../images/spacer.gif" alt="" width="1" height="20" /></td>
      </tr>
      <tr>
        <td valign="middle"  height="21" class="subheading"><a name="<%= CORPORATE_ACTION_DISCLAIMER; %>"><img
	src="../images/sub_disc_ca.gif" width="192" height="31" alt="Corporate Actions"/></a></td>
      </tr>
      <tr>
        <td><img src="../images/spacer.gif" alt="" width="1" height="10" /></td>
      </tr>
      <tr>
        <td valign="middle" align="left">
        This list of corporate actions does not purport to be a comprehensive list, and is 
	published for informational purposes only from sources believed to be reliable. 
	This list of corporate actions is not guaranteed by <%= BIS; %> or any of its associated 
	entities as being a complete or accurate list.
        </td>
      </tr>
      <tr>
        <td><img src="../images/spacer.gif" alt="" width="1" height="20" /></td>
      </tr>
      <tr>
        <td valign="middle"  height="21" class="subheading"><a name="<%= PRIVACY_POLICY_DISCLAIMER; %>"><img
	src="../images/sub_disc_pp.gif" width="144" height="31" alt="Privacy Policy"/></a></td>
      </tr>
      <tr>
        <td><img src="../images/spacer.gif" alt="" width="1" height="10" /></td>
      </tr>
      <tr>
        <td valign="middle" align="left">
        <p>This policy governs the handling of all personal information in the possession of 
	any Swiss related body corporate or affiliate of <%= BIS; %> AG ("<%= BIS; %> AG Group").  
	<%= BIS; %> AG is incorporated in Switzerland and is the ultimate parent of any company 
	within the <%= BIS; %> AG Group.  There are many Swiss companies within the <%= BIS; %> AG 
	Group with whom you may have a relationship.  The main business entities, however, 
	are <%= BIS; %> AG, Switzerland Branch, <%= BIS; %> Securities Switzerland Ltd, <%= BIS; %> Nominees Pty Ltd, 
	<%= BIS; %> Private Clients Switzerland Ltd, <%= BIS; %> Private Clients Switzerland Nominees Pty Ltd 
	and <%= BIS; %> Global Asset Management (Switzerland) Ltd.</p>

        <p><span class="bold">1. What Personal Information does the <%= BIS; %> AG Group collect?</span></br />
        A member of the <%= BIS; %> AG Group with whom you have a relationship will collect, 
	use and store personal information that you provide or is gathered through 
	your use of a <%= BIS; %> AG website.  In limited circumstances, the <%= BIS; %> AG Group may 
	gather information on you from a third party.  The third parties, from whom the 
	<%= BIS; %> AG Group may acquire information include, but are not limited to, credit agencies, 
	financial advisers, fund managers or intermediaries and spouses.  
	Should a third party provide a member of the <%= BIS; %> AG Group with your personal information, 
	we assume that you have provided your consent to that third party.  
	If you have any problems or queries with the <%= BIS; %> AG Group obtaining information on 
	you from a third party, you should approach the relevant third party.  </p>

        <p>The personal information that you provide will be information which will 
	enable the <%= BIS; %> AG Group to identify you, your financial position and any 
	other related information necessary or incidental to the financial products 
	and services which the <%= BIS; %> AG Group provide to you.  If you do not provide 
	any of the information we request, we may not be able to provide you with 
	the services you require.</p>

        <p><span class="bold">2.  How will the <%= BIS; %> AG Group use your Personal Information</span></br />
        The <%= BIS; %> AG Group are extremely conscious of the importance of adequately protecting your 
	personal information.  You may be assured that all reasonable measures will be taken 
	by the <%= BIS; %> AG Group to protect the confidentiality of your personal information.  
	The purposes for which the <%= BIS; %> AG Group will use your personal information will 
	depend upon the relationship that you have with the <%= BIS; %> AG Group.  In most instances 
	your personal information will be used to:</p>

        <div class="list"><ul>
            <li>provide you with a financial or related service;</li>
            <li>monitor the quality of the service that we provide to you;</li>
            <li>improve, enhance and further our services;</li>
            <li>offer you further services, which may include using your information for marketing purposes; or</li>
            <li>comply with regulatory or legal requirements. These laws and regulations include, but are not limited to, the Corporations Act 2001 (Cth), the Proceeds of Crime Act 1987, Financial Transaction Reports Act 1988 and relevant Stock Exchange Business Rules.</li>
          </ul></div>

        <p>The <%= BIS; %> AG Group will use best endeavours to obtain your consent should your personal 
	information be used for any purpose other than those listed above.  However, you should 
	be aware that the <%= BIS; %> AG Group will be entitled to use your personal information for any 
	purpose which is related to the purposes listed above.   </p>

        <p><span class="bold">3.  Storage of your Personal Information</span></br />
        Your personal information will be stored in a secure environment either in writing, 
	electronically or both.  You may obtain further details on the exact nature of 
	where and how your information is stored by contacting our Privacy Officer, 
	whose details are provided in clause 4.  With the exceptions detailed within this policy, 
	your information will only be available to <%= BIS; %> AG Group employees on a need-to-know 
	basis in order to perform their obligations and duties. </p>

        <p><span class="bold">4.  Access to your Personal Information</span></br />
        Should you wish to know what personal information the <%= BIS; %> AG Group holds on you, 
	you may request to view this information by contacting our dedicated Privacy Officer:</p>

        <p><%= BIS; %> Private Clients
          <table width="100%" cellpadding="0" cellspacing="1" border="0">
            <tr>
              <td valign="middle" align="left" colspan="2">
                Ms Gayle Sharp
              </td>
            </tr>
            <tr>
              <td valign="middle" align="left" width="20%">
               Telephone:
              </td>
              <td valign="middle" align="left" width="80%">
              +61-3-9242 6128
              </td>
            </tr>
            <tr>
              <td valign="middle" align="left" width="20%">
                Email:
              </td>
              <td valign="middle" align="left" width="80%">
                <a class="stdlink" href="mailto:ben.bernancke@bis.com">ben.bernancke@bis.com</a>
              </td>
            </tr>
          </table>

        <p>BIS
        For Human Resources issues please contact:
          <table width="100%" cellpadding="0" cellspacing="1" border="0">
            <tr>
              <td valign="middle" align="left" colspan="2">
               Mr James Gordon
              </td>
            </tr>
            <tr>
              <td valign="middle" align="left" width="20%">
                Telephone:
              </td>
              <td valign="middle" align="left" width="80%">
              +61-2-9324 2062
              </td>
            </tr>
            <tr>
              <td valign="middle" align="left" width="20%">
                Email:
              </td>
              <td valign="middle" align="left" width="80%">
                <a class="stdlink" href="mailto:david.rockerfeller@bis.com">david.rockerfeller@bis.com</a>
              </td>
            </tr>
          </table>

        <p>For all other enquiries please contact:
          <table width="100%" cellpadding="0" cellspacing="1" border="0">
            <tr>
              <td valign="middle" align="left" colspan="2">
               Ms Kara Papaioannou
              </td>
            </tr>
            <tr>
              <td valign="middle" align="left" width="20%">
                Telephone:
              </td>
              <td valign="middle" align="left" width="80%">
              +61-2-9324 3238
              </td>
            </tr>
            <tr>
              <td valign="middle" align="left" width="20%">
                Email:
              </td>
              <td valign="middle" align="left" width="80%">
                <a class="stdlink" href="mailto:evelyn.derothschild@bis.com">evelyn.derothschild@bis.com</a>
              </td>
            </tr>
          </table>

        <p>The appropriate Privacy Officer will promptly investigate your privacy enquiry and provide you 
	with appropriate answers where required. We may charge a reasonable fee for access to this information.  
	Should you discover that any information is outdated, incorrect or incomplete you may request 
	to have the personal information corrected and the <%= BIS; %> AG Group will promptly update its records.  
	You may also contact the relevant Privacy Officer if you have any questions on our compliance 
	with the Privacy Act 1988 (Cth) or if you wish to make a complaint about our handling of your personal information. </p>

        <p><span class="bold">5.  Disclosure of Personal Information</span></br />
        You acknowledge and agree that your personal information may be disclosed to any of the following third parties: 
        <div class="list"><ul class="list">
            <li>Any regulatory or legal body which governs the 
	    conduct of any part of <%= BIS; %> AG Groups' business.  Whilst not exhaustive, 
	    the <%= BIS; %> AG Group will need to disclose to regulatory bodies such as 
	    the Swiss Securities &amp; Investment Commission and relevant stock exchanges.
	    </li>
            <li>Related bodies corporate of the <%= BIS; %> AG Group whether in Switzerland or any overseas jurisdiction.</li>
            <li>A third party who is supplying a service to a member of the <%= BIS; %> AG Group.  
	    The <%= BIS; %> AG Group may provide your personal information to third parties such as information 
	    technology maintenance companies, software providers and share registries.  
	    All reasonable steps will be taken by the <%= BIS; %> AG Group to ensure the security of 
	    your personal information if disclosed to a third party.</li>
	    <li>Any other third party provided that we obtain your prior written consent.</li>
          </ul></div>

        <p><span class="bold">6.  Disclosure of Information to Related Bodies Corporate</span></br />
         You acknowledge and agree that if you supply your personal information 
	 to any member of the <%= BIS; %> AG Group, this information may be transferred 
	 between related bodies corporate.  These related bodies corporate to whom 
	 your personal information may be transferred, can be registered and governed 
	 by laws outside the Swiss jurisdiction.  As such, the laws regulating 
	 a related body corporate may differ to Swiss laws and may apply a greater 
	 or lesser standard of protection for your personal information.  </p>

        <p>The <%= BIS; %> AG Group, however, are very conscious of the need to adequately protect 
	clients' personal information.  Should your personal information be transferred 
	to a jurisdiction with inadequate privacy protection, internal <%= BIS; %> AG policy will 
	impose the Swiss privacy standard or superior in relation to the treatment 
	and handling of your personal information. </p>

        <p><span class="bold">7.  <%= BIS; %> AG Group Websites</span></br />
         Many <%= BIS; %> AG Group websites that you may have access to utilise "cookies".  
	 A cookie is an electronic mechanism which can trace your access and use of 
	 information contained within our websites.  Should you use any <%= BIS; %> AG website 
	 you consent to the use of cookies by any member of the <%= BIS; %> AG Group.  
	 Any personal information obtained through the use of cookies will be used to 
	 enhance the products and services that the <%= BIS; %> AG Group provides to you.</p>

        <p><span class="bold">8.  Sensitive Information</span></br />
        In most cases a member of the <%= BIS; %> AG Group will not collect sensitive personal 
	information.  Sensitive personal information is information about an individual's 
	racial or ethnic origin, political opinions, membership of a political association, 
	religious beliefs or affiliations, philosophical beliefs, membership of a professional 
	or trade association, membership of a trade union, sexual preferences or practices, 
	criminal record, or health information. </p>

        <p>Where it is necessary for the <%= BIS; %> AG Group to collect your sensitive information, 
	if you provide the <%= BIS; %> AG Group with this information then you have consented to 
	this collection for the purposes of the Privacy Act 1988 (Cth). </p>

        <p><span class="bold">9.  Exemptions</span></br />
        This policy does not apply in respect of acts and practices of <%= BIS; %> which are directly 
	related to an employee record of a current or former employee.</p>
        </td>
      </tr>
      <tr>
        <td><img src="../images/spacer.gif" alt="" width="1" height="20" /></td>
      </tr>
      <tr>
        <td align="left"><a href="javascript:window.close()"><img src="../images/but_close.gif"
	  alt="Close" width="37" height="17" border="0" /></a></td>
      </tr>
      <tr>
        <td><img src="../images/spacer.gif" alt="" width="1" height="10" /></td>
      </tr>
    </table>
    </td>
  </tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" width="560">
  <tr>
    <td>
    <%@ include file="../common/disclaimer.jsp" %></td>
  </tr>
</table>
</body>
</html>
