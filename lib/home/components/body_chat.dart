import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterchat/constrain.dart';
import 'package:flutter/material.dart';

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
                    return Container(child: Text(snapshot.data!.docs[index]['message']));
                  });
            } else {
              return Container();
            }
          }),
    );
  }
}
