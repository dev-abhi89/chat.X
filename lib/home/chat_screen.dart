import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterchat/constrain.dart';
import 'package:flutterchat/home/components/message_field.dart';
import 'package:flutterchat/service/database_services.dart';
import 'package:flutterchat/service/img_service.dart';
import 'package:google_fonts/google_fonts.dart';

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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
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
                      child:widget.usermp['profile']==""? Icon(
                        Icons.person,
                        color: kPrimaryLightColor,
                        size: 40,
                      ):Image.network(widget.usermp['profile'],fit: BoxFit.cover,),
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
