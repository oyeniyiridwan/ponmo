import 'package:flutter/material.dart';
import 'package:ponmo/Screens/home.dart';

import 'package:ponmo/service/authentificate.dart';
import 'package:ponmo/service/user.dart';
import 'package:provider/provider.dart';
class Control extends StatelessWidget {
  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    //print(user);

    if(user == null){
      return Authenticate();
    }else{return Home();}
  }
}
