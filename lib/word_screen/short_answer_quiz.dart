import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:word_test/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bubble/bubble.dart';

import 'package:flutter_tts/flutter_tts.dart';


class answer_quiz extends StatefulWidget {
  const answer_quiz({Key? key}) : super(key: key);

  @override
  State<answer_quiz> createState() => _answer_quizState();
}

class _answer_quizState extends State<answer_quiz> {
  final FlutterTts tts = FlutterTts();
  final TextEditingController _textController = new TextEditingController();
  StreamController<chatmessage> mesage=StreamController<chatmessage>();
  List<chatmessage> _messages =[];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tts.stop();
  }
  void _handleSubmitted(String text) {
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

    var pandn_message = chatmessage(
        text: "Wrong Answer",
        id:"2"
    );
    setState(() {
      _messages.insert(0, pandn_message);
    });

    mesage.add(message);

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
                  onSubmitted: _handleSubmitted,
                  decoration: new InputDecoration.collapsed(
                      hintText: "Send Correct Answer"),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                child: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () => _handleSubmitted(_textController.text)),
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

                  ,

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

