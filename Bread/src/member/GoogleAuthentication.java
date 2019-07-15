package member;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class GoogleAuthentication extends Authenticator {
	PasswordAuthentication passAuth = new PasswordAuthentication("rootLake12", "Lakeroot12");

	public PasswordAuthentication getPasswordAuthentication() {
		return this.passAuth;
	}
}