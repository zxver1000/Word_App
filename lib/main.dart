import 'package:flutter/material.dart';
import 'main_Screen.dart';
import 'package:word_test/Login_screen.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:word_test/Login_screen.dart';
import 'dart:convert';
import 'dart:core';
import 'package:flutter/services.dart';
class server extends ChangeNotifier{
  var http_server_name;

 void setserver(ss){
   http_server_name=ss;
}
}



class loginindex extends ChangeNotifier{
  StreamController<String> streamController = StreamController<String>();
  void logout(){
    streamController.add("로그아웃");
    notifyListeners();
  }
  void login(){
    streamController.add("로그인");
    notifyListeners();
  }


  void init(){
    streamController.add("init");
    notifyListeners();
  }

}

void main() {
  runApp(
      MultiProvider(providers: [
        ChangeNotifierProvider(create: (c)=>loginindex()),
        ChangeNotifierProvider(create: (c)=>server()),
      ],
        child: MyApp(),)
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    setserver();

  }
  void setserver() async{
    String json=await rootBundle.loadString('assets/server.json');

    final jsonResponse = jsonDecode(json);

    context.read<server>().setserver(jsonResponse['server']);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

        home:StreamBuilder(
          stream: context.watch<loginindex>().streamController.stream,
          builder: (BuildContext context,snapshot){
            if(snapshot.data.toString()=="로그인") {
              return mainScreen();
            } else{
              return Login_Screen();
            }

          },
        )

    );
  }
}

