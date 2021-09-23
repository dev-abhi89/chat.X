import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterchat/home/home_screen.dart';
import 'package:flutterchat/service/auth_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutterchat/auth/Signup/signup_screen.dart';
import 'package:flutterchat/constrain.dart';
import 'package:flutterchat/auth/Welcome/components/roundedbtn.dart';

import 'components/body_login.dart';
import 'components/login_input_decoration.dart';
import 'components/login_text_field.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '';

  String pass = '';

  String error = '';

 bool isloading = false;

  StreamController<String> _errorcontroller = StreamController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: BodyLogin(
            child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Login page",
            style: GoogleFonts.kufam(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: kPrimaryColor),
          ),
          SvgPicture.asset(
            "assets/icons/chat.svg",
            height: size.height * 0.35,
          ),
          LogintextField(
            child: LoginInputField(
              hintext: "enter YourEmail",
              icon: Icons.person,
              onChanged: (value) {
                email = value;
              },
            ),
          ),
          LogintextField(
            child: LoginInputField(
              hintext: "enter Your PAssword",
              onChanged: (val) {
                pass = val;
              },
              icon: Icons.lock,
              secureText: true,
            ),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          RoundedBtn(
            text: "LOGIN",
            press: () async{
              if (email.length > 6 && pass.length > 6) {
                setState(() {
                  isloading=true;
                });
                dynamic usr =await AuthService().LoginEmailPass(email, pass);
                if (usr == null) {
                  error = "Enter valid Email And Password";
                  _errorcontroller.sink.add(error);
                  setState(() {
                    isloading=false;
                  });
                } else {
                  Navigator.push(context, MaterialPageRoute(builder: (contect) {
                    return HomeData();
                  },),);
                }
              }else{
                error = "Enter valid Email And Password";
                _errorcontroller.sink.add(error);
                setState(() {
                  isloading=false;
                });
              }
            },
          ),
          Login_blow(
            onTouch: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SignupScreen();
                  },
                ),
              );
            },
            text: "Don't have an account?",
            touchText: "SIGNUP",
          ),
          SizedBox(
            height: size.height * 0.04,
          ),
          StreamBuilder(
            stream: _errorcontroller.stream,
            initialData: '',
            builder: (context, snapshot) {
              return Text(
                snapshot.data.toString(),
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              );
            },
          )
        ],
      ),
    )));
  }
}

class Login_blow extends StatelessWidget {
  final String text;
  final String touchText;
  final Function onTouch;
  const Login_blow({
    Key? key,
    required this.text,
    required this.onTouch,
    required this.touchText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: GoogleFonts.kufam(
              fontSize: 14, color: kPrimaryColor, fontWeight: FontWeight.w500),
        ),
        GestureDetector(
          onTap: () => {onTouch()},
          child: Text(
            touchText,
            style: GoogleFonts.kufam(
                fontSize: 16,
                color: kPrimaryColor,
                fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }
}
