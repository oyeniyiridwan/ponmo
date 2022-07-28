import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ponmo/Screens/introduction.dart';
import 'package:ponmo/service/auth.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: (Text("Home")),
        backgroundColor: Colors.deepOrange[400],
      elevation: 1.0,
      actions: <Widget>[
        FlatButton.icon(onPressed: ()async{
          await _auth.signOut();
        },
            icon: Icon(Icons.person),
            label: Text("Logout"))
      ],),
      body: Introduction()
    //)
    );
  }
}
