package org.opi.support;

import java.util.ArrayList;
import java.util.List;

import org.opi.domain.Users;


public class SimpleAuthenticationManager implements AuthenticationManager {

	/*
	 * (non-Javadoc)
	 * 
	 * @see org.opi.support.AuthenticationManager#generatePwd(int)
	 */
	public String generatePwd(int pwd_lgth) {
		char[] pw = new char[pwd_lgth];
		int c = 'A';
		int r1 = 0;
		for (int i = 0; i < pwd_lgth; i++) {
			r1 = (int) (Math.random() * 3);
			switch (r1) {
			case 0:
				c = '0' + (int) (Math.random() * 10);
				break;
			case 1:
				c = 'a' + (int) (Math.random() * 26);
				break;
			case 2:
				c = 'A' + (int) (Math.random() * 26);
				break;
			}
			pw[i] = (char) c;
		}
		return new String(pw);
	}

	/*
	 * upto 10 char uname. 
	 * 
	 * @see org.opi.support.AuthenticationManager#generateUserName(java.util.Set)
	 */
	public String generateUserName(String f_name, String l_name, List<Users> c_users) {

		l_name = (l_name.length()>5)?l_name.substring(0,5):l_name;
		f_name = (f_name.length()>3)?f_name.substring(0, 3):f_name;;
		
		String u_name = l_name;
		String a_name = l_name + f_name;

		boolean isUnique = true;
		int idx = 0;
		int max_idx = f_name.length() - 1;
		int counter = 0;

		do {
			// keep adding lastname letters
			if (idx <= max_idx) {
				u_name = l_name + f_name.substring(0, ++idx);
			} else {
				// add numbers upto 99
				if (counter > 99)
					break;
				u_name = a_name + ++counter;
			}
			for (Users users : c_users) {
				isUnique = true;
				String e_name = users.getUsername();
				if (u_name.equalsIgnoreCase(e_name)) {
					// Match
					isUnique = false;
					break;
				}
			}
		} while (!isUnique);
		return u_name;
	}

	public static void main(String[] args) {
		//
		ArrayList<Users> users = new ArrayList<Users>();
		
		Users user1 = new Users();
		user1.setUsername("lik");
		users.add(user1);
		
		Users user2 = new Users();
		user2.setUsername("liki");
		users.add(user2);
		
		Users user3 = new Users();
		user3.setUsername("likim");
		users.add(user3);
		
		Users user4 = new Users();
		user4.setUsername("likim1");
		users.add(user4);
		
		Users user5 = new Users();
		user5.setUsername("likim2");
		users.add(user5);
		
		Users user6 = new Users();
		user6.setUsername("ArmstD");
		users.add(user6);
		
		Users user7 = new Users();
		user7.setUsername("ArmstDa");
		users.add(user7);
		
		Users user8 = new Users();
		user8.setUsername("ArmstDav");
		users.add(user8);
		

		SimpleAuthenticationManager mgr = new SimpleAuthenticationManager();
		System.out.println(mgr.generateUserName("David", "Armstrong", users));

	}

}
