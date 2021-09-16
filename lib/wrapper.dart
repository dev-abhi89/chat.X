import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterchat/auth/Welcome/Myhome.dart';

import 'home/home_screen.dart';

class Wrapper extends StatelessWidget {

User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
    stream: FirebaseAuth.instance.authStateChanges()
    ,builder: (context, snapshot){
      if(snapshot==null){
        return MyHome();
      }
      else if (snapshot.hasData){
        if(snapshot.data != null){
          return HomeData();
        }else{
          return MyHome();
        }

      }
      return MyHome();
    });
  }
}
