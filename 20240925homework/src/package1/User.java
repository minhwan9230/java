package package1;

public class User {
	private String name;
	private String id;
	private String pw;
	private String phone;
	private String address;
	private boolean login_state;

	public User(String name, String id, String pw, String phone, String address) {
		this.name = name;
		this.id = id;
		this.pw = pw;
		this.phone = phone;
		this.address = address;
		this.login_state = false;
	}

	public String getName() {
		return name;
	}

	public String getId() {
		return id;
	}

	public String getPw() {
		return pw;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public boolean isLogin() {
		return login_state;
	}

	public void setLogin(boolean state) {
		this.login_state = state;
	}

	public void logout() {
		this.login_state = false;
	}

}