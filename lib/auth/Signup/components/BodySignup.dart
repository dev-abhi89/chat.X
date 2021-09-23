import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterchat/home/home_screen.dart';
import 'package:flutterchat/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterchat/service/database_services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutterchat/auth/Login/components/login_input_decoration.dart';
import 'package:flutterchat/auth/Login/components/login_text_field.dart';
import 'package:flutterchat/auth/Login/login_screen.dart';
import 'package:flutterchat/auth/Signup/components/signupbackground.dart';
import 'package:flutterchat/auth/Welcome/components/roundedbtn.dart';
import 'package:flutterchat/constrain.dart';

import '../../../loading.dart';
class BodySignup extends StatefulWidget {

  @override
  _BodysignupState createState() => _BodysignupState();

}
class _BodysignupState extends State<BodySignup>{

  late String name ='';
  String error = '';
  StreamController<String> _errorcontoller = StreamController<String>();
  StreamController<String?> _namecontroller = StreamController<String?>();
  late String email='';
  late String password='';
  bool isloading = false;
  @override

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print("changess");
    return SignupBackground(child:SingleChildScrollView(
      child: isloading? Loading():Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("SIGN UP",style: GoogleFonts.kufam(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: kPrimaryColor
          ),),
          SvgPicture.asset('assets/icons/signup.svg',height: size.height*0.35,),
          StreamBuilder(
            stream:_namecontroller.stream,
            builder: (context, snapshot)
            { return LogintextField(child: LoginInputField(
              hintext: "Enter Your First Name",
              icon: Icons.person,
              onChanged: (value){name = value;
              _namecontroller.sink.add(name);
              },

            ));}
          ),

          LogintextField(child: LoginInputField(
            hintext: "Enter Yout Email",
            icon: Icons.email,
            onChanged: (value){email = value;},

          ),),
          LogintextField(child: LoginInputField(
            hintext: "Enter Password",
            icon: Icons.lock,
            onChanged: (value){password = value;},
            secureText: true,
          ),),
          RoundedBtn(
            text: "SIGN UP",
            press: ()  async{

             if(email.length>5 &&password.length>6 &&  name.length>3){
                setState(() {
                  isloading =true;
                });
              dynamic user = await AuthService().SignupEmailPass(email, password,name) ;
              if (user==null){

              error = "Enter Valid Details";
              _errorcontoller.sink.add(error);
              setState(() {
                isloading=false;
              });
              }else{
                await DatabaseService().setdata(name, email,user.uid);
                Navigator.push(context, MaterialPageRoute(builder: (contect) {
                  return HomeData();
                },),);
              }
    }  else{
               error = "Enter Valid Details";
               _errorcontoller.sink.add(error);
               setState(() {
                 isloading=false;
               });
    }          },

          ),
          Login_blow(text: "Already have an account?",
            touchText: "LOGIN",
            onTouch: (){Navigator.pop(context);},),
    StreamBuilder(
    stream: _errorcontoller.stream,
    initialData: ' '
    ,builder: (context,snapshot){
      return  Text(snapshot.data.toString(), style: TextStyle(
      color: Colors.red,
    fontSize: 16,
    fontWeight: FontWeight.w500
    ),);
    }),


        ],
      ),
    ),);
  }
}
