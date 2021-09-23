import 'package:flutter/material.dart';
import 'package:flutterchat/loading.dart';
import 'package:flutterchat/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyAwesomeapp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false
      ,title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: Wrapper()
    );
  }
}
class MyAwesomeapp extends StatefulWidget {
  const MyAwesomeapp({Key? key}) : super(key: key);

  @override
  _MyAwesomeappState createState() => _MyAwesomeappState();
}

class _MyAwesomeappState extends State<MyAwesomeapp> {
  final Future<FirebaseApp> _intialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:_intialization ,
      builder: (context ,snapshot){
        if(snapshot.hasError){
          MaterialApp(
            home: Loading(),
          );
        }
        if(snapshot.connectionState==ConnectionState.done){
          return MyApp();
        }
        return MaterialApp(
          home: Loading(),
        );
      },

    );
  }
}


