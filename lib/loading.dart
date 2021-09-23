import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'constrain.dart';
class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: kPrimaryLightColor,
      width: size.width,
      height: size.height*0.4,
      child: Center(
        child: SpinKitChasingDots(
          color: kPrimaryColor,
        ),
      )
    );
  }
}
