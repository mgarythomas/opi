package com.ubs.opi.support;

import java.util.List;

import com.ubs.opi.domain.Users;

public interface AuthenticationManager {
	
	String generateUserName(String f_name, String l_name, List<Users> c_users);
	
	String generatePwd(int pwd_lgth);
}
