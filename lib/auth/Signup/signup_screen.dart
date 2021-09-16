import 'package:flutter/material.dart';

import 'components/BodySignup.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodySignup(),
    );
  }
}
