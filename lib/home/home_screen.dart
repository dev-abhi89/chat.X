import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterchat/constrain.dart';
import 'package:flutterchat/home/chat_screen.dart';
import 'package:flutterchat/service/auth_service.dart';
import 'package:flutterchat/service/database_services.dart';
import 'package:flutterchat/setting/change_profile.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeData extends StatefulWidget {
  @override
  State<HomeData> createState() => _HomeDataState();
}

class _HomeDataState extends State<HomeData> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    DatabaseService().changeStatus("online");
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      DatabaseService().changeStatus("online");
    } else {
      DatabaseService().changeStatus("Offline");
    }
  }

  String email = '';

  Map<String, dynamic> rst = {};
  String userId(String? user1, String? user2) {
    if (user1 != null && user2 != null) {
      if (user1[0].codeUnits[0] > user2[0].codeUnits[0]) {
        return "$user2$user1";
      } else {
        return "$user1$user2";
      }
    } else
      return "error page";
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryLightColor,
      appBar: AppBar(
        title: Text("ChatX"),
        backgroundColor: kPrimaryColor,
        foregroundColor: kPrimaryLightColor,
        elevation: 4,
        titleSpacing: 0.0,
        actions: [
          FlatButton.icon(
            onPressed: () {
              AuthService().Logout();
            },
            icon: Icon(
              Icons.logout_sharp,
              color: kPrimaryLightColor,
            ),
            label: Text(""),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 16),
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChangeProfile()));
              },
              child: Text("profile page")),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: size.width * 0.8,
                padding: EdgeInsets.symmetric(horizontal: 8),
                margin: EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: kPrimaryLowColor),
                child: TextField(
                  onChanged: (val) {
                    email = val;
                  },
                  decoration: InputDecoration(
                      hintText: "Search",
                      fillColor: kPrimaryColor,
                      icon: Icon(
                        Icons.search,
                        color: kPrimaryColor,
                      )),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  print("tappimg $email");
                  if (email.length > 6) {
                    rst = await DatabaseService().Searchdata(email);
                    setState(() {
                      rst;
                    });
                  }
                },
                child: Icon(
                  Icons.find_in_page,
                  size: size.width * 0.1,
                  color: kPrimaryColor,
                ),
              )
            ],
          ),
          rst.isNotEmpty
              ? SearchTile(
                  rst: rst,
                  onclick: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      String roomid = userId(
                          FirebaseAuth.instance.currentUser!.uid, rst['uid']);
                      return ChatScreen(roomID: roomid, usermp: rst);
                    }));
                  },
                )
              : SizedBox(
                  height: 0.2,
                )
        ],
      ),
    );
  }
}

class SearchTile extends StatelessWidget {
  const SearchTile({Key? key, required this.rst, required this.onclick})
      : super(key: key);

  final Map<String, dynamic> rst;
  final Function onclick;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
            onPressed: () {
              DatabaseService().addFriend(rst['uid'], rst['name']);
            },
            child: Text("testing")),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 1, color: kPrimaryColor)),
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
              leading: Icon(
                Icons.person,
                size: 40,
                color: kPrimaryColor,
              ),
              trailing: GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.chat,
                  color: kPrimaryColor,
                  size: 40,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
