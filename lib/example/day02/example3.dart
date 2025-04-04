int add(int a1, int b1) {
  return a1 + b1;
}

void main(){
  int num = 31;
  if(num % 2 == 1) {
    print("홀수!");
  }else{
    print("짝수!");
  }

  String light = "red";
  if(light == "green") {
    print("초록불!");
  } else if (light == "yellow") {
    print("노란불!");
  } else if(light == "red") {
    print("빨간불!");
  } else (print("잘못된 신호입니다."));

  String light1 = "purple";
  if(light1 == "green") {
    print("초록불!");
  }else if(light1 == "yellow") {
    print("노란불!");
  }else if(light1 == "red") {
    print("빨간불!");
  }

  for(int i=0; i<100; i++) {
    print(i+1);
  }
  
  List<String> subjects = ["자료구조", "이산수학", "알고리즘", "플러터"];
  for(String subject in subjects) {
    print(subject);
  }
  
  int a = 0;
  while(a<100) {
    print(a+1);
    a = a+1;
  }
  // int b = 0;
  // while(true) {
  //   print(b+1);
  //   b = b+1;
  // }

  int c = 0;
  while(true) {
    print(c+1);
    c = c+1;
    if(c == 100) {
      break;
    }
  }

  for(int d = 0; d<100; d++){
    if(d%2==0) {
      continue;
    }
    print(d+1);
  }

  int number = add(1,2);
  print(number);

  int number1 = add(1, 2);
  print(number1);
  switch(number){
    case 1:
      print('one');
  }

  const a2 = 'a';
  const b2 = 'b';
  const obj = [a2, b2];
  switch(obj){
    case[a2, b2]:
      print('$a2, $b2');
  }
  const obj1 = 1;
  const first = 1;
  const last = 10;
  switch(obj1){
    case 1:
      print('one');
    case >= first && <= last:
      print('in range');
    case(var a, var b):
      print('a = $a2 , b = $b2');

    default:
  }
}









