import 'package:flutter/material.dart';

import 'package:flutterchat/constrain.dart';


class RoundedBtn extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textcolor;


  RoundedBtn({
    Key ?key,
    required  this.text,
    required  this.press,
    this.color=kPrimaryColor,
    this.textcolor=Colors.white,
  }): super(key:key);


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width*0.8,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20)
      ),

      child: FlatButton(onPressed: ()=>{press()
    },
          padding: EdgeInsets.symmetric(vertical: 20,horizontal: 40),
          child: Text(text,
            style:TextStyle(color: textcolor),
          )
      ),

    );
  }
}