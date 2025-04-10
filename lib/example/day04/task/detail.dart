import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Detail extends StatefulWidget {
  @override
  _DetailState createState() {
    return _DetailState();
  }
}

class _DetailState extends State<Detail> {
  Dio dio = Dio();
  Map<String, dynamic> task = {};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    int pid = ModalRoute.of(context)!.settings.arguments as int;
    taskFindById(pid);
  }

  void taskFindById(int pid) async {
    try {
      final response = await dio.get(
          "http://192.168.40.40:8080/day04/task/view?pid=$pid");
      final data = response.data;
      setState(() {
        task = data;
      });
    } catch (e) {
      print("상세 조회 중 오류 발생: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("상세 화면")),
      body: Center(
        child: task.isEmpty
            ? CircularProgressIndicator()
            : Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "재고명: ${task['pname']}",
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(height: 8),
              Text(
                "재고설명: ${task['pdescription']}",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 8),
              Text(
                "재고 수량: ${task['pquantity']}",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 8),
              Text(
                "등록일: ${task['createAt']}",
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 8),
              Text(
                "수정일: ${task['updateAt']}",
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
