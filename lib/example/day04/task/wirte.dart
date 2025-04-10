import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Write extends StatefulWidget {
  @override
  _WriteState createState() {
    return _WriteState();
  }
}

class _WriteState extends State<Write> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  Dio dio = Dio();

  void taskSave() async {
    try {
      int quantity = int.tryParse(quantityController.text) ?? 0;

      final sendData = {
        "pname": titleController.text,
        "pdescription": contentController.text,
        "pquantity": quantity,
      };

      final response = await dio.post(
        'http://192.168.40.40:8080/day04/task',
        data: sendData,
      );
      final data = response.data;
      if( data != null ){
        Navigator.pushNamed(context, "/" );
      }
    }catch(e){ print(e); }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("등록 화면"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text("등록 해보세요."), // 텍스트 위젯
              SizedBox(height: 30),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: "재고 이름",
                ),
              ),
              SizedBox(height: 30),
              TextField(
                controller: contentController,
                decoration: InputDecoration(
                  labelText: "재고 설명",
                ),
                maxLines: 3, // 기본 줄수 제한 수
              ),
              SizedBox(height: 30),
              TextField(
                controller: quantityController,
                keyboardType: TextInputType.number, // 숫자 입력 전용
                decoration: InputDecoration(
                  labelText: '재고 수량',
                ),
              ),
              SizedBox(height: 30),
              OutlinedButton(
                onPressed: taskSave,
                child: Text("등록하기"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
