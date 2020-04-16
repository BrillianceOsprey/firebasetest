import 'package:auth/models/user.dart';
import 'package:auth/screens/authenticate/authenticate.dart';
import 'package:auth/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user=Provider.of<User>(context);

    //return either home or authentication widget
    if(user==null){
      return Authentication();
    }
    else{
      return Home();
    }
  }
}