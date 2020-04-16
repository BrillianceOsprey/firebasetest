import 'package:auth/models/brew.dart';
import 'package:auth/screens/home/settings_form.dart';
import 'package:auth/services/auth.dart';

import 'package:flutter/material.dart';
import 'package:auth/services/database.dart';
import 'package:provider/provider.dart';
import 'package:auth/screens/home/brew_list.dart';
 
 class Home extends StatelessWidget {
   final AuthService _auth =AuthService();
   @override
   Widget build(BuildContext context) {
     void _showSettingsPanel(){
       showModalBottomSheet(context: context, builder: (context){
         return Container(
           padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
           child: SettingsForm(),
         );
       });
     }
     return StreamProvider<List<Brew>>.value(
       value: DatabaseService().brews,
            child: Scaffold(
          backgroundColor: Colors.brown[50],
          appBar: AppBar(
            title: Text('Brew Crew'),
            elevation: 0.0,
            actions: <Widget>[
              FlatButton.icon(
               icon: Icon(Icons.person), 
               label: Text('Logout'),
               onPressed: ()async{
                 await _auth.signOut();

               },
               ),
               FlatButton.icon(
                 icon: Icon(Icons.settings),
                 label: Text('settings'),
                 onPressed: ()=>_showSettingsPanel(),
                 )
            ],
          ),
         body: Container(
           decoration: BoxDecoration(
             image: DecorationImage(
               image: AssetImage('assets/bg.jpg'),
               fit: BoxFit.cover,
             )
           ),
           child: BrewList()
           ),
       ),
     );
   }
 }