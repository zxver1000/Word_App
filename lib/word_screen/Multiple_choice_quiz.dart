import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:word_test/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


import 'package:flutter_tts/flutter_tts.dart';
import 'package:word_test/main.dart';
import 'dart:math';
class test_data{
  var correct_idx;
  List<String> name=[];
  var mean;
  test_data(this.correct_idx,this.name,this.mean);
}



class multi_quiz extends StatefulWidget {
  const multi_quiz({Key? key,this.col,this.row}) : super(key: key);
final row;
final col;
  @override
  State<multi_quiz> createState() => _multi_quizState();
}

class _multi_quizState extends State<multi_quiz> {
  var cur_idx=0;
  var choice=0;
  var sk=1;
  List<int>user_answer=[-1,-1,-1,-1,-1,-1,-1,-1,-1,-1];
  final FlutterTts tts = FlutterTts();

  List<test_data>test=[];
  @override
  void dispose() {
    // TODO: implement dispose
    tts.stop();
    super.dispose();
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
  void initState() {
    // TODO: implement initState
    super.initState();
    //아이템 셋팅

    //-> 일단 정답 4개 뽑고

    var word=context.read<word_data>().part_data[widget.col-1];

    List<int>array_int=[-1,-1,-1,-1,-1,-1,-1,-1,-1,-1];
    //중복제거 답

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

    for(var i=0;i<10;i++)
      {
        print(array_int[i]);
      }

    //4개씩 짝지어




    for(var s=0;s<10;s++) {
      var correct_num = Random().nextInt(4);
      List<int>a=[-1,-1,-1,-1];
      a[correct_num]=array_int[s];
      for (var i = 0; i < 4; i++) {
        if(i==correct_num)
          {
            continue;
          }
        var k = Random().nextInt(20);
        a[i] = k;
        if(a[correct_num]==a[i])
          {
            i--;
            continue;
          }

        for (int j = 0; j < i; j++) {
          if (a[j] == a[i]) {
            i--;
            break;
          }
        }
      }
      //여기까지 중복없이 고름
      //순서정해야됨
      List<String>pal=[];
      for(var i=0;i<4;i++)
        {
          pal.add(word[a[i]].mean);
        }
      test.add(test_data(correct_num, pal,word[array_int[s]].name));

    }
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
                                          child:  Text("Number "+sk.toString(),style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black54

                                          ),)
                                          ,
                                        )
                                        ,
                                        Padding(padding: EdgeInsets.only(left: 170),child: Text(sk.toString()+"/10"),)
                                      ],
                                    )



                                ),

                            ],
                          ),
                          Padding(padding: EdgeInsets.only(top: 30),child:
                            Text(test[cur_idx].mean.toString(),style: TextStyle(
                              fontSize: 25
                            ),),),
                          Padding(padding: EdgeInsets.only(top: 5),child:
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
            title: Text("1. "+test[cur_idx].name[0]),value : 1, groupValue: choice, onChanged: (val){

          setState(() {
            choice=1;

          });
          user_answer[cur_idx]=0;

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
                        title: Text("2. "+test[cur_idx].name[1]),value : 2, groupValue: choice, onChanged: (val){

                      setState(() {
                        choice=2;

                      });

                      user_answer[cur_idx]=1;
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
                        title: Text("3. "+test[cur_idx].name[2]),value : 3, groupValue: choice, onChanged: (val){

                      setState(() {
                        choice=3;

                      });
                      user_answer[cur_idx]=2;

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
                        title: Text("4. "+test[cur_idx].name[3]),value : 4, groupValue: choice, onChanged: (val){

                      setState(() {
                        choice=4;
                        user_answer[cur_idx]=3;
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
            setState(() {
              cur_idx--;
             sk--;
            });

            }
          else{


            setState(() {
              if(cur_idx<9)
                {
                  cur_idx++;
                  sk++;
                  if(user_answer[cur_idx]==-1)
                    {
                      user_answer[cur_idx]=user_answer[cur_idx-1];
                    }

                }
              else{
                var correct_num=0;
                var wrong_num=0;
                for(var i=0;i<10;i++)
                  {
                   if(user_answer[i]==test[i].correct_idx)
                     {
                       correct_num++;
                     }
                   else
                     {
                       wrong_num++;
                     }


                  }
                var pass="No";
                if(correct_num>8)
                  {
                    print("머임왜옴");

                    pass="Yes";
                    context.read<user_infodata>().pass_gack(widget.col, widget.row);
                  }
                print(correct_num);
                print(widget.col);
                print(widget.row);
                print("Zddz");
                print(pass);
                context.read<user_infodata>().add_try_gack(widget.col, widget.row);
                showdialog(correct_num,wrong_num,correct_num*10,pass);
              }

            });

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
