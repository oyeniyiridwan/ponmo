import 'package:flutter/material.dart';
import 'package:ponmo/Screens/register.dart';
import 'package:ponmo/Screens/signin.dart';
class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignin = true;
  void toggleView(){setState(() {showSignin = !showSignin;

  });

  }
  @override
  Widget build(BuildContext context) {
    if(showSignin){
        return SignIn(toggleView: toggleView);}
    else{
      return Register(toggleView: toggleView);}


  }
}





