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
                      child: Image.network(
                        rst['profile'],
                        fit: BoxFit.fill,
                      )),
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
