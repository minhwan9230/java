package package1;

import java.util.Scanner;

public class MenuManager {
    private Scanner scan = new Scanner(System.in);

    public int initMenu() {
        System.out.println("원하는 작업을 선택해주세요.:");
        System.out.println("1. 로그인");
        System.out.println("2. 종료");
        return scan.nextInt(); 
    }

    public int addressMenu() {
        System.out.println("원하는 작업을 선택해주세요.:");
        System.out.println("1. 주소 검색");
        System.out.println("2. 전체 주소 검색");
        System.out.println("3. 정보 변경");
        System.out.println("4. 로그아웃");
        return scan.nextInt(); 
    }

    public int selectInitMenu() {
        return initMenu(); 
    }

    public int selectAddressMenu() {
        return addressMenu(); 
    }
}