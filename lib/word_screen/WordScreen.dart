import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:word_test/constants.dart';
import 'DailyWord.dart';
import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
import '../main.dart';


class WordScreen extends StatefulWidget {
  const WordScreen({Key? key}) : super(key: key);

  @override
  State<WordScreen> createState() => _WordScreenState();
}

class _WordScreenState extends State<WordScreen> {
  double prog_val=20;


  Future<int> dataset() async{
    //word 데이터넣기!!

    if(context.read<word_data>().hasdata==1)
      {
        return 1;
      }
    var urll = "http://";
    var https = context
        .read<server>()
        .http_server_name;
    https+="NAME/word";
    urll += https;
    Uri uri = Uri.parse(urll);

    Map<String, String> headers = {
      'Content-Type': 'application/json'
    };
    var id_check = await http.get(
        uri, headers: headers);
    if (id_check.statusCode == 200) {

      var data = utf8.decode(id_check.bodyBytes);
      Map<dynamic,dynamic> k = json.decode(id_check.body);



      Map<dynamic,dynamic>part1=k['data'][0]['part1'];
      List<word>word1=[];
      List<word>kkk=[];
      for(dynamic words in part1.keys.toList())
      {

         final new1=word(words.toString(),part1[words].toString());

          word1.add(new1);

      }

      Map<dynamic,dynamic>part2=k['data'][0]['part2'];
      List<word>word2=[];
      for(var words in part2.keys.toList())
      {
        word2.add(word(words,part2[words]));
      }

      Map<dynamic,dynamic>part3=k['data'][0]['part3'];
      List<word>word3=[];
      for(var words in part3.keys.toList())
      {
        word3.add(word(words,part3[words]));
      }
      Map<dynamic,dynamic>part4=k['data'][0]['part4'];
      List<word>word4=[];
      for(var words in part4.keys.toList())
      {
        word4.add(word(words,part4[words]));
      }
      Map<dynamic,dynamic>part5=k['data'][0]['part5'];
      List<word>word5=[];
      for(var words in part5.keys.toList())
      {
        word5.add(word(words,part5[words]));
      }
      Map<dynamic,dynamic>part6=k['data'][0]['part6'];
      List<word>word6=[];
      for(var words in part6.keys.toList())
      {
        word6.add(word(words,part6[words]));
      }
      Map<dynamic,dynamic>part7=k['data'][0]['part7'];
      List<word>word7=[];
      for(var words in part7.keys.toList())
      {
        word7.add(word(words,part7[words]));
      }

      Map<dynamic,dynamic>part8=k['data'][0]['part8'];
      List<word>word8=[];
      for(var words in part8.keys.toList())
      {
        word8.add(word(words,part8[words]));
      }

      Map<dynamic,dynamic>part9=k['data'][0]['part9'];
      List<word>word9=[];
      for(var words in part9.keys.toList())
      {
        word9.add(word(words,part9[words]));
      }

      Map<dynamic,dynamic>part10=k['data'][0]['part10'];
      List<word>word10=[];
      for(var words in part10.keys.toList())
      {
        word10.add(word(words,part10[words]));
      }

      context.read<word_data>().add_partdata(word1);
      context.read<word_data>().add_partdata(word2);
      context.read<word_data>().add_partdata(word3);
      context.read<word_data>().add_partdata(word4);
      context.read<word_data>().add_partdata(word5);
      context.read<word_data>().add_partdata(word6);
      context.read<word_data>().add_partdata(word7);
      context.read<word_data>().add_partdata(word8);
      context.read<word_data>().add_partdata(word9);
      context.read<word_data>().add_partdata(word10);



     //print(ss[2]);





      return 1;
    }
    else
      {
        return -1;
      }




  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: FutureBuilder(
          future: dataset(),
          builder: (BuildContext context,AsyncSnapshot snapshot) {
            if (snapshot.hasData == false || snapshot.data == -1) {
              return Padding(padding: EdgeInsets.all(20),
                  child: CircularProgressIndicator());
            }
            else if (snapshot.hasError) {
              return Text("서버와 연결되어있지않습니다");
            } else {
              return Padding(
                padding: EdgeInsets.all(10),
                child: ListView.builder(itemBuilder: (BuildContext context,int index)
                {
                  return Column(children: [
                    Padding(padding: EdgeInsets.only(top: 40)),
                    InkWell(
                      onTap: (){

                        Navigator.push(context,
                            MaterialPageRoute(
                                builder: (context)=>
                                    DailyWord(title_name: index+1,)));
                      },

                      child:  educationBox(title_num: index+1,index:index) ,
                    )

                  ],);
                },itemCount: 10,

                )
                ,
              );


            }
          }
      )


    );
  }
}
class educationBox extends StatefulWidget {
  const educationBox({Key? key,this.title_num,this.index}) : super(key: key);

  final title_num;
  final index;
  @override
  State<educationBox> createState() => _educationBoxState();
}

class _educationBoxState extends State<educationBox> {
  double cal_width(index)
  {
   var total_num=context.read<user_infodata>().pass_num[index];
   var return_val=(170/10)*total_num;


    return return_val;
  }

  int cal_study_pro(index)
  {
    var total_num=context.watch<user_infodata>().pass_num[index];
    var return_val=total_num*20;
    return return_val;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius:1,
                blurRadius: 2

            )]
        ),
        child:    SizedBox(
          width: 330,
          height: 120,
          child: Column(

            children: [

              SizedBox(height: 10,),

              Row(

                children: [
                  Padding(padding: EdgeInsets.all(10),
                    child:context.read<user_infodata>().pass_num[widget.index]==10?Text("학습 완료!",style: TextStyle(color: Colors.blueAccent),):
                    context.read<user_infodata>().pass_num[widget.index]==0?Text("미학습",style: TextStyle(color: Colors.blueAccent),):Text("학습중",style: TextStyle(color: Colors.blueAccent),))
                ],
              )
              ,Padding(padding: EdgeInsets.only(top: 2),

                child: Row(

                  children: [
                    Padding(padding: EdgeInsets.only(left: 10)),
                    Text("Part "+widget.title_num.toString(),style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),
                    ),


                    Padding(padding: EdgeInsets.only(left: 220),
                      child: Text("▶",style: TextStyle(
                          fontSize: 20
                      ),),
                    )


                  ],
                ),)

              ,
              Padding(padding: EdgeInsets.only(top: 5)),
              Padding(padding: EdgeInsets.only(left: 10),
                child:
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),


                        border: Border.all(color:Colors.blueGrey),


                      ),
                      child: SizedBox(
                        height: 10,
                        width: 170,
                        child: Row(
                          children: [
                            Container(
                              width: cal_width(widget.index),
                              color: Colors.blue[300],
                            )
                          ],
                        ),

                      ),
                    ),

                    Padding(padding: EdgeInsets.only(left: 15),

                      child: Text("학습률  "+cal_study_pro(widget.index).toString()+" / 200"),),



                  ],
                )
                ,
              )




            ],
          ),

        ) ,

    )
      ;
  }
}
