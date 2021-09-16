import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterchat/constrain.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BodyChat extends StatefulWidget {
  final String roomid;
  const BodyChat({Key? key, required this.roomid}) : super(key: key);

  @override
  _BodyChatState createState() => _BodyChatState();
}

class _BodyChatState extends State<BodyChat> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: StreamBuilder<QuerySnapshot>(
          initialData: null,
          stream: FirebaseFirestore.instance
              .collection('chatroom')
              .doc(widget.roomid)
              .collection('chats')
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.data != null) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    Map dat = snapshot.data!.docs[index].data() as Map;
                    return Messagebox(size: size, data: dat);
                  });
            } else {
              return Container();
            }
          }),
    );


  }
}
class Messagebox extends StatelessWidget {
  const Messagebox({Key? key,required this.size, required this.data}) : super(key: key);
 final Size size;
 final  Map<dynamic ,dynamic> data;
  @override
  Widget build(BuildContext context){
    bool send = ( data['sendby']==FirebaseAuth.instance.currentUser!.displayName);
    return Row(
      mainAxisAlignment: send? MainAxisAlignment.end:MainAxisAlignment.start
      ,children:[ Flexible(
        child: Container(
          alignment:send? Alignment.centerRight:Alignment.centerLeft,
          margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
          padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: send?kPrimaryLowColor:Color(0xFF62EA45)
          ),
          child: Text(data['message'],style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),),),
      )]

    );
  }
}

