import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:word_test/constants.dart';
import 'DailyWord.dart';



class WordScreen extends StatefulWidget {
  const WordScreen({Key? key}) : super(key: key);

  @override
  State<WordScreen> createState() => _WordScreenState();
}

class _WordScreenState extends State<WordScreen> {
  double prog_val=20;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
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

          child:  educationBox(title_num: index+1,) ,
        )

       ],);
       },itemCount: 10,

       )
        ,
      )

    );
  }
}
class educationBox extends StatefulWidget {
  const educationBox({Key? key,this.title_num}) : super(key: key);

  final title_num;
  @override
  State<educationBox> createState() => _educationBoxState();
}

class _educationBoxState extends State<educationBox> {
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
                    child: Text("미학습",style: TextStyle(color: Colors.blueAccent),),)
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
                              width: 100,
                              color: Colors.blue[300],
                            )
                          ],
                        ),

                      ),
                    ),

                    Padding(padding: EdgeInsets.only(left: 15),

                      child: Text("학습률  120 / 200"),),



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
