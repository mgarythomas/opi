package org.opi.support;

import org.opi.domain.Advisor;
import org.opi.domain.Individual;

public interface MailManager {

   void sendUserNameandPassword(Advisor advisor);

   void resendUserNameandPassword(Individual individual);
}
