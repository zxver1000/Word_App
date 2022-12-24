import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:word_test/constants.dart';

import 'WordScreen.dart';
import 'package:bubble/bubble.dart';
import 'PartWord.dart';
class DailyWord extends StatefulWidget {
  const DailyWord({Key? key,this.title_name}) : super(key: key);
final title_name;
  @override
  State<DailyWord> createState() => _DailyWordState();
}

class _DailyWordState extends State<DailyWord> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(iconTheme: IconThemeData(
        color: Colors.black,//색변경
      ),backgroundColor: Colors.yellow[100],title: Text("Part "+widget.title_name.toString()
        ,style: TextStyle(color: Colors.black),
      ),


        ),
      body: GridView.builder(
      itemCount: 10, //item 개수
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2, //1 개의 행에 보여줄 item 개수
   //item 의 가로 1, 세로 2 의 비율
    mainAxisSpacing: 10, //수평 Padding
    crossAxisSpacing: 10, //수직 Padding
    ),itemBuilder: (BuildContext context, int index){
        return InkWell(
          onTap: (){
            var k=index+1;
            Navigator.push(context,
                MaterialPageRoute(
                    builder: (context)=>
                       PartWord(title_name: "Unit "+widget.title_name.toString()+"-"+k.toString(),)));

          },
          child: Padding(padding: EdgeInsets.all(20),
            child: item(num: index+1,title_num: widget.title_name,),),
        );
      }
      ),

    );
  }
}


class item extends StatefulWidget {
  const item({Key? key,this.num,this.title_num}) : super(key: key);
final num;
final title_num;
  @override
  State<item> createState() => _itemState();
}

class _itemState extends State<item> {
  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius:1.5,
              blurRadius: 2

          )]
      ),
      child: SizedBox(
        width: 100,
        height: 100,
        child: Column(

          children: [
        Row(children: [
      Padding(padding: EdgeInsets.all(10)
      ,child:     Text("Unit "+widget.title_num.toString()+"-"+widget.num.toString(),style: TextStyle(
          color: Colors.blue
        ),)

        ,)
,
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black45),
              color: Colors.yellowAccent[100]
            ),
            width: 10,
            height: 10,
          )
        ],),

            Text(widget.num.toString(),style: TextStyle(fontSize: 70,fontWeight: FontWeight.w500),),

            Padding(padding: EdgeInsets.only(top: 20),child: Text("0 / 20"),)

          ],
        ),
      ),
    );
  }
}
