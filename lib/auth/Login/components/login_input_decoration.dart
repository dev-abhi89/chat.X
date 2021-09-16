import 'package:flutter/material.dart';

import '../../../constrain.dart';


class LoginInputField extends StatelessWidget {
  final String hintext;
  final ValueChanged<String>onChanged;
  final IconData icon;
  final bool secureText;

  const LoginInputField({
    Key? key,
    required this.hintext,
    required this.onChanged,
    this.icon=Icons.person,
    this.secureText=false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
          icon: Icon(icon,
            color: kPrimaryColor,),
          fillColor: kPrimaryColor,
          hintText: hintext,
          hintStyle: TextStyle(color: kPrimaryColor)
      ),
      obscureText: secureText,
    );
  }
}
