use madangdb;

-- ①가격이 20,000원 미만인 도서를 검색
select * from book where price < 20000;
-- ②가격이 10,000원 이상 20,000 이하인 도서를 검색
select * from book where price between 10000 and 20000;
-- ③출판사가 ‘굿스포츠’ 혹은 ‘대한미디어’인 도서를 검색
select * from book where publisher in('굿스포츠','대한미디어');
-- ④출판사가 ‘굿스포츠’ 혹은 ‘대한미디어’가 아닌 도서를 검색
select * from book where publisher not in('굿스포츠','대한미디어');
-- ⑤‘축구의 역사’를 출간한 출판사를 검색
select * from book where bookname='축구의 역사';
-- ⑥도서이름에 ‘축구’가 포함된 출판사를 검색
select * from book where bookname like '%축구%';
-- ⑦도서이름이 여섯글자인 도서를 검색
select * from book where bookname like '______' ;
-- ⑧도서이름의 왼쪽 두 번째 위치에 ‘구’라는 문자열을 갖는 도서를 검색
select * from book where bookname like '_구%';
-- ⑨축구에 관한 도서 중 가격이 20,000원 이상인 도서를 검색
select * from book where bookname like '%축구%' and price >=20000;
-- ⑩야구에 관한 책을 모두 구입하려면 필요한 금액을 계산
select sum(price) from book where bookname like '%야구%';
-- ⑪도서를 가격순으로 검색하고, 가격이 같으면 이름순으로 검색
select * from book order by price,bookname;
-- ⑫도서를 가격의 내림차순으로 검색하고 만약 가격이 같다면 출판사의 오름차순으로 검색
select * from book order by price desc, publisher;
-- ⑬
-- ⑭ 고객이 주문한 도서의 총 판매액 조회
select sum(saleprice) from orders;
-- select custid, sum(saleprice) from orders group by custid;
-- ⑮ 2번 김연아 고객이 주문한 도서의 총 판매액 조회
select custid, sum(saleprice) from orders where custid='2';
select sum(saleprice) from orders where custid='2';
-- 16) 고객이 주문한 도서의 총 판매액, 평균값, 최저가, 최고가 조회
select sum(saleprice),avg(saleprice),min(saleprice),max(saleprice)
from orders;
-- 17) 마당서점의 도서 판매 건수 조회
select count(*) as '판매건수' from orders;
-- 18) 고객별로 주문한 도서의 총 수량과 총 판매액 조회
select custid, sum(saleprice),count(*) as '구매건수' from orders group by custid;
-- 19) 가격이 8,000원 이상인 도서를 구매한 고객에 대하여 고객별 주문 도서의 총 수량을 구하시오. 단, 두 권 이상 구매한 고객만 조회
select custid, count(*) as '구매권수' from orders where saleprice >=8000 group by custid
having 구매권수>=2;