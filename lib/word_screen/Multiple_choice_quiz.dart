import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:word_test/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


import 'package:flutter_tts/flutter_tts.dart';

class multi_quiz extends StatefulWidget {
  const multi_quiz({Key? key}) : super(key: key);

  @override
  State<multi_quiz> createState() => _multi_quizState();
}

class _multi_quizState extends State<multi_quiz> {
  var cur_idx=0;
  var choice=0;
  final FlutterTts tts = FlutterTts();

  @override
  void dispose() {
    // TODO: implement dispose
    tts.stop();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(iconTheme: IconThemeData(
        color: Colors.black,//색변경
      ),backgroundColor: Colors.yellow[100],title: Text("Multiple Choice Quiz"
        ,style: TextStyle(color: Colors.black),
      ),





      ),
      body: Column(

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(padding: EdgeInsets.only(top: 20)
                ,child:Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius:4.5,
                          blurRadius: 2

                      )]
                  ),
                  width: 300,
                  height: 155,
                  child:
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [

                              Container(
                                width: 300,
                                height: 30,
                                color: Colors.blue[100],
                                child:
                                    Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(5),
                                          child:  Text("Number 1",style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black54

                                          ),)
                                          ,
                                        )
                                        ,
                                        Padding(padding: EdgeInsets.only(left: 190),child: Text("1/10"),)
                                      ],
                                    )



                                ),

                            ],
                          ),
                          Padding(padding: EdgeInsets.only(top: 30),child:
                            Text("Ansible",style: TextStyle(
                              fontSize: 30
                            ),),),
                          Padding(padding: EdgeInsets.only(top: 12),child:
                          TextButton(
                            onPressed: (){
                              tts.speak("ansible");

                            },
                            child:   FaIcon(FontAwesomeIcons.volumeUp,color: Colors.blue,)
                            ,
                          )
                        ,)


                        ],
                      )
                     ,

                ) ,)
            ],
          ),

          Padding(padding: EdgeInsets.only(top: 50)),

Padding(padding: EdgeInsets.only(left:30),

child: Row(
  children: [
    Container( decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius:4.5,
            blurRadius: 2

        )]
    ),
        width: 350,
        child: RadioListTile(
            title: Text("1. 안녕하세요"),value : 1, groupValue: choice, onChanged: (val){

          setState(() {
            choice=1;
          });
        })



    )
  ],
),
  
  
  ),
        Padding(padding: EdgeInsets.only(top:30)),
          Padding(padding: EdgeInsets.only(left:30),

            child: Row(
              children: [
                Container( decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius:4.5,
                        blurRadius: 2

                    )]
                ),
                    width: 350,
                    child: RadioListTile(
                        title: Text("2. 합치다"),value : 2, groupValue: choice, onChanged: (val){

                      setState(() {
                        choice=2;
                      });
                    })



                )
              ],
            ),
          ),




          Padding(padding: EdgeInsets.only(top:30)),
          Padding(padding: EdgeInsets.only(left:30),

            child: Row(
              children: [
                Container( decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius:4.5,
                        blurRadius: 2

                    )]
                ),
                    width: 350,
                    child: RadioListTile(
                        title: Text("3. 안녕하세요"),value : 3, groupValue: choice, onChanged: (val){

                      setState(() {
                        choice=3;
                      });
                    })



                )
              ],
            ),
          ),
          Padding(padding: EdgeInsets.only(top:30)),
          Padding(padding: EdgeInsets.only(left:30),

            child: Row(
              children: [
                Container( decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius:4.5,
                        blurRadius: 2

                    )]
                ),
                    width: 350,
                    child: RadioListTile(
                        title: Text("4. 반갑습니당"),value : 4, groupValue: choice, onChanged: (val){

                      setState(() {
                        choice=4;
                      });
                    })



                )
              ],
            ),
          ),




        ],
      ),
      bottomNavigationBar: BottomNavigationBar(

        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        backgroundColor: Colors.white70,

        onTap: (i){

          if(i==0)
            {
            print("1");
            }
          else{
            print("2");
          }

        },
        items: [
          BottomNavigationBarItem(
            label : 'Prev',
            icon: FaIcon(FontAwesomeIcons.backward),



          )

          ,
          BottomNavigationBarItem(
            label: "Next",
            icon: FaIcon(FontAwesomeIcons.play,color: Colors.black,),

          )
        ],
      ),
    );
  }
}
