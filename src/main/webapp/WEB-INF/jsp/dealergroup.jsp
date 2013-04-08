<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt1" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
  <head>
    <title>OPI - New Adviser</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
  
    <jsp:include flush="true" page="/WEB-INF/jsp/includes/scripts_and_styles.jsp"/>
    
    <style>
      body {font-family: Arial, Helvetica, Sans-Serif; font-size: 12px;}
      dl {}
      dt {clear: left; width: 100px; margin-bottom: 1em;}
      dd {clear: right; width: 95%; margin-top: -2.2em; margin-bottom: 1em; position: relative; left: 40px;}
      p {clear: both;}
      address {font-style: normal;}
      .section {
      }
    </style>
  </head>
  
  <body>
    <div id="wrapper">
      <jsp:include flush="true" page="/WEB-INF/jsp/includes/header.jsp"/>

      <!-- content -->
      <div id="content">
        <div class="breadcrumb-left">&#160;</div>
        <div class="breadcrumb-right">
          <a title="Logout of OPI" href="<c:url value="/j_spring_security_logout"/>">&gt;Logout</a>
          <a title="Show help page" href="javascript:ShowWinContact();%20void(0);">&gt;Help</a>
        </div>
        
        <br class="clear"/>
        
        <h1>Terms of Use</h1>
        
        <jsp:include flush="true" page="/WEB-INF/jsp/includes/errors_and_messages.jsp"/>

        <p style="text-align: center;">
          <strong>ONLINE APPLICATION PORTAL SYSTEM USE AGREEMENT</strong>
        </p>
        <p>
          This System Use Agreement (&quot;
          <strong>Agreement</strong>&quot;) is made between the user (&quot;
          <strong>Client</strong>&quot;) and UBS AG.
        </p>
        <p>
          The System (as defined in clause 1.2 below) is provided by UBS AG. However, specific content and Services (as
          defined in clause 1.2 below) provided to Client by means of the System may be provided by one or more of the
          subsidiaries and branches of UBS (&quot;
          <strong>UBS Affiliates</strong>&quot;) that are listed in the disclaimer(s) incorporated in the System (&quot;
          <strong>Disclaimer</strong>&quot;). In this Agreement &quot;
          <strong>UBS</strong>&quot; means UBS AG and/or the UBS Affiliates as the context requires.
        </p>
        <p>
          This Agreement and the Disclaimer are legally binding. By clicking the &lt;
          <strong>ACCEPT</strong>&gt; button at the end of this Agreement and accepting the Disclaimer, you are entering into
          this Agreement and accepting the Disclaimer for and on behalf of Client. By clicking the &lt;
          <strong>ACCEPT</strong>&gt; button you warrant and represent that you are duly authorised by Client to enter into
          this Agreement on Client's behalf and to use the System and the Services provided through the System, and that your
          accepting these terms and conditions in this manner shall give rise to a binding agreement between Client and UBS
          upon the terms of this System Use Agreement. For the avoidance of doubt, obligations imposed on the Client by this
          Agreement also extend to the Client’s employees and agents.
        </p>
        <dl>
          <dt class="section">
            <strong>1.</strong>
          </dt>
          <dd>
            <p>
              <strong>Licence to use the System and provision of the Services</strong>
            </p>
          </dd>
          <dt>
            1.1
          </dt>
          <dd>
            <p>
              UBS has developed certain extranet websites and software for the purpose of providing to financial advisors
              online application services in respect of clients of the financial advisor (&quot;
              <strong>Services</strong>&quot;).
            </p>
          </dd>
          <dt>
            1.2
          </dt>
          <dd>
            <p>
              UBS grants to Client and Client accepts, a non-exclusive, non-transferable licence to access and use such
              extranet websites, software, application status tracking, calculators and/or tools as UBS may offer to Client
              and Client may accept from time to time (the &quot;
              <strong>System</strong>&quot;) for Client's internal business purposes and not for any other purpose, and UBS
              agrees to provide through the System the Services, on the terms and subject to the conditions set out in this
              Agreement.
            </p>
          </dd>
          <dt class="section">
            <strong>2.</strong>
          </dt>
          <dd>
            <p>
              <strong>Services</strong>
            </p>
          </dd>
          <dt>
            2.1
          </dt>
          <dd>
            <p>
              The functionality of each element of the System and the Services may be added to, amended or withdrawn and new
              elements introduced by UBS in its complete discretion from time to time (each a &quot;
              <strong>Change</strong>&quot;). Prior to any Change, UBS may, in its complete discretion, notify Client of such
              Change. Client will not be entitled to continue to receive any System or Service which has been withdrawn by
              UBS. Following any Change, Client's continued use of the System and the Services will be deemed to constitute
              deemed acceptance of such Change.
            </p>
          </dd>
          <dt>
            2.2
          </dt>
          <dd>
            <p>
              If, in connection with a Change, any amendments to this Agreement are required, UBS will notify Client of such
              amendments by posting the amended version of this Agreement on the System. Client must accept the amended
              version of the Agreement prior to using the System and Services. If Client does not agree with such amendments,
              it should not accept the amended version of the Agreement and must discontinue its use of the System and
              Services.
            </p>
          </dd>
          <dt class="section">
            <strong>3.</strong>
          </dt>
          <dd>
            <p>
              <strong>Client Users</strong>
            </p>
          </dd>
          <dt>
            3.1
          </dt>
          <dd>
            <p>
              Client has notified UBS of the names of persons to have access to the System (&quot;
              <strong>Users</strong>&quot;). Client hereby represents and warrants to UBS that: (a) such Users shall be
              authorised to access and use the System on behalf of Client; (b) such Users are experienced and knowledgeable
              regarding the matters in respect of which they will use the System; (c) Client shall be bound by and accountable
              for each User's acts and omissions; and (d) in using the System and the Services, Client's Users will at all
              times be acting within the scope of their authority. Client agrees to promptly notify UBS of any changes to the
              authority or status of any User and acknowledges that UBS may rely exclusively on the names of the Users
              notified by Client to UBS in granting access to the System on behalf of Client.
            </p>
            <p>
              Upon receipt of such Users' names UBS shall, in reliance on Client's foregoing representations and warranties
              regarding such Users, allocate a username and password in respect of each User. Notwithstanding the foregoing,
              UBS retains the right, in its complete discretion, to deny any User access to the System. Each password will
              continue in force until it is terminated by UBS, changed by User or expires automatically after a period, if
              any, specified by UBS and UBS will provide the facility for Users to replace their passwords prior to such
              expiry. UBS may provide replacement username(s) and password(s) at any other time as it thinks fit. Client shall
              take, and procure that Users take, all reasonable steps to protect the security of such usernames and passwords
              and prevent any person who is not a User from accessing the System or using the Services. For the avoidance of
              doubt, each username and password is strictly confidential to and shall only be used by the User to whom it is
              issued and is not transferable.
            </p>
          </dd>
          <dt>
            3.2
          </dt>
          <dd>
            <p>
              Each User may be required to obtain from UBS or a third party certification authority, as determined by UBS, a
              digital certificate, in order to access the System and the Services. UBS will pay the normal fees (if any)
              charged by such certification authority in respect of such digital certificates. Client is responsible for
              maintaining the security and integrity of its digital certificates. The use of digital certificates may be
              subject to any terms and conditions specified by UBS or the certification authority. There are inherent
              limitations in the capabilities of and risks in the use of digital certificates. Client is responsible for
              familiarising itself with (and for procuring that each User familiarises himself/herself with) and evaluating
              all such terms and conditions, limitations and risks. Client and UBS may each revoke any of Client's digital
              certificates at any time.
            </p>
          </dd>
          <dt>
            3.3
          </dt>
          <dd>
            <p>
              Client will ensure that each User complies at all times with all applicable laws, rules and regulations
              (including those of any exchange), the terms and conditions of this Agreement, the Disclaimer and any additional
              terms and conditions presented in any part of the System and any other terms and conditions pertaining to the
              System and the provision of the Services from time to time.
            </p>
          </dd>
          <dt>
            3.4
          </dt>
          <dd>
            <p>
              In the event that any User ceases to be authorised by Client to access and use the System, Client will notify
              UBS without delay and UBS will, within a commercially reasonable time, disable the relevant username, password
              and digital certificate and so deny that User access to the System.
            </p>
          </dd>
          <dt>
            3.5
          </dt>
          <dd>
            <p>
              Client acknowledges that, subject to the confidentiality obligations contained in clause 8, UBS may collect and
              maintain personal data in relation to and from Users (for example their name, job title and contact details and
              information concerning their access to, and use of, the System and the Services) which may be transferred to any
              country in which UBS or any UBS Affiliate does business and processed in accordance with applicable data
              protection law by UBS, UBS Affiliates or a third party or parties acting on behalf of UBS or UBS Affiliates. The
              locations where such personal data are maintained may not afford the same level of protection to personal data
              that would apply in Client's specific jurisdiction. Client agrees to procure that each User has consented to
              such collection, transfer and processing of his/her data. It is Client's duty to ensure that each User notifies
              Client of any changes to his/her personal data and Client undertakes that Client will, where relevant, notify
              UBS of the same without delay.
            </p>
          </dd>
          <dt>
            3.6
          </dt>
          <dd>
            <p>
              Client acknowledges that, subject to the confidentiality obligations in clause 8, UBS may also collect and
              maintain general data regarding each User's individual, and Client's, access to and use of the System and the
              Services (including by means of &quot;cookies&quot; and similar devices) and Client consents and agrees to
              procure that its Users consent to the use of such devices. Such general data will be used for administering
              access controls, providing technical assistance through the help desk and maintaining a record of communications
              and transactions effected through the System. The data may also be used for monitoring usage and performance of
              the System and, in UBS's opinion, improving the System's usefulness to UBS's clients generally and to Client in
              particular. This may include the offering of additional systems and services to Client. Such general data may be
              transferred to any country in which UBS or UBS Affiliates do business and processed in accordance with
              applicable law by UBS, UBS Affiliates or a third party or parties acting on behalf of UBS or UBS Affiliates
              including outsourcing service providers anywhere in the world. The locations where such general data are
              maintained may not afford the same level of protection to general data that would apply in Client's specific
              jurisdiction.
            </p>
          </dd>
          <dt>
            3.7
          </dt>
          <dd>
            <p>
              Client agrees that, in certain situations determined by UBS, UBS may disclose general data regarding usage by
              Client of the System and the Services to third parties, provided that such third parties will have agreed with
              UBS to keep such data confidential. For example, in connection with the distribution and support of new issue
              securities, data regarding usage by Client of the System and the Services which are relevant to the new issue
              may be disclosed by UBS to the issuer of the relevant securities, provided that such issuer will have agreed
              with UBS to keep such data confidential.
            </p>
          </dd>
          <dt class="section">
            <strong>4.</strong>
          </dt>
          <dd>
            <p>
              <strong>Conditions of Access</strong>
            </p>
          </dd>
          <dt>
            4.1
          </dt>
          <dd>
            <p>
              With the exception of the digital certificates referred to in clause 3.2, Client is responsible for and must
              provide at its sole cost all software, telephony, Internet connectivity and other equipment necessary for Client
              to access and use the System and the Services and obtain any relevant licences and/or consents.
            </p>
          </dd>
          <dt>
            4.2
          </dt>
          <dd>
            <p>
              Client acknowledges that the System incorporates encryption technology. Client agrees to comply with all laws,
              rules and regulations relating to Client's use of such encryption technology, including but not limited to those
              of the US Department of State, Department of Commerce or other United States agency or authority, and those
              applicable in any jurisdiction in which Client does business, and not to export or re-export such technology in
              violation of any such laws, rules or regulations. UBS shall not be responsible for any breakdown of any
              technology used for encryption or electronic transmission of information.
            </p>
          </dd>
          <dt>
            4.3
          </dt>
          <dd>
            <p>
              Client agrees not to upload onto the System any software, file, information, data or other content: (a) which
              infringes any UBS or third party intellectual property rights; (b) which adversely affects the performance or
              availability of the System or other UBS resources or systems; (c) which contains any advertising, promotion or
              solicitation; (d) which is defamatory of any person; (e) which is offensive in any manner; (f) which materially
              misrepresents facts or which may be damaging or injurious to UBS, Client, Users, or any third party; (g) which
              would result in a breach of any obligation of confidentiality; or (h) in the case of personal data, without
              having obtained the informed consent of the person to whom such data relates. Client is responsible for checking
              the accuracy of any information Client uploads into the System. UBS shall have no liability to Client in respect
              of any information that is uploaded into the System by any other client of UBS.
            </p>
          </dd>
          <dt>
            4.4
          </dt>
          <dd>
            <p>
              The parties agree that regulations 9(1), 9(2) and 11(1) of the Electronic Commerce (EC Directive) Regulations
              2002 shall not apply to the System and the Service.
            </p>
          </dd>
          <dt>
            4.5
          </dt>
          <dd>
            <p>
              Client shall not (and shall procure that each of its Users shall not) use the System for any illegal or unlawful
              purpose, or access or attempt to access any part of the System access to which would be denied to Client and its
              Users by the System's normal operation.
            </p>
          </dd>
          <dt class="section">
            <strong>5.</strong>
          </dt>
          <dd>
            <p>
              <strong>Charges</strong>
            </p>
            <p>
              UBS reserves the right by notice to Client to charge a fee in respect of any or all of the System and/or the
              Services, provided that Client may at Client's option terminate Client's access to the System and/or Client's
              use of the relevant Services in accordance with clause 9.1.
            </p>
          </dd>
          <dt class="section">
            <strong>6.</strong>
          </dt>
          <dd>
            <p>
              <strong>Intellectual Property Rights</strong>
            </p>
            <p>
              UBS reserves the right by notice to Client to charge a fee in respect of any or all of the System and/or the
              Services, provided that Client may at Client's option terminate Client's access to the System and/or Client's
              use of the relevant Services in accordance with clause 9.1.
            </p>
          </dd>
          <dt>
            6.1
          </dt>
          <dd>
            <p>
              All title, ownership rights and intellectual property rights in or relating to the System and the Services, any
              information transmitted by, to or over the System and the Services and information regarding Client's use of the
              System and the Services shall remain in UBS or its licensors. Nothing on the System or the Services shall be
              construed as conferring on Client any licence, save as expressly set out herein, of any of UBS's or any third
              party's intellectual property rights, whether by estoppel, implication or otherwise.
            </p>
          </dd>
          <dt>
            6.2
          </dt>
          <dd>
            <p>
              Subject to clause 7.5, Client may use data derived from and relating to its use of the System and the Services
              in accordance with this Agreement for its normal business purposes (as determined by UBS from time to time in
              its sole discretion), provided that such use shall at all time comply with all applicable laws, rules and
              regulations.
            </p>
          </dd>
          <dt>
            6.3
          </dt>
          <dd>
            <p>
              Except as permitted in clause 6.2, Client shall not (and shall procure that each of its Users shall not)
              reproduce, distribute, transmit, publish or otherwise transfer, commercially exploit, reverse engineer or
              decompile (except to the extent expressly permitted by law) or make any derivative product from the System or
              the Services or any software, file, data, information, know-how, idea, communication or other content received
              or accessed through or in connection with the System or the Services.
            </p>
          </dd>
          <dt>
            6.4
          </dt>
          <dd>
            <p>
              The licence granted to Client under clause 1.2 may include the right for Client to use certain software,
              calculators, tools and/or other content which are proprietary to third party licensors of UBS, provided that in
              respect of such software, calculators, tools and/or content, Client may be required to enter into a licence
              agreement with such third party as a pre-condition to any such use (a &quot;
              <strong>Third Party Licence</strong>&quot;).
            </p>
          </dd>
          <dt>
            6.5
          </dt>
          <dd>
            <p>
              Client agrees to notify UBS forthwith on becoming aware of any claim by any third party that any element of the
              System or the Services infringes any intellectual property right of any third party.
            </p>
          </dd>
          <dt class="section">
            <strong>7.</strong>
          </dt>
          <dd>
            <p>
              <strong>Warranty and Liability</strong>
            </p>
          </dd>
          <dt>
            7.1
          </dt>
          <dd>
            <p>
              <strong>SUBJECT TO CLAUSE 7.2 BELOW, UBS WARRANTS THAT IT HAS THE RIGHT TO GRANT THE LICENCE AS SET OUT
                IN THIS AGREEMENT. SUBJECT ONLY TO THIS EXPRESS WARRANTY, THE SYSTEM AND THE SERVICES INCLUDING, WITHOUT
                LIMITATION, THEIR CONTENT, FEATURES AND ANY RELATED SERVICES, ARE PROVIDED TO CLIENT ON AN &quot;AS IS&quot;
                AND &quot;AS AVAILABLE&quot; BASIS AT CLIENT'S SOLE RISK AND WITHOUT REPRESENTATIONS OR WARRANTIES OF ANY
                KIND. UBS DOES NOT GUARANTEE THAT THE SYSTEM, THE SERVICES OR ANY PART OF THEM WILL BE AVAILABLE TO OR
                ACCESSIBLE BY CLIENT. ALL WARRANTIES, CONDITIONS OR TERMS (EXPRESS OR IMPLIED, STATUTORY OR OTHERWISE
                INCLUDING WITHOUT LIMITATION ANY WARRANTY, CONDITION OR TERM AS TO SATISFACTORY QUALITY, MERCHANTABILITY,
                FITNESS FOR A PARTICULAR PURPOSE AND ANY WARRANTIES OR COMMITMENTS THAT ACCESS OR USE WILL BE UNINTERRUPTED OR
                ERROR FREE), OTHER THAN THOSE EXPRESSLY SET OUT IN THIS AGREEMENT, ARE EXPRESSLY EXCLUDED TO THE FULLEST
                EXTENT PERMITTED BY LAW.</strong>
            </p>
          </dd>
          <dt>
            7.2
          </dt>
          <dd>
            <p>
              <strong>NOTWITHSTANDING ANY OTHER PROVISION OF THIS AGREEMENT, NOTHING IN THIS AGREEMENT SHALL EXCLUDE
                OR LIMIT ANY LIABILITY TO THE EXTENT SUCH LIABILITY CANNOT BE EXCLUDED OR LIMITED BY APPLICABLE LAW
                (INCLUDING, WITHOUT LIMITATION, DEATH OR PERSONAL INJURY RESULTING FROM UBS' NEGLIGENCE OR THE CONSEQUENCES OF
                FRAUD BY UBS). THIS DOES NOT IN ANY WAY CONFER GREATER RIGHTS THAN CLIENT WOULD OTHERWISE HAVE AT LAW.</strong>
            </p>
          </dd>
          <dt>
            7.3
          </dt>
          <dd>
            <p>
              <strong>SUBJECT ONLY TO CLAUSE 7.2 AND TO THE EXTENT PERMISSIBLE BY LAW, UBS WILL HAVE NO LIABILITY FOR
                ANY LOSS OR DAMAGE HOWEVER CAUSED ARISING UNDER OR IN CONNECTION WITH THIS AGREEMENT, INCLUDING, WITHOUT
                LIMITATION, CLIENT'S USE OF OR INABILITY TO ACCESS THE SYSTEM AND/OR THE SERVICES, ANY MARKET DATA OR OTHER
                PRODUCT OR SERVICE PROVIDED BY ANY THIRD PARTY AND ANY FAILURE BY UBS TO ACT ON ANY INFORMATION NOTIFIED TO IT
                IN ANY SYSTEM USER LIST, WHETHER IN CONTRACT, TORT (INCLUDING NEGLIGENCE) OR OTHERWISE, UNLESS CLIENT PAYS ANY
                FEES TO UBS FOR THE USE OF THE SYSTEM AND /OR THE SERVICES IN WHICH CASE UBS' LIABILITY FOR ANY LOSS OR DAMAGE
                HOWEVER CAUSED ARISING UNDER OR IN CONNECTION WITH THIS AGREEMENT SHALL BE LIMITED TO THE AMOUNT OF THE FEES
                RECEIVED BY UBS FROM CLIENT IN THE 6 MONTH PERIOD IMMEDIATELY PRECEDING THE DATE ON WHICH THE CAUSE OF ACTION
                GIVING RISE TO THE LOSS OR DAMAGE FIRST AROSE. CLIENT WILL NOT, UNDER ANY CIRCUMSTANCES, BRING ANY CLAIMS OF
                ANY NATURE (WHETHER IN TORT (INCLUDING NEGLIGENCE) OR CONTRACT OR OTHERWISE) AGAINST ANY OF UBS' DIRECTORS,
                OFFICERS, EMPLOYEES, CONTRACTORS OR AGENTS WHERE SUCH CLAIMS ARISE OUT OF OR IN RELATION TO THE SUBJECT MATTER
                OF THIS AGREEMENT.</strong>
            </p>
          </dd>
          <dt>
            7.4
          </dt>
          <dd>
            <p>
              UBS shall not be considered in breach of this Agreement in the event of any failure or delay for reasons not
              within UBS's reasonable control, including, without limitation, war, disaster, acts of nature, power failure,
              failure of communications services or networks, labour stoppage, sabotage, computer virus hacking, unrest or
              disputes, acts or omissions of Client or any third party including national and/or supranational government
              agencies or bodies and courts of law.
            </p>
            <p>
              UBS does not warrant or represent that any client information given to or accessed by you, whether through this
              website or otherwise, is accurate or current.
            </p>
            <p>
              UBS is not liable for any loss, damage or expense caused by:
            </p>
            <dl>
              <dt>
                (a)
              </dt>
              <dd>
                any unavailability of this website or the Materials;
              </dd>
              <dt>
                (b)
              </dt>
              <dd>
                the Clients general use of or reliance upon this website or the Materials; or
              </dd>
              <dt>
                (c)
              </dt>
              <dd>
                any inaccuracy of any client information.
              </dd>
            </dl>
            <p>
              The Client agrees to indemnify UBS for any damage, expense, loss or liability (however caused) incurred by UBS
              as a result of:
            </p>
            <dl>
              <dt>
                (a)
              </dt>
              <dd>
                any access or use (whether in compliance with this Agreement or not) of the System by the Client (which
                includes, for the avoidance of doubxxxt, the Client’s employees, officers and agents);
              </dd>
              <dt>
                (b)
              </dt>
              <dd>
                any access or use of the System by any other person whose access or use was a result of any act or omission by
                the Client; and
              </dd>
              <dt>
                (c)
              </dt>
              <dd>
                any use of any client information, whether obtained by the Client in compliance with this Agreement or not,
              </dd>
            </dl>
            <p>
              including but not limited to, losses relating to use or misuse of UBS’s intellectual property rights.
            </p>
            <p>
              For the avoidance of doubt, this clause continues to operate following any termination or purported termination
              of this Agreement.
            </p>
          </dd>
          <dt>
            7.5
          </dt>
          <dd>
            <p>
              UBS may at any time and without giving any notice suspend the provision of all or any part of the System and/the
              Services to Client in whole or in part with immediate effect in the event of any of the force majeure
              circumstances described above, planned or unplanned maintenance and upgrading of the System or related Systems,
              any breach of this Agreement by Client or its Users and/or action by Client or its Users which is prejudicial or
              potentially prejudicial to the System, UBS or other clients.
            </p>
          </dd>
          <dt>
            7.6
          </dt>
          <dd>
            <p>
              The System and the Services are provided to Client solely for Client's benefit and use in accordance with the
              terms of this Agreement. UBS accepts no liability or responsibility to any third party who gains access to the
              System or the Services as a result of any act or omission by Client or any Users or otherwise. Client agrees to
              indemnify UBS and the UBS Affiliates and its and their directors and employees on demand against any
              liabilities, losses, costs, claims, expenses (including legal fees) and damages in connection with any claims
              against UBS, UBS Affiliates and its and their directors and employees by any such third party, including but not
              limited to any claim by any third party which has access to data derived from the System and/or the Services
              pursuant to clause 6.2.
            </p>
          </dd>
          <dt>
            7.7
          </dt>
          <dd>
            <p>
              Client agrees to indemnify UBS and the UBS Affiliates and its and their officers and/or employees on demand
              against any liabilities, costs, claims, losses, expenses and damages (including, but not limited to, legal fees)
              arising out of or relating to any breach of this Agreement by Client or any User.
            </p>
          </dd>
          <dt class="section">
            <strong>8.</strong>
          </dt>
          <dd>
            <p>
              <strong>Confidentiality</strong>
            </p>
          </dd>
          <dt>
            8.1
          </dt>
          <dd>
            <p>
              In this Agreement:
            </p>
            <p>
              &quot;
              <strong>Confidential Information</strong>&quot; means any and all information disclosed in connection with the
              provision by UBS to Client and/or the use by Client of the System and the Services (whether before, on or after
              the date of acceptance by Client of this Agreement, whether verbally, in writing, electronically or by any other
              means, whether directly or indirectly and whether or not marked &quot;Confidential&quot;) by the Disclosing
              Party or any person on its behalf to the Receiving Party or otherwise obtained by the Receiving Party or any
              person on its behalf from the Disclosing Party. For the avoidance of doubt, UBS's Confidential Information
              includes, without limitation, all information relating to the System, the Services and the existence and terms
              of this Agreement;
            </p>
            <p>
              &quot;
              <strong>Disclosing Party</strong>&quot; means a party disclosing Confidential Information; and
            </p>
            <p>
              &quot;
              <strong>Receiving Party</strong>&quot; means a party receiving Confidential Information.
            </p>
          </dd>
          <dt>
            8.2
          </dt>
          <dd>
            <p>
              In consideration of the disclosure of the Confidential Information supplied to it by the other party, each party
              agrees that it shall keep the other party's Confidential Information confidential, not use such Confidential
              Information and not disclose such Confidential Information to another person (and use all reasonable efforts to
              prevent any such disclosure) except as permitted in clause 8.3.
            </p>
          </dd>
          <dt>
            8.3
          </dt>
          <dd>
            <p>
              Each party may disclose the Confidential Information of the other party:
            </p>
          </dd>
          <dt>
            8.3.1
          </dt>
          <dd>
            <p>
              to its affiliates and any of its and its affiliates' officers and employees, and, where Client is using the
              System and/or Services as agent in accordance with clause 13 below, to the customers on whose behalf it is
              authorised to use the System and/or Services (together, &quot;
              <strong>Recipients</strong>&quot;); provided that before disclosure of any Confidential Information to any
              Recipient, the Receiving Party shall ensure that the Recipient is made aware of and complies with the Receiving
              Party's obligations of confidentiality under this Agreement as if the
              <strong>Recipient</strong> was a party to this Agreement;
            </p>
          </dd>
          <dt>
            8.3.2
          </dt>
          <dd>
            <p>
              with the prior written consent of the other party; or
            </p>
          </dd>
          <dt>
            8.3.3
          </dt>
          <dd>
            <p>
              where disclosure is required by law, by a court of competent jurisdiction or by any regulatory body which
              regulates the conduct of the Receiving Party, provided that the Receiving Party shall give the Disclosing Party
              as much notice as is practicable of any such requirement and shall not disclose any more Confidential
              Information than is reasonably necessary in the circumstances.
            </p>
          </dd>
          <dt>
            8.4
          </dt>
          <dd>
            <p>
              UBS may disclose the Confidential Information of Client and its clients:
            </p>
          </dd>
          <dt>
            8.4.1
          </dt>
          <dd>
            <p>
              to third parties pursuant to clauses 3.5, 3.6 and 3.7; and/or
            </p>
          </dd>
          <dt>
            8.4.2
          </dt>
          <dd>
            <p>
              to any third party that provides hosting or other services to UBS in respect of the System and/or Services,
            </p>
            <p>
              provided that such third parties will have agreed with UBS to keep such information confidential.
            </p>
          </dd>
          <dt>
            8.5
          </dt>
          <dd>
            <p>
              This Agreement does not apply to Confidential Information which:
            </p>
          </dd>
          <dt>
            8.5.1
          </dt>
          <dd>
            <p>
              the Receiving Party can show is in the public domain and was publicly available prior to the Receiving Party's
              receipt thereof from the Disclosing Party, or has subsequently become publicly available other than by reason of
              any breach by the Receiving Party of this clause 8;
            </p>
          </dd>
          <dt>
            8.5.2
          </dt>
          <dd>
            <p>
              the Receiving Party can show was in its possession prior to disclosure by the Disclosing Party and which had not
              previously been obtained from the Disclosing Party or another person under an obligation of confidence to the
              Disclosing Party;
            </p>
          </dd>
          <dt>
            8.5.3
          </dt>
          <dd>
            <p>
              the Receiving Party obtains from a person other than the Disclosing Party, other than in breach by such person
              of any obligation of confidence to the Disclosing Party; or
            </p>
          </dd>
          <dt>
            8.5.4
          </dt>
          <dd>
            <p>
              the Receiving Party can show was independently developed by the Receiving Party without the benefit of any
              Confidential Information of the Disclosing Party.
            </p>
          </dd>
          <dt>
            8.6
          </dt>
          <dd>
            <p>
              Except as expressly set out in this Agreement, nothing contained in this Agreement shall be construed as
              granting any right or licence to either party's Confidential Information or to any invention or discovery
              derived from or improvement made to such Confidential Information, whether conceived or created prior to or
              after the date of acceptance of this Agreement.
            </p>
          </dd>
          <dt>
            8.7
          </dt>
          <dd>
            <p>
              Each party acknowledges that breach by it of this clause 8 may cause irreparable injury to other party, which
              injury will be inadequately compensated in damages. Accordingly each party is entitled to the remedies of
              injunction, specific performance and other equitable relief in respect of any actual breach or threatened breach
              of this clause 8, in addition to any other legal remedies which may be available.
            </p>
          </dd>
          <dt class="section">
            <strong>9.</strong>
          </dt>
          <dd>
            <p>
              <strong>Termination</strong>
            </p>
          </dd>
          <dt>
            9.1
          </dt>
          <dd>
            <p>
              Each of UBS and Client is entitled to terminate Client's access to and use of the System and/or any of the
              Services at any time and without cause by written notice to the other.
            </p>
          </dd>
          <dt>
            9.2
          </dt>
          <dd>
            <p>
              If Client's access to and use of the System and the Services is terminated by either party, UBS shall be
              entitled to disable Client's usernames, passwords and digital certificates and the licence granted under clause
              1.2 and the provision of the System and the Services shall terminate with immediate effect.
            </p>
          </dd>
          <dt>
            9.3
          </dt>
          <dd>
            <p>
              Clauses 3.5, 3.6, 3.7, 6, 7, 8, 10, 11, 12, 13 and 14 shall survive termination of Client's access to the System
              and the Services.
            </p>
          </dd>
          <dt class="section">
            <strong>10.</strong>
          </dt>
          <dd>
            <p>
              <strong>Entire Agreement</strong>
            </p>
          </dd>
          <dt>
            10.1
          </dt>
          <dd>
            <p>
              The entire agreement between Client and UBS with regard to Client's access to and use of the System and the
              Services is comprised of the following:
            </p>
          </dd>
          <dt>
            10.1.1
          </dt>
          <dd>
            <p>
              this Agreement, as amended by UBS from time to time;
            </p>
          </dd>
          <dt>
            10.1.2
          </dt>
          <dd>
            <p>
              the Disclaimer, as amended by UBS from time to time;
            </p>
          </dd>
          <dt>
            10.1.3
          </dt>
          <dd>
            <p>
              the System User List (if any);
            </p>
          </dd>
          <dt>
            10.1.4
          </dt>
          <dd>
            <p>
              any additional terms and conditions governing access to specific areas of the System and/or specific Services
              which UBS may post on any part of the System from time to time, as amended by UBS from time to time;
            </p>
          </dd>
          <dt>
            10.1.5
          </dt>
          <dd>
            <p>
              any Third Party Licences; and
            </p>
          </dd>
          <dt>
            10.1.6
          </dt>
          <dd>
            <p>
              any other agreement in writing duly authorised by and signed on behalf of UBS.
            </p>
          </dd>
          <dt>
            10.2
          </dt>
          <dd>
            <p>
              If there is any conflict between this Agreement and any other agreement of terms and conditions, this Agreement
              shall prevail.
            </p>
          </dd>
          <dt>
            10.3
          </dt>
          <dd>
            <p>
              This Agreement replaces any and all preceding versions of this Agreement, whether in electronic or tangible
              form, accepted and/or executed prior to the date of acceptance of this Agreement.
            </p>
          </dd>
          <dt class="section">
            <strong>11.</strong>
          </dt>
          <dd>
            <p>
              <strong>Notices</strong>
            </p>
          </dd>
          <dt>
            11.1
          </dt>
          <dd>
            <p>
              Any notice to be given by Client to UBS under or in connection with this Agreement shall be in writing and shall
              be sent to the following address or facsimile number:
            </p>
            <address>
              UBS
              <br />
              L16 Chifley Tower
              <br />
              2 Chifley Square
              <br />
              Sydney NSW 2000
              <br />
            </address>
            <p>
              Marked for the attention of &quot;Online Application Client Portal&quot; with a copy to the above address, Fax:
              +612 9324 2558, marked for the attention of &quot;General Counsel&quot;.
            </p>
          </dd>
          <dt>
            11.2
          </dt>
          <dd>
            <p>
              Any notice or communication given by UBS to Client under or in connection with this Agreement may be given
              through the System, by email to the email address of any Client User, or in writing to sent to the address or
              facsimile number of Client that UBS has in its records from time to time. Any such notice or communication shall
              be deemed to have been delivered and communicated to Client at such time as it is available for Client to view
              through the System.
            </p>
          </dd>
          <dt class="section">
            <strong>12.</strong>
          </dt>
          <dd>
            <p>
              <strong>Third Party Rights</strong>
            </p>
            <p>
              Each of the UBS Affiliates may enforce the Client's obligations under this Agreement, as if it was a party to
              this Agreement. Subject to the foregoing, a person who is not party to this Agreement has no rights to enforce
              any term of this Agreement. The parties may vary the terms of or rescind this Agreement in writing without the
              consent of any third party.
            </p>
          </dd>
          <dt class="section">
            <strong>13.</strong>
          </dt>
          <dd>
            <p>
              <strong>Agents</strong>
            </p>
            <p>
              If Client is using the Services and/or System as agent (for example, Client is acting as a financial advisor or
              broker) the following additional provisions apply:
            </p>
          </dd>
          <dt>
            13.1
          </dt>
          <dd>
            <p>
              Client is complying with all applicable laws, rules, regulations and investment guidelines; and
            </p>
          </dd>
          <dt>
            13.2
          </dt>
          <dd>
            <p>
              Client shall indemnify UBS and the UBS Affiliates from any and all losses, costs, claims, liabilities, damages
              and expenses which may arise from actual or alleged breach of any of the representations and warranties in this
              Agreement.
            </p>
          </dd>
          <dt class="section">
            <strong>14</strong>
          </dt>
          <dd>
            <p>
              <strong>Governing Law, Jurisdiction and Arbitration</strong>
            </p>
            <p>
              This Agreement shall be governed by and construed in accordance with the laws of New South Wales and in the
              event of a dispute arising out of or in connection with this Agreement, the courts of New South Wales shall have
              exclusive jurisdiction, provided that UBS may at its option:
            </p>
          </dd>
          <dt>
            14.1
          </dt>
          <dd>
            <p>
              where applicable Terms and Conditions provide for the governing law and jurisdiction of another country, select
              such governing law and jurisdiction.
            </p>
          </dd>
          <dt>
            14.2
          </dt>
          <dd>
            <p>
              UBS is entitled to exercise the option provided by Clauses 14.1 both in order to:
            </p>
          </dd>
          <dt>
            14.2.1
          </dt>
          <dd>
            <p>
              commence litigation or arbitration proceedings (as the case may be) against the Client as claimant; or
            </p>
          </dd>
          <dt>
            14.2.2
          </dt>
          <dd>
            <p>
              stay litigation proceedings already commenced by Client in the courts of New South Wales against UBS as
              defendant in respect of the same dispute.
            </p>
          </dd>
          <dt class="section">
            <strong>15</strong>
          </dt>
          <dd>
            <p>
              <strong>Privacy</strong>
            </p>
            <p>
              The parties agree to comply with their obligations pursuant to the Privacy Act 1988 and any applicable industry
              codes relating to the protection of personal information.
            </p>
          </dd>
        </dl>

        <form:form>
          <div class="form-group">
            <div class="form-row last-row">
              <spring:nestedPath path="advisor">
                <tag:formCheckbox name="I accept the above Terms of Use" path="acceptedtermsofuse" mand="true" />
              </spring:nestedPath>
            </div>
            <br class="clear"/>
          </div>
          
          <br class="clear"/>

          
          <p class="foot-note"><span style="color: red;">#</span> Denotes a Mandatory Field</p>
          
          <hr class="clear"/>
          
          <div class="button-row">
            <input name="return" type="submit" class="button" value="Accept" />

            <br class="clear"/>
          </div>
          
        </form:form>
      </div>
      
      <jsp:include flush="true" page="/WEB-INF/jsp/includes/footer.jsp"/>

    </div>
  </body>
</html>