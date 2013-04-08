package com.ubs.opi.support;

import com.ubs.opi.domain.Advisor;
import com.ubs.opi.domain.Individual;

public interface MailManager {

   void sendUserNameandPassword(Advisor advisor);

   void resendUserNameandPassword(Individual individual);
}
