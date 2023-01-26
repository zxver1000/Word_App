import 'package:flutter/material.dart';
import 'package:word_test/main.dart';
import 'constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import './SinupScreen/SignupScreen.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'dart:core';
import 'package:http/http.dart' as http;
class user_info{
  var try_count;
  var pass;


  user_info(this.try_count,this.pass);


}

class Login_Screen extends StatefulWidget {
  const Login_Screen({Key? key}) : super(key: key);

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {

  bool isSignupScreen = false;
  final _formKey = GlobalKey<FormState>();
  String userName = '';
  String userEmail = '';
  String userPassword = '';
  bool showSpinner = false;


  Future<int> http_get(var condition,var conditon_val,var password) async{

    var urll = "http://";
    var https = context
        .read<server>()
        .http_server_name;
    https+=condition+"/"+conditon_val;
    urll += https;
    Uri uri = Uri.parse(urll);

    Map<String, String> headers = {
      'Content-Type': 'application/json'
    };
    var id_check = await http.get(
        uri, headers: headers);
    if (id_check.statusCode == 200) {
      //이럼있는거 아이디가있음 Aert 메세지

     var data = utf8.decode(id_check.bodyBytes);
     var k = json.decode(data);
     //print(k);

     if(k['data'][0]['password']==password)
       {

         //데이터 넣기!!
         var id=k['data'][0]['NAME'];
         var pass=k['data'][0]['pasword'];
         var phone_num=k['data'][0]['phone_number'];
        List<int>pass_n=[];
         List<List<part_data>>l1=[[],[],[],[],[],[],[],[],[],[],[]];
         var idx=0;
         for(var n1 in k['data'][0]['part1'])
           {
             l1[0].add(part_data(n1['try_count'], n1['pass']));
             idx+=int.parse(n1['pass'].toString());
           }
         pass_n.add(idx);
         idx=0;
         for(var n1 in k['data'][0]['part2'])
         {
           l1[1].add(part_data(n1['try_count'], n1['pass']));
           idx+=int.parse(n1['pass'].toString());
         }
         pass_n.add(idx);
         idx=0;
         for(var n1 in k['data'][0]['part3'])
         {
           l1[2].add(part_data(n1['try_count'], n1['pass']));
           idx+=int.parse(n1['pass'].toString());
         }
         pass_n.add(idx);
         idx=0;
         for(var n1 in k['data'][0]['part4'])
         {
           l1[3].add(part_data(n1['try_count'], n1['pass']));
           idx+=int.parse(n1['pass'].toString());
         }
         pass_n.add(idx);
         idx=0;
         for(var n1 in k['data'][0]['part5'])
         {
           l1[4].add(part_data(n1['try_count'], n1['pass']));
           idx+=int.parse(n1['pass'].toString());
         }
         pass_n.add(idx);
         idx=0;
         for(var n1 in k['data'][0]['part6'])
         {
           l1[5].add(part_data(n1['try_count'], n1['pass']));
           idx+=int.parse(n1['pass'].toString());
         }
         pass_n.add(idx);
         idx=0;
         for(var n1 in k['data'][0]['part7'])
         {
           l1[6].add(part_data(n1['try_count'], n1['pass']));
           idx+=int.parse(n1['pass'].toString());
         }
         pass_n.add(idx);
         idx=0;
         for(var n1 in k['data'][0]['part8'])
         {
           l1[7].add(part_data(n1['try_count'], n1['pass']));
           idx+=int.parse(n1['pass'].toString());
         }
         pass_n.add(idx);
         idx=0;
         for(var n1 in k['data'][0]['part9'])
         {
           l1[8].add(part_data(n1['try_count'], n1['pass']));
           idx+=int.parse(n1['pass'].toString());
         }
         pass_n.add(idx);
         idx=0;
         for(var n1 in k['data'][0]['part10'])
         {
           l1[9].add(part_data(n1['try_count'], n1['pass']));
           idx+=int.parse(n1['pass'].toString());
         }
         pass_n.add(idx);
         idx=0;

      context.read<user_infodata>().set_info(id, phone_num, pass, l1,pass_n);

         print(context.read<user_infodata>().pass_num);
         context.read<loginindex>().login();
               return 1;
       }
     else{
       showdialog("Error ID or password do not match");
     }


    }
    else{
      showdialog("Error ID or password do not match");
    }
    return -1;
  }
  void _tryValidation(){
    final isValid = _formKey.currentState!.validate();
    if(isValid){
      _formKey.currentState!.save();
    }
  }

  void showdialog(text){
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0))
        ,
        title: Text("Alert"),
        content: SizedBox(
          height: 50,
          child:Column(
            children: [
              Text(text)
            ],
          ) ,
        ),

        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text("OK"))
        ],
      );
    });


  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   set_ser();

  }

  void set_ser()async{
    String json=await rootBundle.loadString('assets/server.json');

    final jsonResponse = jsonDecode(json);

    context.read<server>().setserver(jsonResponse['server']);
    print("로그인");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.yellow[100],
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            //배경
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Container(
                height: 300,
                child: Container(
                  padding: EdgeInsets.only(top:90, left: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FaIcon(FontAwesomeIcons.journalWhills,
                        color: Colors.brown,size: 80,),
                        RichText(
                          text: TextSpan(
                              text: 'English Notebook',
                              style: TextStyle(
                                  letterSpacing: 1.0,
                                  fontSize: 25,
                                  color: Colors.black,
                                fontWeight: FontWeight.bold
                              ),
                              children: [
                                TextSpan(
                                  text: !isSignupScreen ? '!!' : '!!',
                                  style: TextStyle(
                                    letterSpacing: 1.0,
                                    fontSize: 25,
                                    color: Colors.black,
                                  ),
                                )
                              ]
                          ),
                        ),
                      ]

                  ),
                ),
              ),
            ),
            //텍스트 폼 필트
            AnimatedPositioned(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeIn,
              top: 225,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeIn,
                padding: EdgeInsets.all(20.0),
                height: isSignupScreen ? 280.0 : 260.0,
                width: MediaQuery.of(context).size.width-40,
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 15,
                          spreadRadius: 5
                      )
                    ]
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: [
                      Text(context.read<server>().http_server_name.toString()),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                isSignupScreen = false;
                              });
                            },
                            child: Column(
                              children: [
                                Text(
                                  'LOGIN',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: !isSignupScreen ? activecolor : skyblue
                                  ),
                                ),
                                if(!isSignupScreen)
                                  Container(
                                    height: 2,
                                    width: 55,
                                    color: Color.fromARGB(255, 41, 74, 42),
                                  )
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                isSignupScreen = true;
                              });
                            },
                            child: Column(
                              children: [
                                Text(
                                  'Manager',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: isSignupScreen ? activecolor : skyblue
                                  ),
                                ),
                                if(isSignupScreen)
                                  Container(
                                    margin: EdgeInsets.only(top: 3),
                                    height: 2,
                                    width: 55,
                                    color: Color.fromARGB(255, 41, 74, 42),
                                  )
                              ],
                            ),
                          )
                        ],
                      ),
                      if(isSignupScreen)
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  key: ValueKey(1),
                                  validator: (value){
                                    if(value!.isEmpty || value.length < 4){
                                      return 'Please enter at least 4 characters';
                                    }
                                    return null;
                                  },
                                  onSaved: (value){
                                    userName = value!;
                                  },
                                  onChanged: (value){
                                    userName = value;
                                  },
                                  decoration: const InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.account_circle,
                                        color: iconColor,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: skyblue),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(35.0),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: skyblue),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(35.0),
                                        ),
                                      ),
                                      hintText: 'User name',
                                      hintStyle: TextStyle(
                                          fontSize: 14,
                                          color: skyblue
                                      ),
                                      contentPadding: EdgeInsets.all(10)
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.emailAddress,

                                  key: ValueKey(2),
                                  validator: (value){
                                    if(value!.isEmpty || !value.contains('@')){
                                      return 'Please enter a valid email address';
                                    }
                                    return null;
                                  },
                                  onSaved: (value){
                                    userEmail = value!;
                                  },
                                  onChanged: (value){
                                    userEmail = value;
                                  },
                                  decoration: const InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.email,
                                        color: iconColor,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: skyblue),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(35.0),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: skyblue),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(35.0),
                                        ),
                                      ),
                                      hintText: 'Email',
                                      hintStyle: TextStyle(
                                          fontSize: 14,
                                          color: skyblue
                                      ),
                                      contentPadding: EdgeInsets.all(10)
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                TextFormField(
                                  obscureText: true,
                                  key: ValueKey(3),
                                  validator: (value){
                                    if(value!.isEmpty || value.length < 5){
                                      return 'Please enter at least 6 characters';
                                    }
                                    return null;
                                  },
                                  onSaved: (value){
                                    userPassword = value!;
                                  },
                                  onChanged: (value){
                                    userPassword = value;
                                  },
                                  decoration: const InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.password,
                                        color: iconColor,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: skyblue),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(35.0),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: skyblue),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(35.0),
                                        ),
                                      ),
                                      hintText: 'Password',
                                      hintStyle: TextStyle(
                                          fontSize: 14,
                                          color: skyblue
                                      ),
                                      contentPadding: EdgeInsets.all(10)
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      if(!isSignupScreen)
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  key: ValueKey(4),
                                  validator: (value){
                                    if(value!.isEmpty || !value.contains('@')){
                                      return 'Please enter a valid email address';
                                    }
                                    return null;
                                  },
                                  onSaved: (value){
                                    userEmail = value!;
                                  },
                                  onChanged: (value){
                                    userEmail = value;
                                  },
                                  decoration: const InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.supervised_user_circle_sharp,
                                        color: iconColor,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: skyblue),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(35.0),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: skyblue),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(35.0),
                                        ),
                                      ),
                                      hintText: 'Email',
                                      hintStyle: TextStyle(
                                          fontSize: 14,
                                          color: skyblue
                                      ),
                                      contentPadding: EdgeInsets.all(10)
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                TextFormField(
                                  obscureText: true,
                                  key: ValueKey(5),
                                  validator: (value){
                                    if(value!.isEmpty || value.length < 6){
                                      return 'Password must be at least 7 characters long';
                                    }
                                    return null;
                                  },
                                  onSaved: (value){
                                    userPassword = value!;
                                  },
                                  onChanged: (value){
                                    userPassword = value;
                                  },
                                  decoration: const InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.password,
                                        color: iconColor,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: skyblue),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(35.0),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: skyblue),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(35.0),
                                        ),
                                      ),
                                      hintText: 'Password',
                                      hintStyle: TextStyle(
                                          fontSize: 14,
                                          color: skyblue
                                      ),
                                      contentPadding: EdgeInsets.all(10)
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(top:8)),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children:<Widget>[
                                    Text("Don't have an account? "),

                                    TextButton(onPressed: (){

                                      Navigator.push(context,
                                          MaterialPageRoute(
                                              builder: (context)=>
                                                  SignupScreen()));
                                    }, child: Text(
                                        "Signup",
                                        style:TextStyle(color: Colors.blueAccent,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15)
                                    )),

                                  ],
                                ),





                              ],
                            ),

                          ),
                        )
                    ],
                  ),
                ),
              ),
            ),
            //전송버튼
            AnimatedPositioned(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeIn,
              top: isSignupScreen ? 450 : 435,
              right: 0,
              left: 0,
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(15),
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50)
                  ),
                  child: GestureDetector(
                    onTap: () async {
                      if (isSignupScreen) {
                        _tryValidation();
                      }
                      if (!isSignupScreen) {
                        _tryValidation();
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.amberAccent ,Colors.white70],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight
                        ),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: Offset(0,1)
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: Icon(Icons.arrow_forward),
                        color: Colors.white,
                        onPressed: ()async{
                          print(userEmail.toString());
                          print(userPassword.toString());

                      var idx=http_get("NAME",userEmail,userPassword);


                        },
                      ),

                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }
}
