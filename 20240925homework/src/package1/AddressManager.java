package package1;

import java.util.Scanner;

public class AddressManager {
	private MenuManager menuManager;
	private User[] users;
	private User currentUser;

	Scanner scan = new Scanner(System.in);

	public AddressManager() {
		this.menuManager = new MenuManager();
		this.users = new User[3];
		users[0] = new User("aaa", "aaa", "111", "010-1111-1111", "강남");
		users[1] = new User("bbb", "bbb", "222", "010-2222-2222", "잠실");
		users[2] = new User("ccc", "ccc", "333", "010-3333-3333", "미사");
	}

	public void run() {
		boolean break_flag = true;
		while (break_flag) {
			int i = menuManager.initMenu();
			switch (i) {
			case 1:
				if (loginProc()) {
					addressProc();
				}
				break;
			case 2:
				break_flag = false;
				System.out.println("종료되었습니다.");
				break;
			default:
				System.out.println("입력값이 잘못되었습니다.");
			}
		}
	}

	public boolean loginProc() {
		System.out.println("ID를 입력해주세요.");
		String id = scan.next();
		System.out.print("비밀번호를 입력해주세요.");
		String pw = scan.next();

		for (User user : users) {
			if (user.getId().equals(id) && user.getPw().equals(pw)) {
				currentUser = user;
				currentUser.setLogin(true);
				System.out.println("로그인 성공");
				return true;
			}
		}
		System.out.println("로그인 실패");
		return false;
	}

	public void addressProc() {
		boolean break_flag = true;
		while (break_flag) {
			int i = menuManager.selectAddressMenu();
			switch (i) {
			case 1:
				addressSearch();
				break;
			case 2:
				allAddressSearch();
				break;
			case 3:
				changeMyInfo();
				break;
			case 4:
				logout();
				break_flag = false;
				break;
			default:
				System.out.println("입력값이 잘못되었습니다.");
			}
		}
	}

	private void changeMyInfo() {
		System.out.print("변경할 번호: ");
		String newPhone = scan.next();
		System.out.print("변경할 주소: ");
		String newAddress = scan.next();
		currentUser.setPhone(newPhone);
		currentUser.setAddress(newAddress);
		System.out.println("정보가 변경되었습니다.");
	}

	public void addressSearch() {
		System.out.println("검색할 유저의 ID를 입력하세요 ");
		String searchName = scan.next();

		boolean break_flag = false;
		for (int i = 0; i < users.length; i++) {
			if (users[i] != null && users[i].getId().equals(searchName)) {
				System.out.println(searchName + "님의 주소: " + users[i].getAddress());
				System.out.println(searchName + "님의 전화번호: " + users[i].getPhone());
				break_flag = true;
				break;
			}
		}
		if (!break_flag) {
			System.out.println(searchName + "등록되지 않은 정보입니다.");
		}
	}

	public void allAddressSearch() {
		System.out.println("전체 사용자 주소");

		for (int i = 0; i < users.length; i++) {
			System.out.println(users[i].getName() + "님의 주소: " + users[0].getAddress());
			System.out.println(users[i].getName() + "님의 전화번호: " + users[0].getPhone());
		}
	}

	public void logout() {
		if (currentUser != null) {
			currentUser.setLogin(false);
			System.out.println("로그아웃되었습니다.");
			currentUser = null;
		}
	}

	public static void main(String[] args) {
		AddressManager manager = new AddressManager();
		manager.run();
	}
}