import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:word_test/constants.dart';
import 'package:word_test/main.dart';
import 'short_answer_quiz.dart';
import 'Multiple_choice_quiz.dart';
import 'WordScreen.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:http/http.dart' as http;
class PartWord extends StatefulWidget {
  const PartWord({Key? key,this.title_name,this.index,this.index2}) : super(key: key);

  final title_name;
  final index;
  final index2;
  @override
  State<PartWord> createState() => _PartWordState();
}
enum TtsState { playing, stopped, paused, continued }
class _PartWordState extends State<PartWord> with SingleTickerProviderStateMixin {
  final FlutterTts tts = FlutterTts();
  var ju_try=0;
  var gack_try=0;
  double size=175;
  var index=1;
  var k="";
  var star_index=0;
  late TabController? tab;
  var idx=0;
  @override
  void initState() {
    // TODO: implement initState

    tts.setLanguage('en');
    tts.setSpeechRate(0.4);

    tab=TabController(
      length: 2,
      vsync: this,
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(iconTheme: IconThemeData(
          color: Colors.black,//색변경
        ),backgroundColor: Colors.yellow[100],title: Text(widget.title_name
          ,style: TextStyle(color: Colors.black),
        ),


        )
,
      body:
          Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              title: TabBar(
                indicatorColor: purple,
                unselectedLabelColor: Colors.black,
                labelColor: Colors.black,
                controller: tab,onTap:(i){
                idx=i;
              },
                tabs: [Tab(text:"Daily Word",),Tab(text:"Daily Test",)],),
            ),
            body:   TabBarView(
                controller: tab,
                children: [
                  ListView.builder(itemBuilder: (BuildContext context,int index)
                {
                return word_item(item_num:index+1,title_num:widget.title_name,index: widget.index,col: widget.index,row: widget.index2);
                }
                  ,itemCount:20,

                  )


                  ,
                  ListView.builder(itemBuilder: (BuildContext context,int index)
                  {
                    if(index==0)
                      {
                        return test_ui(title_name:"Multiple Choice Quiz",index:index,col: widget.index,row: widget.index2,);
                      }
                    else
                      {
                        return test_ui(title_name:"Short Answer Quiz",index:index,col:widget.index,row: widget.index2,);
                      }

                  }
                    ,itemCount: 2,

                  )
                ],
          )


      )


    );
  }
}

class word_item extends StatefulWidget {
  const word_item({Key? key,this.item_num,this.title_num,this.index,this.col,this.row}) : super(key: key);
 final item_num;
 final index;
 final title_num;
 final col;
 final row;
  @override
  State<word_item> createState() => _word_itemState();
}

class _word_itemState extends State<word_item> {




  final FlutterTts tts = FlutterTts();
  double size=175;
  var index=1;
  var k="";
  var star_index=0;
  @override
  void initState() {
  // TODO: implement initState

  //tts.setLanguage('en');
  //tts.setSpeechRate(0.4);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    tts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(30),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius:1.5,
                blurRadius: 2

            )]
        ),
        width:355,
        height: size,
        child:Column(
          children: [
            Row(children: [
              Padding(padding: EdgeInsets.all(7),
                child: Text("Word "+widget.item_num.toString(),style: TextStyle(
                    color: Colors.blue
                ),) ,

              ),Padding(padding: EdgeInsets.only(left:220),child:
              TextButton(onPressed: (){

                if(star_index==1)
                {
                  setState(() {
                    star_index=0;
                  });
                }else{
                  setState(() {
                    star_index=1;
                  });
                }

              },
                child: star_index==0?FaIcon(FontAwesomeIcons.star,size: 18,color: Colors.yellow,):FaIcon(FontAwesomeIcons.solidStar,size: 18,color: Colors.yellow,),),)

            ],),
            Text(context.read<word_data>().part_data[widget.col-1][widget.item_num-1+(widget.row-1)*20].name,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 30),),

            Row(
              children: [
                Padding(padding: EdgeInsets.all(10),
                    child: TextButton(
                        onPressed: (){
                          tts.speak(context.read<word_data>().part_data[widget.col-1][widget.item_num-1+(widget.row-1)*20].name);
                        },child: FaIcon(FontAwesomeIcons.volumeUp,color: Colors.black54,)
                    )),
                Padding(padding: EdgeInsets.only(left: 200),
                  child: TextButton(
                    onPressed: (){ setState(() {
                      if(index==1)
                      {
                        size=180;
                        index=0;
                      }
                      else
                      {
                        size=175;
                        index=1;
                      }
                    });},
                    child: FaIcon(FontAwesomeIcons.arrowDown,color: Colors.black87,),
                  ),)
              ],
            ),





            index==0? Text(context.read<word_data>().part_data[widget.col-1][widget.item_num-1+(widget.row-1)*20].mean,
              style: TextStyle(fontSize: 16),):Text("")
          ],
        )
        ,
      ),
    );
  }
}

class test_ui extends StatefulWidget {
  const test_ui({Key? key,this.title_name,this.index,this.col,this.row}) : super(key: key);
final title_name;
final index;
final col;
final row;
  @override
  State<test_ui> createState() => _test_uiState();
}

class _test_uiState extends State<test_ui> {

  String set_numexam(index,row,col)
  {
    var s;
  if(index==0)
      {


      context.read<user_infodata>().add_try_gack(widget.col, widget.row);
      s=context.read<user_infodata>().part_datas[widget.col-1][widget.row-1].try_count_mul.toString();
      }
    else
      {

        context.read<user_infodata>().add_try_ju(widget.col, widget.row);
        s=context.read<user_infodata>().part_datas[widget.col-1][widget.row-1].try_count_ju.toString();
      }


    return s;
  }
String set_passexam(index,row,col)
{
  var s;
  if(index==0)
  {
    s=context.watch<user_infodata>().part_datas[widget.col-1][widget.row-1].pass_mul;
   if(s==0)
     {
       return "NO";
     }
   else
     {
       return "Yes";
     }

  }
  else
  {
    s=context.watch<user_infodata>().part_datas[widget.col-1][widget.row-1].pass_ju;
    if(s==0)
    {
      return "NO";
    }
    else
    {
      return "Yes";
    }
  }


  return "";
}

  final signUpButton = Material(
    elevation: 5,
    borderRadius: BorderRadius.circular(30),
    color:Colors.yellow[100],
    child: MaterialButton(
      padding: EdgeInsets.fromLTRB(20,15,20,15),
      minWidth: 150,
      onPressed: () async{

      },
      child: Text(
        "Start",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 20,color:Colors.black87,fontWeight: FontWeight.bold),
      ),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(30),
    child:  Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius:1.5,
              blurRadius: 2

          )]

      ),
      width: 350,
      height: 300,
      child: Column(
        children: [
          Container(
            width: 350,
            height: 40,
            color: Colors.yellow[100],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.title_name,style: TextStyle(
                  fontSize: 20,color:widget.title_name=="Short Answer Quiz"?Colors.grey:Colors.orange,fontWeight: FontWeight.w900
                ),)
              ],
            ),
          ),

          Row(
            children: [
              Padding(padding: EdgeInsets.all(18),child:
                Text("Number of exams :  ",style: TextStyle(
                  fontWeight:FontWeight.w400,
                  fontSize: 18
                ),),),
              Text(widget.index==0?context.watch<user_infodata>().part_datas[widget.col-1][widget.row-1].try_count_mul.toString():context.watch<user_infodata>().part_datas[widget.col-1][widget.row-1].try_count_ju.toString(),style: TextStyle(
                  fontWeight:FontWeight.w400,
                  fontSize: 18
              ))
            ],
          ),

          Row(
            children: [
              Padding(padding: EdgeInsets.all(18),child:
              Text("Number of questions : ",style: TextStyle(
                  fontWeight:FontWeight.w400,
                  fontSize: 18
              )),),Text("10",style: TextStyle(
                  fontWeight:FontWeight.w400,
                  fontSize: 18
              ))
            ],
          ),
          Row(
            children: [
              Padding(padding: EdgeInsets.all(18),child:
              Text("Pass exam : ",style: TextStyle(
                  fontWeight:FontWeight.w400,
                  fontSize: 18
              )),),Text(set_passexam(widget.index,widget.row-1,widget.col-1),style: TextStyle(
                  fontWeight:FontWeight.w400,
                  fontSize: 18
              ))
            ],
          ),

          Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(30),
            color:Colors.yellow[100],
            child: MaterialButton(
              padding: EdgeInsets.fromLTRB(20,15,20,15),
              minWidth: 150,
              onPressed: () async{
               if(widget.title_name=="Multiple Choice Quiz")
                 {
                   Navigator.push(context,
                       MaterialPageRoute(
                           builder: (context)=>
                               multi_quiz(row: widget.row,col: widget.col,)));
                 }
               else
                 {
                   Navigator.push(context,
                       MaterialPageRoute(
                           builder: (context)=>
                               answer_quiz(row: widget.row,col: widget.col)));
                 }

              },
              child: Text(
                "Start",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,color:Colors.black87,fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    )
      ,)
     ;
  }
}

