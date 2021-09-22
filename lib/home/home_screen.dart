import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutterchat/constrain.dart';
import 'package:flutterchat/home/chat_screen.dart';
import 'package:flutterchat/service/auth_service.dart';
import 'package:flutterchat/service/database_services.dart';
import 'package:flutterchat/setting/change_profile.dart';
import 'package:google_fonts/google_fonts.dart';

import 'components/chat_tile.dart';

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
 List<dynamic> tempo =[];
 void gettingdta ()async{
   data = await DatabaseService().datafunc();
   Flist = await DatabaseService().FriendListFunc(data);

 }
dynamic data;
List<Map<dynamic,dynamic>>Flist=[];


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
    gettingdta();

    Size size = MediaQuery.of(context).size;
    /*for(dynamic i in data){
      print(i);
    }*/
    return Scaffold(
      backgroundColor: kPrimaryLightColor,
      appBar: AppBar(
        leading: IconButton(onPressed: (){Navigator.push(context,
            MaterialPageRoute(builder: (context) => ChangeProfile()));
        }, icon: Icon(Icons.person,color: kPrimaryLightColor,size: 30,)),
        title: Text("Barfi"),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        foregroundColor: kPrimaryLightColor,
        elevation: 0,
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

        children: [

          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: kPrimaryColor,),
            child: Row(
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
                    if (email.length > 6) {
                     try{ rst = await DatabaseService().Searchdata(email);
                      if (rst.isNotEmpty) {
                        showModalBottomSheet(
                            context: context, builder: (context) {
                          return SearchTile(
                            rst: rst,
                            onclick: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                    String roomid = userId(
                                        FirebaseAuth.instance.currentUser!.uid,
                                        rst['uid']);
                                    return ChatScreen(
                                        roomID: roomid, usermp: rst);
                                  }));
                            },
                          );
                        });
                      }}catch(e){
                       print(e.toString());
                       showModalBottomSheet(
                           context: context, builder: (context) {
                         return Text("NO Result Found!",style: GoogleFonts.kufam(
                             fontSize: 18,fontWeight: FontWeight.w500,color: Colors.red
                         )
                         );});
                     }



                    }
                  },
                  child: Icon(
                    Icons.search,
                    size: size.width * 0.1,
                    color: kPrimaryLightColor,
                  ),
                )
              ],
            ),
          ),
           SizedBox(
                  height: 0.2,
                ),
          Padding(
            padding: const EdgeInsets.only(top: 16,left: 16),
            child: Row(
              children: [
                Text("Favourites", style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),),
                IconButton(onPressed: (){setState(() {});}, icon: Icon(Icons.refresh,color: Colors.green,))
              ],
            ),
          ),
          Container(
            width: double.infinity,
            child:Flist.length==1?ChatTile(rst: Flist[0], onclick: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                    String roomid = userId(
                        FirebaseAuth.instance.currentUser!.uid, Flist[0]['uid']);
                    return ChatScreen(roomID: roomid, usermp: Flist[0]);
                  }));
            }) :ListView.builder(
            itemCount: Flist.length,
            scrollDirection: Axis.vertical
            ,shrinkWrap: true
                ,itemBuilder:(context,index){
              return Container(
                  width: double.infinity,
                  child: ChatTile(rst: Flist[index], onclick: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                          String roomid = userId(
                              FirebaseAuth.instance.currentUser!.uid, Flist[index]['uid']);
                          return ChatScreen(roomID: roomid, usermp: Flist[index]);
                        }));


                    //
                  }));
            } ),
          )

        ],
      ),
    );
  }
}

class SearchTile extends StatelessWidget {
  const SearchTile({Key? key, required this.rst, required this.onclick})
      : super(key: key);

  final Map<dynamic, dynamic> rst;
  final Function onclick;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16,left: 16),
          child: Text("Search Result", style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),),
        ),
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
                onTap: () {
                  DatabaseService().addFriend(rst['uid'], rst['name']);
                },
                child: Icon(
                  Icons.add,
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
