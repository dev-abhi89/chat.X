import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutterchat/constrain.dart';
import 'package:flutterchat/loading.dart';
import 'package:flutterchat/service/database_services.dart';
import 'package:flutterchat/service/img_service.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangeProfile extends StatefulWidget {
  @override
  _ChangeProfileState createState() => _ChangeProfileState();
}

final user = FirebaseAuth.instance.currentUser;

class _ChangeProfileState extends State<ChangeProfile> {
  TextEditingController nameControler = TextEditingController();
  TextEditingController professionControler = TextEditingController();
  TextEditingController numberControler = TextEditingController();
  late String gender;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryLightColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 4,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.settings,
                color: kPrimaryLightColor,
              ))
        ],
      ),
      body: Container(
        child: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(user!.uid)
                .snapshots(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasData) {
                if (nameControler.text == "")
                  nameControler.text = snapshot.data!.get('name');
                if (professionControler.text == "")
                  professionControler.text = snapshot.data!.get('profession');
                if (numberControler.text == "")
                  numberControler.text = snapshot.data!.get('number').toString();
                gender = snapshot.data!.get('gender');
                // Map<dynamic,dynamic> data= snapshot.data as Map;
                return ListView(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 16, bottom: 16, left: 16),
                      child: Text(
                        "Edit Profile",
                        style: GoogleFonts.inter(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 20,
                                      spreadRadius: 3,
                                      offset: Offset(1, 2),
                                      color: Colors.grey)
                                ],
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: (snapshot.data!.get('profile') == "")
                                        ? NetworkImage(
                                            "https://firebasestorage.googleapis.com/v0/b/flutterchat-84cda.appspot.com/o/images%2F12ef37c0-1a17-11ec-8e36-b1c8c8e1ee16.jpg?alt=media&token=48c137ed-66b4-475d-b49e-8046c09d29b0")
                                        : NetworkImage(
                                            snapshot.data!.get('profile')))),
                          ),
                          Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 45,
                                height: 45,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: kPrimaryColor,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.white, width: 3)),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    ImageService().uploadProfile();
                                  },
                                ),
                              ))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Form(
                        child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          ProfileInput(
                            hintText: "Enter your name",
                            labelTxt: "Name",
                            Validator: (val) => val!.isEmpty
                                ? "enter valid Name"
                                : val.length < 3
                                ? "Must be more then 3 character"
                                : null,
                            txtcontroler: nameControler,
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          ProfileInput(
                            hintText: "Enter your Profession",
                            labelTxt: "Profession",
                            Validator: (val) => val!.isEmpty
                                ? "enter valid Profession"
                                : val.length < 3
                                ? " must be more then 3 character"
                                : null,
                            txtcontroler: professionControler,
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          ProfileInput(
                            hintText: "Hit - to unlock Number field",
                            labelTxt: "Number",
                            Validator: (val) => val.length!=10
                                ? "Number must have 10 digit"
                                : val.length >10
                                ? "Only 10 digits "
                                : null,
                            txtcontroler: numberControler,
                            keyboardTYP: TextInputType.phone,
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          DropdownButtonFormField(
                            value: gender==""? "select gender":gender,
                            onChanged: (val) {
                              gender = val.toString();
                            },
                            decoration: InputDecoration(
                              labelText: "Gender",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              labelStyle: TextStyle(
                                  color: kPrimaryColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                            items: {"select gender","Male", "Female"}.map((e) {
                              return DropdownMenuItem(
                                child: Text(e),
                                value: e,
                              );
                            }).toList(),
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  DatabaseService().updateUserData(
                                      nameControler.text,
                                      professionControler.text,
                                      numberControler.text,
                                      gender);
                                },
                                child: Text("Save"),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateColor.resolveWith(
                                          (states) => Colors.green),
                                  // fixedSize: MaterialStateProperty.resolveWith((states) {(300).toDouble();})
                                ),
                              )
                              // MaterialButton(onPressed: (){},child: Text("Save"),)
                            ],
                          )
                        ],
                      ),
                    ))
                  ],
                );
              } else {
                return Loading();
              }
            }),
      ),
    );
  }
}

class ProfileInput extends StatelessWidget {
  ProfileInput(
      {Key? key,
      required this.labelTxt,
      required this.hintText,
      required this.txtcontroler,
      this.keyboardTYP = TextInputType.text,required this.Validator})
      : super(key: key);
  final String labelTxt;
  TextEditingController txtcontroler;
 final Function Validator;
  final String hintText;
  TextInputType keyboardTYP;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardTYP,
      controller: txtcontroler,
      validator: (val){return Validator(val);},
      decoration: InputDecoration(
        labelText: labelTxt,
        hintText: hintText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle:
            TextStyle(color: kPrimaryColor, fontWeight: FontWeight.w500),
      ),
      style: TextStyle(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
    );
  }
}
