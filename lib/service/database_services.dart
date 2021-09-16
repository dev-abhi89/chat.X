import 'dart:core';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class DatabaseService {

  FirebaseFirestore _dbauth = FirebaseFirestore.instance;
  FirebaseAuth _authbase = FirebaseAuth.instance;


  Future setdata(String name, String email,
      {String status = "unavailable"}) async {
    if (FirebaseAuth.instance.currentUser != null) {
      try {
        await _dbauth.collection('users').doc(
            FirebaseAuth.instance.currentUser?.uid).set(
            {
              'name': name,
              'email': email,
              'status': status,
            }
        );
      } catch (e) {
        print(e.toString());
      }
    }
  }


  Future Searchdata(String email) async {
    if (_authbase.currentUser != null) {
      Map<String, dynamic> userdta = {};
      try {
        await _dbauth.collection('users').
        where('email', isEqualTo: email).
        get().
        then((value) {
          userdta = value.docs[0].data();
          print("udata:: $userdta");
        }
        );
        return userdta;
      } catch (e) {
        print(e.toString());
        return null;
      }
    }
  }
  void onMessageSend(String msg,String id) async{
  await  _dbauth.collection('chatroom').doc(id).collection('chats').add({
      'sendby': _authbase.currentUser!.displayName,
      'message': msg,
      'time':FieldValue.serverTimestamp()

    });
  }
  

}