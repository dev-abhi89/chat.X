import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterchat/constrain.dart';
import 'package:flutterchat/home/components/message_field.dart';
import 'package:flutterchat/service/database_services.dart';
import 'package:flutterchat/service/img_service.dart';
import 'package:google_fonts/google_fonts.dart';

import '../loading.dart';
import 'components/body_chat.dart';

class ChatScreen extends StatefulWidget {
  final String roomID;
  final Map<dynamic,dynamic> usermp;

   ChatScreen({Key? key,required this.roomID,required this.usermp}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController message =TextEditingController();
bool isloading=true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Future.delayed(Duration(seconds: 2),(){
      setState(() {
        isloading=false;
      });
    });
    return MaterialApp(
      home:isloading?Loading() :Scaffold(
        body: Scaffold(
          backgroundColor: kPrimaryLightColor,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: kPrimaryColor,
            flexibleSpace: SafeArea(
              child: Container(
                padding: EdgeInsets.only(right: 16),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.arrow_back_ios_new_outlined,
                        size: 30,
                        color: kPrimaryLightColor,
                      ),
                    ),
                    SizedBox(
                      width: 1,
                    ),
                    CircleAvatar(
                      backgroundColor: kPrimaryLowColor,
                      radius: 30,
                      backgroundImage:widget.usermp['profile']==""?NetworkImage("https://firebasestorage.googleapis.com/v0/b/flutterchat-84cda.appspot.com/o/images%2F12ef37c0-1a17-11ec-8e36-b1c8c8e1ee16.jpg?alt=media&token=48c137ed-66b4-475d-b49e-8046c09d29b0") :NetworkImage(widget.usermp['profile']),

                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.usermp['name'],
                            style: GoogleFonts.k2d(
                                fontSize: 18,
                                color: kPrimaryLightColor,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          StreamBuilder(
                            stream: FirebaseFirestore.instance.collection('users').doc(widget.usermp['uid']).snapshots(),
                            builder: (context ,AsyncSnapshot<DocumentSnapshot> snapshot) {

                            if(snapshot.hasData) { return Text(
                                snapshot.data!['status'],
                                style: GoogleFonts.kufam(
                                    fontSize: 16,
                                    color: Color(0xFF81E87C),
                                    fontWeight: FontWeight.w500),
                              );
                            }else{
                              return Text("getting", style: GoogleFonts.kufam(
                                  fontSize: 16,
                                  color: Color(0xFF81E87C),
                                  fontWeight: FontWeight.w500),);
                            }
                            }
                          )
                        ]),
                  ],
                ),
              ),
            ),
            titleSpacing: 1,
            actions: [
              IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
            ],
          ),
          body: BodyChat(roomid: widget.roomID),


          /////////////////////////


bottomNavigationBar: MessageField(roomid: widget.roomID,size: size,message:message,imgtab:(){ImageService().imgPick(widget.roomID);},ontab: () async{
  DatabaseService().onMessageSend(message.text, widget.roomID);
  message.clear();
}),

        ),
      ),
    );

  }
}
