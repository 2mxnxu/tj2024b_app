import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ProductList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ProductListState();
  }
}

class _ProductListState extends State<ProductList> {
  // 1.
  int cno = 0;
  int page = 1;
  List<dynamic> productList = []; // 자바서버로 부터 조회 한 제품(DTO) 목록 상태변수
  final dio = Dio(); // 자바서버와 통신 객체
  String baseUrl = "http://localhost:8080";
  // * 현재 스크롤의 상태(위치/크기 등)를 감지하는 컨트롤러
  // * 무한스크롤(스크롤이 거의 바닥에 위치 했을 때 새로운 자료 요청 해서 추가)
  // .position : 현재 스크롤의 위치 반환, .position.pixels : 위치를 픽셀로 반환
  final ScrollController scrollController = ScrollController();

  // 2. 현재 위젯 생명주기 : 위젯이 처음으로 열렸을 때 1번 실행
  @override // (1)자바서버에게 자료 요청 (2) 스크롤의 리스너(이벤트) 추가
  void initState() {
    onProductAll(page);
    scrollController.addListener(onScroll); // .addListener : 스크롤의 이벤트(함수) 리스너 추가
  }
  
  // 3. 자바서버에게 자료 요청 메소드
  void onProductAll(int currentPage) async{
    try{
      final response = await dio.get("$baseUrl/product/all?page=${currentPage}"); // 현재페이지(page) 매개변수로 보낸다
      setState(() {
        page = currentPage; // 증가된 현재페이지를 상태변수에 반영
        productList = response.data; // 서버로 부터 받은 자료를 상태변수에 반영한다.
        print(productList);
      });
    }catch(e) {
      print(e);
    }
  }
  // 4. 스코롤의 리스너(이벤트) 추가 메소드
  void onScroll(){
    // - 만약에 현재 스크롤의 위치가 거의 끝에 도달 했을때 
    if(scrollController.position.pixels >= scrollController.position.maxScrollExtent -150){
      onProductAll(page+1); // 스크롤이 거의 바닥에 도달했을 때 page를 1증가하여 다음 페이지 자료 요청한다.
    }
  }
  
  @override
  Widget build(BuildContext context) {
    // 만약에 제품목록이 비어 있으면
    if(productList.isEmpty) {
     return Center(child: Text("조회된 제품이 없습니다."),) ;
    }
    return ListView.builder(
        itemCount: productList.length,
        itemBuilder: (context, index){
          // (1) 각 index번째 제품 꺼내기
          final product = productList[index];
          // (2) 이미지 리스트 추출
          final List<dynamic> images = product['images'];
          // (3) 만약에 이미지가 존재하면 대표이미지(1개) 추출 없으면 기본이미지를 추출
          String imageUrl;
          if(images.isEmpty) { // 리스트(이미지들)가 비어있으면 기본 이미지
            imageUrl = "$baseUrl/upload/default.jpg";
          }else{ // 비어있지 않으면 첫번째 이미지만 추출
            imageUrl = "$baseUrl/upload/${images[0]}";
          }
          return InkWell(
            onTap: () => {}, // 만약에 하위 위젯을 클릭했을때 이벤트 발생
            child: Card(
              margin: EdgeInsets.all(15),
              child: Row( // 가로배치
                children: [ // 가로 배치할 위젯들
                  Image.network(imageUrl), // 웹 이미지 출력
                  SizedBox(width: 20,), // 여백
                  Expanded(child: Column(
                    children: [
                      Text(product['pname']),
                      Text(product['pprice']),
                      Text(product['cname']),
                      Text(product['pview']),
                    ],
                  )), // Card의 남은 부분
                ],
              ),
            ),
          );
        },
    );
  }
}