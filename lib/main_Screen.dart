import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:word_test/main.dart';
import 'package:word_test/word_screen/WordScreen.dart';
import './CategoryScreen/Category.dart';
import 'InfoScreen/info.dart';

class mainScreen extends StatefulWidget {
  const mainScreen({Key? key}) : super(key: key);

  @override
  State<mainScreen> createState() => _mainScreenState();
}




class _mainScreenState extends State<mainScreen> {

  var tab=1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar:AppBar(backgroundColor: Colors.yellow[100],title: Text("Daily Word",style: TextStyle(color: Colors.black),),actions: [Row(children: [
        IconButton(onPressed: (){
          context.read<loginindex>().logout();
        }, icon: Icon(Icons.exit_to_app_sharp),color: Colors.black,)
      ],)]

      ,),
body: [WordScreen(),CategoryScreen(),InfoScreen()][tab],

bottomNavigationBar: BottomNavigationBar(
  showUnselectedLabels: true,
  showSelectedLabels: true,
  type: BottomNavigationBarType.fixed,
  selectedItemColor: Colors.black,
  unselectedItemColor: Colors.grey,
  currentIndex:tab,
  backgroundColor: Colors.white70,
  onTap: (i){
    setState(() {
      tab=i;
    });
  },
  items: [
    BottomNavigationBarItem(
      label : 'Home',
      icon: Icon(Icons.home_outlined),


    ),
    BottomNavigationBarItem(
      label : 'Category',
      icon: Icon(Icons.category),

    )
    ,
    BottomNavigationBarItem(
      label : 'Info',
      icon: Icon(Icons.person),

    )
  ],
),
    );
  }
}

