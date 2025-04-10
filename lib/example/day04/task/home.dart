import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  Dio dio = Dio();
  List<dynamic> tasklist = [];

  // 데이터 전체 조회
  void taskFindAll() async {
    try {
      final response = await dio.get("http://192.168.40.40:8080/day04/task");
      final data = response.data;

      if (data is List) {
        setState(() {
          tasklist = data;
        });
        print("Fetched data: $tasklist");
      } else {
        print("서버에서 받은 데이터가 List 형식이 아닙니다: $data");
      }
    } catch (e) {
      print("에러 발생: $e");
    }
  }

  // 데이터 삭제
  void taskDelete(int pid) async {
    try {
      final response = await dio.delete(
        'http://192.168.40.40:8080/day04/task?pid=$pid',
      );
      final data = response.data;
      if (data == true) {
        taskFindAll();  // 삭제 후 데이터 갱신
      }
    } catch (e) {
      print("삭제 중 오류 발생: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    taskFindAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("메인페이지")),
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () => {Navigator.pushNamed(context, "/write")},
              child: Text("재고 추가"),
            ),
            SizedBox(height: 30),

            Expanded(
              child: tasklist.isEmpty
                  ? Center(child: Text("데이터가 없습니다."))
                  : ListView(
                children: tasklist.map((task) {
                  return Card(
                    child: ListTile(
                      title: Text(task['pname']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("번호 : ${task['pid']}"),
                          Text("재고이름 : ${task['pname']}"),
                          Text("재고설명 : ${task['pdescription']}"),
                          Text("재고수량 : ${task['pquantity']}"),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // 수정 버튼
                          IconButton(
                            onPressed: () => {
                              Navigator.pushNamed(
                                context,
                                "/update",
                                arguments: task['pid'],
                              )
                            },
                            icon: Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () => {
                              Navigator.pushNamed(
                                context,
                                "/detail",
                                arguments: task['pid'],
                              )
                            },
                            icon: Icon(Icons.info),
                          ),
                          IconButton(
                            onPressed: () => {taskDelete(task['pid'])},
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
