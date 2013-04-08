package com.ubs.opi.support;

import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;

import com.ubs.opi.domain.Advisor;
import com.ubs.opi.domain.Constants;
import com.ubs.opi.domain.Individual;

/**
 * 
 * @author edwarddc
 * 
 */
public class OpiMailManager implements MailManager {

   private static final Log LOG = LogFactory.getLog(OpiMailManager.class);

   private JavaMailSenderImpl mailSender;

   // JavaMailSenderImpl sender = new JavaMailSenderImpl();

   private SimpleMailMessage templateHFAMessage;

   public void resendUserNameandPassword(Individual individual) {
         
      StringBuffer buff = new StringBuffer();
      buff.append("<html>");
      buff.append("<head>");
      buff.append("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=ISO-8859-1\">");
      buff.append("</head>");
      buff.append("<body>");
      buff.append("Dear ");
      buff.append(individual.getFirstname() + " " + individual.getLastname());
      buff.append(",\n");
      buff.append("<br>");
      buff.append("<p>");

      buff.append("Your login details are as follows:");
      buff.append("</p>");
      buff.append("<p>");
      buff.append("<b>Access Code:</b> ");
      buff.append(individual.getUsers().getUsername());
      buff.append("<br>");
      buff.append("<b>Password:</b> ");
      buff.append(individual.getUsers().getPassword());
      buff.append("</p>");
      buff.append("<p>");
      buff.append("Please note that username and password are case sensitive.");
      buff.append("</p>");
      buff.append("<p>");
      buff.append("To access the Online Application Service please visit our website at: <a href='http://ibol06.ibb.ubs.com'>http://ibol06.ibb.ubs.com</a>.");
      buff.append("</p>");
      buff.append("<p>");
      buff.append("<font SIZE=\"2pt\">This message contains confidential information and is intended only for the individual named.  If you are not the named addressee you should not disseminate, distribute or copy this e-mail.  Please notify the sender immediately by e-mail if you have received this e-mail by mistake and delete this e-mail from your system.</font>");
      buff.append("</p>");
      buff.append("<p>");
      buff.append("<font SIZE=\"2pt\">E-mail transmission cannot be guaranteed to be secure or error-free as information could be intercepted, corrupted, lost, destroyed, arrive late or incomplete, or contain viruses.  The sender therefore does not accept liability for any errors or omissions in the contents of this message which arise as a result of e-mail transmission.  If verification is required please request a hard-copy version.  This message is provided for informational purposes and should not be construed as a solicitation or offer to buy or sell any securities or related financial instruments.</font>");
      buff.append("</p>");
      buff.append("</body>");
      buff.append("</html>");

      try {
         // of course you would use DI in any real-world cases
         //JavaMailSenderImpl sender = new JavaMailSenderImpl();
         //sender.setHost("smtp.gmail.com");

         MimeMessage message = mailSender.createMimeMessage();
         message.setContent(buff.toString(), "text/html");
         MimeMessageHelper helper = new MimeMessageHelper(message);
         helper.setTo(individual.getWorkemail()); // "paul@laserandcosmetic.com"
         InternetAddress from = new InternetAddress("hfa@ubs.com", "Online Application Service");
         helper.setFrom(from);
         helper.setSubject("Online Application Service Login Details");
         mailSender.send(message);
         LOG.info("email sent to : "+individual.getWorkemail());

      } catch (Exception ex) {
         LOG.error(ex.getMessage(), ex);
      }
   
   }
      
      /*
    * (non-Javadoc)
    * 
    * @see com.ubs.opi.service.MailManager#sendUserNameandPassword(com.ubs.opi.domain.Advisor)
    */
   public void sendUserNameandPassword(Advisor advisor) {

      StringBuffer buff = new StringBuffer();
      buff.append("<html>");
      buff.append("<head>");
      buff.append("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=ISO-8859-1\">");
      buff.append("</head>");
      buff.append("<body>");
      buff.append("Dear ");
      buff.append(advisor.getIndividual().getFirstname() + " " + advisor.getIndividual().getLastname());
      buff.append(",\n");
      buff.append("<br>");
      buff.append("<p>");
      if (advisor.getIsactivated().equals(Constants.FALSE)) 
      {
         buff.append("We have received a financial product application from a client who has listed you as financial adviser.  For your convenience we have provided you with a temporary access code and password that will give you access to our Online Application Tool.  This online tool is only available to advisers and will allow you to monitor progress of this application, payment status and enable you to complete further client applications online.");
         buff.append("<br><br>");
         buff.append("Benefits from creating and submitting applications online include:");
         buff.append("<ul>");
         buff.append("<li>Processing of the application commences immediately the application is submitted online.</li>");
         buff.append("<li>TheThe online tool makes it easier and faster to complete applications by only asking for information directly relevant to that type of application.</li>");
         buff.append("<li>ProducesProduces a checklist of items specific to the client and their application to ensure all relevant supporting documents are provided.</li>");
         buff.append("</ul>");
      }
      else
      {
         buff.append("Thank you for registering with the Online Application Service.  This online tool assists with the completion of financial product applications and will allow you to monitor their progress through to payment.  You will be able to reuse client details at the click of a button.  ");
      }
      buff.append("Your login details are as follows:");
      buff.append("</p>");
      buff.append("<p>");
      buff.append("<b>Access Code:</b> ");
      buff.append(advisor.getIndividual().getUsers().getUsername());
      buff.append("<br>");
      buff.append("<b>Password:</b> ");
      buff.append(advisor.getIndividual().getUsers().getPassword());
      buff.append("</p>");
      buff.append("<p>");
      buff.append("Please note that username and password are case sensitive.");
      buff.append("</p>");
      buff.append("<p>");
      buff.append("To access the Online Application Service please visit our website at: <a href='http://ibol06.ibb.ubs.com'>http://ibol06.ibb.ubs.com</a>.");
      buff.append("</p>");
      buff.append("<p>");
      buff.append("<font SIZE=\"2pt\">This message contains confidential information and is intended only for the individual named.  If you are not the named addressee you should not disseminate, distribute or copy this e-mail.  Please notify the sender immediately by e-mail if you have received this e-mail by mistake and delete this e-mail from your system.</font>");
      buff.append("</p>");
      buff.append("<p>");
      buff.append("<font SIZE=\"2pt\">E-mail transmission cannot be guaranteed to be secure or error-free as information could be intercepted, corrupted, lost, destroyed, arrive late or incomplete, or contain viruses.  The sender therefore does not accept liability for any errors or omissions in the contents of this message which arise as a result of e-mail transmission.  If verification is required please request a hard-copy version.  This message is provided for informational purposes and should not be construed as a solicitation or offer to buy or sell any securities or related financial instruments.</font>");
      buff.append("</p>");
      buff.append("</body>");
      buff.append("</html>");

      try {
         // of course you would use DI in any real-world cases
         // JavaMailSenderImpl sender = new JavaMailSenderImpl();
         // sender.setHost("smtp.gmail.com");

         MimeMessage message = mailSender.createMimeMessage();
         message.setContent(buff.toString(), "text/html");
         MimeMessageHelper helper = new MimeMessageHelper(message);
         helper.setTo(advisor.getIndividual().getWorkemail());
         InternetAddress from = new InternetAddress("hfa@ubs.com", "Online Application Service");
         helper.setFrom(from);
         helper.setSubject("Online Application Service Login Details");
         mailSender.send(message);

      } catch (Exception ex) {
         LOG.error(ex.getMessage(), ex);
      }
   }

   /**
    * 
    * @param mailSender
    */
   public void setMailSender(JavaMailSenderImpl mailSender) {
      this.mailSender = mailSender;
   }

   /**
    * 
    * @param templateMessage
    */
   public void setTemplateHFAMessage(SimpleMailMessage templateHFAMessage) {
      this.templateHFAMessage = templateHFAMessage;
   }

}
