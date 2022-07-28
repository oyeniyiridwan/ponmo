import 'package:flutter/material.dart';
import 'package:ponmo/control/control.dart';
import 'package:ponmo/service/auth.dart';
import 'package:ponmo/service/user.dart';
import 'package:provider/provider.dart';

//import 'control/control.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
        value: AuthService().user,
        child: MaterialApp(
          theme: ThemeData(
              //primarySwatch: Colors.grey,
              primaryColor: Colors.deepOrange),
          debugShowCheckedModeBanner: false,
          title: "Ponmo",
          home: Control(),
        ));
  }
}
