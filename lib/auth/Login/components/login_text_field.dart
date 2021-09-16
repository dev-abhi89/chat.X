import 'package:flutter/material.dart';

import '../../../constrain.dart';


class LogintextField extends StatelessWidget {
  final Widget child;
  const LogintextField({
    Key? key,
    required this.child,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width*0.8,
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.only(left: 30),
      height: size.height*0.06,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: kPrimaryLightColor
      ),
      child:child,
    );
  }
}

