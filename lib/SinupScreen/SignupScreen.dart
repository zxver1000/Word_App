import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';



class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

var _isMale = false;
var _isFeMale = false;
var action = 0;

bool TF = false;

final confirmEmailEditingController =  TextEditingController();
final CEmailEditingController =  TextEditingController();

final CEmailField= TextFormField(
  autofocus: false,
  controller: CEmailEditingController,
  obscureText: true,


  autovalidateMode: AutovalidateMode.onUserInteraction,
  onSaved: (value){
    CEmailEditingController.text=value!;
  },

  textInputAction: TextInputAction.done,
  decoration: InputDecoration(
    prefixIcon: Icon(Icons.vpn_key),
    contentPadding: EdgeInsets.fromLTRB(20,15,20,15),
    hintText: "인증코드 입력",
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(2),
    ),
  ),);


bool _isObscure = true;
class _SignupScreenState extends State<SignupScreen> {



  @override
  final _formkey = GlobalKey<FormState>();
  final _emailkey = GlobalKey<FormState>();
  final NameEditingController =  TextEditingController();
  final emailEditingController =  TextEditingController();
  final passwordEditingController=  TextEditingController();
  final NickNameEditingController =  TextEditingController();
  final confirmPasswordEditingController =  TextEditingController();


  final phoneNumber =  TextEditingController();
  final department = TextEditingController();
  FocusNode CEmailFocusNode = FocusNode();
  FocusNode NameFocusNode = FocusNode();
  FocusNode EmailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode NickNameFocusNode = FocusNode();
  FocusNode confirmFocusNode = FocusNode();
  FocusNode confirmEFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode departmentNode = FocusNode();


  int _tryValidation() {
    final isValid = _formkey.currentState!.validate();
    if(isValid)
    {
      _formkey.currentState!.save();
      return 1;
    }
    else return -1;
  }
  int _tryValidationemail() {
    final isValid = _emailkey.currentState!.validate();
    if(isValid)
    {
      _emailkey.currentState!.save();
      return 1;
    }
    else return -1;
  }

  Widget build(BuildContext context) {

    final departmentFiled= TextFormField(
      autofocus: false,
      controller: department,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value){
        department.text=value!;
      },

      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),

        prefixIcon: Icon(Icons.account_circle),
        contentPadding: EdgeInsets.fromLTRB(20,15,20,15),
        hintText: "학과",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
    final phoneFiled= TextFormField(
      focusNode:phoneFocusNode,
      autofocus: false,
      controller: phoneNumber,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value){
        phoneNumber.text=value!;
      },

      validator: (value){
        RegExp regex =new RegExp(r'^010-?([0-9]{4})-?([0-9]{4})$');
        if (value!.isEmpty){
          return("필수 정보입니다.");
        }
        if(!regex.hasMatch(value)){
          return (" 올바른 전화번호 형식이 아닙니다.");
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        prefixIcon: Icon(Icons.phone_android_outlined),
        contentPadding: EdgeInsets.fromLTRB(20,15,20,15),
        hintText: "Phone Number",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),);

    //Name
    final NameField= TextFormField(
      autofocus: false,
      controller: NameEditingController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value){
        NameEditingController.text=value!;
      },

      validator: (value){
        RegExp regex =new RegExp(r'^[ㄱ-ㅎ|ㅏ-ㅣ|가-힣a-zA-Z]{2,}$');
        if (value!.isEmpty){
          return("필수 정보입니다.");
        }
        if(!regex.hasMatch(value)){
          return (" 2글자 이상 공백을 제외하고 실명을 입력해 주세요");
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        prefixIcon: Icon(Icons.account_circle),
        contentPadding: EdgeInsets.fromLTRB(20,15,20,15),
        hintText: "Id",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),);

    //Name
    final nickNameField= TextFormField(
      autofocus: false,
      controller: NickNameEditingController,
      keyboardType: TextInputType.emailAddress,
      validator: (value){
        RegExp regex =new RegExp(r'^[ㄱ-ㅎ|ㅏ-ㅣ|가-힣a-zA-Z]{2,8}$');
        if (value!.isEmpty){
          return("필수 정보입니다.");
        }
        if(!regex.hasMatch(value)){
          return ("공백 제외 최소 2-8글자이내 입력해 주세요");
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onSaved: (value){
        NickNameEditingController.text=value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.account_circle),
        contentPadding: EdgeInsets.fromLTRB(20,15,20,15),
        hintText: "별명",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),);



    //emailID
    String Id = "";

    final EmailField= TextFormField(
      readOnly: true,
      enabled: false,
      focusNode:EmailFocusNode,
      controller: confirmEmailEditingController,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.none,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.account_circle),
        contentPadding: EdgeInsets.fromLTRB(20,15,20,15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    String _id = '';
    final confirmEmail= TextFormField(
      focusNode:confirmEFocusNode,
      controller: confirmEmailEditingController,
      keyboardType: TextInputType.emailAddress,

      validator: (value){
        RegExp regex2 =new RegExp(r'^[0-9a-zA-Z]{2,}$');
        if (value!.isEmpty){
          return("필수정보입니다.");
        }
        if(!regex2.hasMatch(value)){
          return ("건국대 이메일을 입력해주세요");
        }
        return null;
      },

      autovalidateMode: AutovalidateMode.onUserInteraction,
      onSaved: (value){
        setState(() {
          _id = value as String;
        });
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.mail),
        contentPadding: EdgeInsets.fromLTRB(30,15,20,15),
        hintText: "",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),);

    final passWordField= TextFormField(
      autofocus: false,
      controller: passwordEditingController,
      focusNode:passwordFocusNode,
      obscureText: _isObscure,
      validator: (value){
        RegExp regex =new RegExp (r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?~^<>,.&+=])[A-Za-z\d$@$!%*#?~^<>,.&+=]{8,15}$');
        if (value!.isEmpty){
          return("필수 정보입니다.");
        }
        if(!regex.hasMatch(value)){
          return ("8~16자 영문자,숫자,툭수문자를 사용하세요.");
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onSaved: (value){
        passwordEditingController.text=value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon:Icon(_isObscure ? Icons.visibility: Icons.visibility_off),
          onPressed: (){
            setState((){
              _isObscure =!_isObscure;
            });
          },
        ),
        prefixIcon: Icon(Icons.vpn_key),
        contentPadding: EdgeInsets.fromLTRB(20,15,20,15),
        hintText: "Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),);
    //confirmPassword
    final CpasswordField= TextFormField(
      autofocus: false,
      controller: confirmPasswordEditingController,
      obscureText: true,

      validator: (value)
      {
        if (value!.isEmpty){
          return("필수 정보입니다.");
        }
        if(confirmPasswordEditingController.text !=passwordEditingController.text)
        {
          return ("비밀번호가 일치하지 않습니다.");
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onSaved: (value){
        confirmPasswordEditingController.text=value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.vpn_key),
        contentPadding: EdgeInsets.fromLTRB(20,15,20,15),
        hintText: "Confirm Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),);




    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color:Colors.yellow[100],
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20,15,20,15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () async{


        },
        child: Text(
          "Sign Up",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20,color:Colors.black87,fontWeight: FontWeight.bold),
        ),
      ),
    );


    return Scaffold(
      appBar: AppBar( iconTheme: IconThemeData(
        color: Colors.black,//색변경
      ),title:Text("Sign Up Page",style: TextStyle(color: Colors.black),),backgroundColor: Colors.yellow[100],),
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child:Center(
          child: SingleChildScrollView(
            child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(36.0),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("ID",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            )),
                        SizedBox(height: 5),
                        NameField,
                        SizedBox(height: 25),
                        Text("PassWord",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            )),
                        SizedBox(height: 5),

                        passWordField,
                        SizedBox(height: 25),
                        Text("Phone Number",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            )),
                        SizedBox(height: 5),
                        phoneFiled,
                        SizedBox(height: 80),



                        signUpButton,
                        SizedBox(height: 30),

                      ],

                    ),
                  ),

                )
            ),
          ),
        ),
      ),);
}
}