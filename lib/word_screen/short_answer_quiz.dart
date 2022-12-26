import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:word_test/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bubble/bubble.dart';
import '../main.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:math';

class answer_quiz extends StatefulWidget {
  const answer_quiz({Key? key,this.col,this.row}) : super(key: key);

  final col;
  final row;
  @override
  State<answer_quiz> createState() => _answer_quizState();
}

class _answer_quizState extends State<answer_quiz> {
  final FlutterTts tts = FlutterTts();
  final TextEditingController _textController = new TextEditingController();
  StreamController<chatmessage> mesage=StreamController<chatmessage>();
  List<chatmessage> _messages =[];
   List<word>test_Data=[];
   List<int>array_int=[-1,-1,-1,-1,-1,-1,-1,-1,-1,-1];
   List<int>error_array=[];
   var cur_index=1;
  //문제만들기
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    set_test_data(widget.row,widget.col);
  }
  void set_test_data(row,col){

    for(var i=0;i<10;i++)
      {
      var k=Random().nextInt(20);
      array_int[i]=k;
       for(var j=0;j<i;j++)
         {
           if(array_int[j]==array_int[i])
             {
               i--;
               break;
             }


         }

      }

    int row_=row-1;

    for(var i=0;i<10;i++)
      {
        //print(array_int[i]);
        test_Data.add(context.read<word_data>().part_data[col-1][array_int[i]+(row_*20)]);
       // print(test_Data[i].name);
      }

  }

  void showdialog(correct,wrong,score,pass){
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0))
        ,
        title: Column(
          children: [
            Text("Result"),
            Divider(color: Colors.black87,)
          ],
        ),
        content: SizedBox(
          height: 180,
          child:Column(
            children: [
             Padding(padding: EdgeInsets.all(5),

             child: Row(
               children: [
                 Text("Correct Answer : "+correct.toString())
               ],
             )
               ,)
              ,
              Padding(padding: EdgeInsets.all(5),

                child: Row(
                  children: [
                    Text("Wrong Answer : "+wrong.toString())
                  ],
                )
                ,),

              Divider(color: Colors.black87,),

              Padding(padding: EdgeInsets.all(5),

                child: Row(
                  children: [
                    Text("Total Score : "+(correct*10).toString())
                  ],
                )
                ,),
              Padding(padding: EdgeInsets.all(5),

                child: Row(
                  children: [
                    Text("Pass or not : "),
                    Text(pass,style: TextStyle(color: Colors.red),)
                  ],
                )
                ,),

            ],
          ) ,
        ),

        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
            Navigator.pop(context);
          }, child: Text("OK"))
        ],
      );
    });


  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tts.stop();
  }
  void _handleSubmitted(String text,idx,correct_answer,error_array,row,col) {
    _textController.clear();

    var message = chatmessage(
        text: text,
        id:"1"
    );

    const String _name = "zur ";

    setState(() {
      _messages.insert(0, message);
    });


    mesage.add(message);
    var pandn_message;
    print(correct_answer[idx-1].name);
    if(correct_answer[idx-1].name==text)
    {
      error_array.add(1);
      pandn_message = chatmessage(
          text: "Correct Answer",
          id:"3"
      );
    }
    else
      {
        error_array.add(0);
        pandn_message = chatmessage(
            text: "Wrong Answer",
            id:"2"
        );
      }


    if(cur_index<10) {
      setState(() {
        _messages.insert(0, pandn_message);

        cur_index++;
      });
    }
    else {

      if (cur_index == 10) {
        context.read<user_infodata>().add_try_ju(col, row);
        //다끝남 결과 페이지보여주기
        var correct_cnt = 0;
        var error_cnt = 0;
        var pass = "No";
        for (var i = 0; i < 10; i++) {
          if (error_array[i] == 0) {
            error_cnt++;
          }
          else {
            correct_cnt++;
          }
        }

        if (correct_cnt > 8) {
          pass = "Pass";
          //패스면 변경->

          context.read<user_infodata>().pass_ju(col, row);
        }



        showdialog(correct_cnt, error_cnt, correct_cnt * 10, pass);
      }



      mesage.add(message);
    }

  //  showdialog("hihi");
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: <Widget>[
              Flexible(
                child: TextField(
                  controller: _textController,
                  onSubmitted: (_)=>_handleSubmitted,
                  decoration: new InputDecoration.collapsed(
                      hintText: "Send Correct Answer"),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                child: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () => _handleSubmitted(_textController.text,cur_index,test_Data,error_array,widget.row,widget.col)),
              ),
            ],
          )
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(iconTheme: IconThemeData(
        color: Colors.black,//색변경
      ),backgroundColor: Colors.yellow[100],title: Text("Short Answer Quiz"
        ,style: TextStyle(color: Colors.black),
      ),


      ),
body:  SingleChildScrollView(
  child: Column(
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
                          color: Colors.orange[100],
                          child:
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(5),
                                child:  Text("Number "+cur_index.toString(),style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black54

                                ),)
                                ,
                              )
                              ,
                              Padding(padding: EdgeInsets.only(left: 170),child: Text(cur_index.toString()+"/10"),)
                            ],
                          )



                      ),

                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: 30),child:
                  Text(test_Data[cur_index-1].name,style: TextStyle(
                      fontSize: 24
                  ),),),




                ],
              )
              ,

            ) ,),


        ],
      ),
      Padding(padding: EdgeInsets.only(top: 70)),
      Container(
        height: 355,
        width: 430,
        child:  Column(
          children: <Widget>[
            Flexible(
              child:
              StreamBuilder(
                stream: mesage.stream,
                builder: (BuildContext context,snapshot){
                  return ListView.builder(
                    padding: EdgeInsets.all(8.0),
                    reverse: true,
                    itemBuilder: (_, int index) {
                      return _messages[index];},
                    itemCount: _messages.length,
                  );
                },

              )
              ,
            ),
            Divider(height: 1.0),
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor
              ),
              child: _buildTextComposer(),
            )
          ],
        )
        ,
      )
    ],
  )
  ,
)
,

    );
  }
}


class chatmessage extends StatefulWidget {
  const chatmessage({Key? key,this.text,this.id,this.type}) : super(key: key);
  final text;
  final id;
  final type;
  @override
  State<chatmessage> createState() => _chatmessageState();
}

class _chatmessageState extends State<chatmessage> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return
    Row(
      mainAxisAlignment: widget.id=="1"?MainAxisAlignment.start:MainAxisAlignment.end,
      children: [
        Padding(padding: EdgeInsets.all(10),
          child: Bubble(
            child:Text(widget.text),
            color:   widget.id=="1"?Color.fromRGBO(225, 255, 199, 1.0):
            Colors.blue[100],
          )
          ,)

      ],
    );


  }
}

