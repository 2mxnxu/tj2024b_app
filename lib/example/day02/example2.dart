import 'package:dio/dio.dart';
final dio =  Dio();

void main(){
  print('dart start');
  getHttp();
  postHttp();


}
void getHttp() async{
  final response = await dio.get("http://localhost:8080/day03/task/course");
  print(response.data);

}

void postHttp() async{
  final sendData = {"cname":"수학"};
  final response = await dio.post("http://localhost:8080/day03/task/course",data: sendData);
  print(response.data);
}