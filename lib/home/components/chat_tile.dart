import 'package:flutter/material.dart';
import 'package:flutterchat/service/database_services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constrain.dart';

class ChatTile extends StatelessWidget {
  const ChatTile({Key? key, required this.rst, required this.onclick})
      : super(key: key);

  final Map<dynamic, dynamic> rst;
  final Function onclick;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),),
          child: InkWell(
            splashColor: kPrimaryColor,
            hoverColor: kPrimaryLowColor,
            onTap: () => {onclick()},
            child: ListTile(
              title: Text(
                rst['name'],
                style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF7310EA)),
              ),
              subtitle: Text(
                rst['email'],
                style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF68577B)),
              ),
              leading: rst['profile'] == ""
                  ? Icon(
                      Icons.person,
                      size: 40,
                      color: kPrimaryColor,
                    )
                  : CircleAvatar(
                      radius: 40,
                backgroundImage:rst['profile']==""?NetworkImage("https://firebasestorage.googleapis.com/v0/b/flutterchat-84cda.appspot.com/o/images%2F12ef37c0-1a17-11ec-8e36-b1c8c8e1ee16.jpg?alt=media&token=48c137ed-66b4-475d-b49e-8046c09d29b0") :NetworkImage(rst['profile']),

              ),
              trailing: GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.circle_notifications,
                  color: Colors.green,
                  size: 30,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
