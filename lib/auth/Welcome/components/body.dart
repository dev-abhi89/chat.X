import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterchat/auth/Signup/signup_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutterchat/auth/Login/login_screen.dart';
import 'package:flutterchat/auth/Welcome/components/background.dart';
import 'package:flutterchat/auth/Welcome/components/roundedbtn.dart';
import 'package:flutterchat/constrain.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return bground(
        child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Welcome To EEEDU",
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          SizedBox(height: size.height * 0.04),
          SvgPicture.asset(
            'assets/icons/chat.svg',
            height: size.height * 0.45,
          ),
          SizedBox(height: size.height * 0.04),
          RoundedBtn(
            text: "LOGIN",
            press: (){Navigator.push(context,MaterialPageRoute(builder: (context){
              return LoginScreen();
            },
            ),);

            },
          ),
          RoundedBtn(
            text: "SIGN UP",
            press: (){Navigator.push(context, MaterialPageRoute(builder: (context){
              return SignupScreen();
            }));},
            color: kPrimaryLightColor,
            textcolor: Colors.black,
          ),

        ],
      ),
    ));
  }
}
