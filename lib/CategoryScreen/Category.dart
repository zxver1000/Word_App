import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:core';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:word_test/main.dart';
import 'dart:async';
class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: ()async {
        String json = await rootBundle.loadString('assets/word.txt');
        //  print(json);

        final k = json.split('\r\n');
        var idx = 0;
        var name;
        var word;
        var next_idx = 1;

        Map<String, String>words1 = {};
        Map<String, String>words2 = {};
        Map<String, String>words3 = {};
        Map<String, String>words4 = {};
        Map<String, String>words5 = {};
        Map<String, String>words6 = {};
        Map<String, String>words7 = {};
        Map<String, String>words8 = {};
        Map<String, String>words9 = {};
        Map<String, String>words10 = {};


        Map<String, dynamic>return_val = {};
        for (var n in k) {
          //print(n);
          if (idx % 2 == 0) {
            name = n;
          }
          else {
            word = n;
            if (next_idx == 1) {
              words1.addAll({name: word});
            }
            else if (next_idx == 2) {
              words2.addAll({name: word});
            }
            else if (next_idx == 3) {
              words3.addAll({name: word});
            }
            else if (next_idx == 4) {
              words4.addAll({name: word});
            }
            else if (next_idx == 5) {
              words5.addAll({name: word});
            } else if (next_idx == 6) {
              words6.addAll({name: word});
            } else if (next_idx == 7) {
              words7.addAll({name: word});
            } else if (next_idx == 8) {
              words8.addAll({name: word});
            } else if (next_idx == 9) {
              words9.addAll({name: word});
            }
            else if (next_idx == 10) {
              words10.addAll({name: word});
            }
          }


          idx++;


          if (idx % 420 == 0 && idx != 0) {
            var Names = 'part';
            Names += next_idx.toString();
            Map<String, String> headers = {'Content-Type': 'application/json; charset=utf-8'};
          // print(Names);
            // var ak=await http.get(uri,headers:headers);

            if (next_idx == 1) {
              return_val.addAll({Names: words1});
            }
            else if (next_idx == 2) {
              return_val.addAll({Names: words2});
            }
            else if (next_idx == 3) {
              return_val.addAll({Names: words3});
            }
            else if (next_idx == 4) {
              return_val.addAll({Names: words4});
            }
            else if (next_idx == 5) {
              return_val.addAll({Names: words5});
            } else if (next_idx == 6) {
              return_val.addAll({Names: words6});
            } else if (next_idx == 7) {
              return_val.addAll({Names: words7});
            } else if (next_idx == 8) {
              return_val.addAll({Names: words8});
            } else if (next_idx == 9) {
              return_val.addAll({Names: words9});
            }
            else if (next_idx == 10) {
              return_val.addAll({Names: words10});
            }


            next_idx++;
            if (next_idx == 11) {
              print(return_val);

              return_val.addAll({'NAME': "word"});
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
              var ak = await http.put(
                  uri, headers: headers, body: jsonEncode(return_val));
              if (ak.statusCode == 200) {
                print("성공");

                var data = utf8.decode(ak.bodyBytes);
                var k = jsonDecode(data);
              }
              else {
                print("실패");
              }
              break;
            }
          }
        }


      },
      child: Text("test"
          ),
    );
  }
}
