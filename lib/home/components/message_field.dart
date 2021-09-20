import 'package:flutter/material.dart';
import 'package:flutterchat/service/database_services.dart';

import '../../constrain.dart';

class MessageField extends StatelessWidget {
  MessageField({
    Key? key,
    required this.size,
    required this.roomid,
    required this.message,required this.ontab,
    required this.imgtab
  }) : super(key: key);
  final Function imgtab;
  final Size size;
  final Function ontab;
  final String roomid;
  TextEditingController message;

  @override
  Widget build(BuildContext context) {
    return Container(
//      bottom:MediaQuery.of(context).viewInsets.bottom,

      //bottom:MediaQuery.of(context).viewInsets.bottom,
      child: Container(


        margin: EdgeInsets.symmetric(horizontal: 10,),
        child: Container(
          padding:EdgeInsets.symmetric(vertical: 10) ,
          margin: EdgeInsets.symmetric(vertical: 5),decoration: BoxDecoration(
            color: kPrimaryLightColor
        ),
          width: size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
                  controller: message
                  ,decoration: InputDecoration(

                    border: InputBorder.none,
                    hintText: "Enter Your Message",
                    fillColor: kPrimaryColor,
                    icon: IconButton(onPressed:()=> imgtab(), icon: Icon(Icons.image,size:20,color: kPrimaryColor,))),
                ),
              ),
              IconButton(
                highlightColor: kPrimaryLowColor,
                onPressed: (){ontab();},
                icon: Icon(
                  Icons.send_rounded,
                  color: kPrimaryColor,
                  size: size.width*0.1,
                ),

              ),

            ],

          ),
        ),
      ),
    );
  }
}