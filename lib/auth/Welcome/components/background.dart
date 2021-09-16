import 'package:flutter/material.dart';



class bground extends StatelessWidget {
  const bground({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,

      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            width: size.width*0.3,
            top: 0,
            left: 0,
            child:Image.asset('assets/images/main_top.png'),
          ),
          Positioned(
            width: size.width*0.3,
            bottom: 0,
            left: 0,
            child: Image.asset('assets/images/main_bottom.png'),
          ),

          child
        ],

      ),


    );
  }
}