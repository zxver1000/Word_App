import 'package:flutter/material.dart';
import 'package:word_test/word_screen/short_answer_quiz.dart';
import 'main_Screen.dart';
import 'package:word_test/Login_screen.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:word_test/Login_screen.dart';
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:native_flutter_proxy/custom_proxy.dart';
import 'package:native_flutter_proxy/custom_proxy_override.dart';
import 'package:native_flutter_proxy/native_proxy_reader.dart';
import 'package:http_proxy_override/http_proxy_override.dart';



class word{
  String name;
  String mean;
  word(this.name,this.mean);
}
class part_data{
  var try_count_ju=0;
  var pass_ju=0;
  var pass_mul=0;
  int pass=0;
  var try_count_mul=0;
  var trys=0;
  part_data(this.trys,this.pass);
}

class server extends ChangeNotifier{
  var http_server_name;

 void setserver(ss){
   http_server_name=ss;
   notifyListeners();
}
}

class word_data extends ChangeNotifier{
  List<List<word>>part_data=[];
   var hasdata=0;

  void add_partdata(List<word>data){

    part_data.add(data);
    hasdata=1;
    notifyListeners();
  }
}


class user_infodata extends ChangeNotifier{
  var id;
  var phone_number;
  var password;
  List<int>pass_num=[];
  List<List<part_data>>part_datas=[[],[],[],[],[],[],[],[],[],[],[]];

  void set_info(var id,var phone_number,var password,var part_data1,var pass_num){
    this.id=id;
    this.phone_number=phone_number;
    this.password=password;
    this.part_datas=part_data1;
   this.pass_num=pass_num;

    notifyListeners();
  }

  void pass_ju(var col,var row)
  {
    if(part_datas[col-1][row-1].pass_ju==0)
      {
        part_datas[col-1][row-1].pass_ju=1;
        if(part_datas[col-1][row-1].pass_mul==1)
        {
          part_datas[col-1][row-1].pass=1;
          pass_num[col-1]++;
        }

        notifyListeners();
      }


  }
  void pass_gack(var col,var row)
  {
    if(part_datas[col-1][row-1].pass_mul==0)
      {
        part_datas[col-1][row-1].pass_mul=1;
        if(part_datas[col-1][row-1].pass_ju==1)
        {
          part_datas[col-1][row-1].pass=1;
          pass_num[col-1]++;
        }

        notifyListeners();
      }

  }

void add_try_ju(var col,var row)
{
  part_datas[col-1][row-1].try_count_ju++;
  notifyListeners();

}
void add_try_gack(var col,var row)
{
  part_datas[col-1][row-1].try_count_mul++;
  notifyListeners();
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

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  HttpProxyOverride httpProxyOverride =
  await HttpProxyOverride.createHttpProxy();
  httpProxyOverride.port="3000";
  httpProxyOverride.host="192.168.0.5";
  HttpOverrides.global = httpProxyOverride;

  runApp(

      MultiProvider(providers: [
        ChangeNotifierProvider(create: (c)=>loginindex()),
        ChangeNotifierProvider(create: (c)=>server()),
        ChangeNotifierProvider(create: (c)=>user_infodata()),
        ChangeNotifierProvider(create: (c)=>word_data()),
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

 print(context.read<server>().http_server_name);
 print("kkk");



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

