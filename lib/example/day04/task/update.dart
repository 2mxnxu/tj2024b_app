import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Update extends StatefulWidget {
  @override
  _UpdateState createState() {
    return _UpdateState();
  }
}

class _UpdateState extends State<Update> {
  Dio dio = Dio();
  Map<String, dynamic> task = {};
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    int pid = ModalRoute.of(context)!.settings.arguments as int;
    print(pid);
    taskFindById(pid);
  }

  void taskFindById(int pid) async {
    try {
      final response = await dio.get(
          "http://192.168.40.40:8080/day04/task/view?pid=$pid");
      final data = response.data;
      setState(() {
        task = data;
        titleController.text = data['pname'];
        contentController.text = data['pdescription'];
        quantityController.text = data['pquantity'].toString(); // 수량 업데이트
      });
      print(task);
    } catch (e) {
      print(e);
    }
  }
  void taskUpdate(  ) async{
    try{
      final sendData = {
        "pid" : task['pid'],
        "pname" : titleController.text,
        "pdescription" : contentController.text,
        "pquantity" : quantityController.text ,
      };// 수정에 필요한 데이터
      final response =  await dio.put("http://192.168.40.40:8080/day04/task" , data : sendData );
      final data = response.data;
      if( data != null ){
        Navigator.pushNamed(context, "/" );
      }
    }catch(e){ print(e); }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("수정 화면")),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // padding 추가
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // 정렬을 왼쪽으로 변경
          children: [
            SizedBox(height: 20),
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: "재고명"),
              maxLength: 30,
            ),
            SizedBox(height: 20),
            TextField(
              controller: contentController,
              decoration: InputDecoration(labelText: "내용"),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            TextField(
              controller: quantityController, // 수량을 위한 필드 수정
              decoration: InputDecoration(labelText: "수량"),
              keyboardType: TextInputType.number, // 숫자 입력 타입으로 변경
            ),
            SizedBox(height: 20),

            OutlinedButton( onPressed: taskUpdate, child: Text("수정하기") ),
          ],
        ),
      ),
    );
  }
}
