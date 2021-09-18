import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterchat/constrain.dart';
import 'package:flutterchat/home/components/message_field.dart';
import 'package:flutterchat/service/database_services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'components/body_chat.dart';

class ChatScreen extends StatefulWidget {
  final String roomID;
  final Map<String,dynamic> usermp;

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
                      child: Icon(
                        Icons.person,
                        color: kPrimaryLightColor,
                        size: 40,
                      ),
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
                          Text(
                            "online",
                            style: GoogleFonts.kufam(
                                fontSize: 16,
                                color: Color(0xFF81E87C),
                                fontWeight: FontWeight.w500),
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

         /* bottomNavigationBar: SingleChildScrollView(
            child Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: [
                    Container(
                      width: size.width *0.8,
                      padding: EdgeInsets.only(left: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Color(0xFFBCB4FC),
                      ),
                      child: TextField(
                        onChanged: (val) {},
                        controller: _message
                        ,decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter Your Message",
                            fillColor: kPrimaryColor,
                            icon: Icon(
                              Icons.message_rounded,
                              color: kPrimaryColor,
                            )),
                      ),
                    ),
                   IconButton(
                        highlightColor: kPrimaryLowColor,
                        onPressed: ()async {
                          DatabaseService().onMessageSend(_message.text, widget.roomID);
                          _message.clear();
                        },
                        icon: Icon(
                          Icons.send_rounded,
                          color: kPrimaryColor,
                          size: size.width*0.1,
                        ),

                      ),

                  ],
                ),
              ),
            ),*/
bottomNavigationBar: MessageField(roomid: widget.roomID,size: size,message:message,ontab: () async{
  DatabaseService().onMessageSend(message.text, widget.roomID);
  message.clear();
}),

        ),
      ),
    );

  }
}
