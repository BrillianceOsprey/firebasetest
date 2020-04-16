import 'package:auth/models/user.dart';
import 'package:auth/services/database.dart';
import 'package:auth/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:auth/shared//constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey=GlobalKey<FormState>();
  final List<String> sugars=['0','1','2','3','4'];
  //form values
  String _currentName;
  String _currentSugars;
  int _currentStringth;
  @override
  Widget build(BuildContext context) {
    final user=Provider.of<User>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          UserData userData =snapshot.data;
           return Form(
          key: _formKey,
          child: Column(
            children:<Widget>[
              Text('update your brew Settings.',
              style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height:20.0),
              TextFormField(
                    initialValue: userData.name,
                    decoration: textInputDecoration,
                    validator: (val)=> val.isEmpty ? 'Please Enter Name' : null,
                     onChanged: (val)=>setState(()=> _currentName=val),
              ),
              SizedBox(height: 20.0),
              //dropdown
              DropdownButtonFormField(
                  decoration: textInputDecoration,
                value: _currentSugars ?? userData.sugars,
                items: sugars.map((sugar){
                  return DropdownMenuItem(
                    value: sugar,
                    child: Text('$sugar sugars'),
                    );
                }).toList(), 
                onChanged: (val)=>setState(()=> _currentSugars=val)
              ),

              Slider(
                value: (_currentStringth ?? userData.strength).toDouble(),
                activeColor: Colors.green[_currentStringth ?? userData.strength],
                inactiveColor: Colors.red[_currentStringth ?? userData.strength],
                min:100.0,
                max:900.0,
                divisions: 8,
                onChanged: (val)=> setState(()=> _currentStringth=val.round()),
              ),
              //slider

              RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Update',
                  style: TextStyle(color: Colors.white),

                ),
                onPressed: () async{
                  if(_formKey.currentState.validate()){
                    await DatabaseService(uid: user.uid).updateUserData(
                    _currentSugars ?? userData.sugars,
                    _currentName ?? userData.name,
                    _currentStringth ?? userData.strength
                      ); 
                      Navigator.pop(context);
                  }

                 print(_currentName);
                 print(_currentSugars);
                 print(_currentStringth);
                }
              ),
              ],
          ),
        );

        }
        else{
          return Loading();
        }
       
      }
    );
  }
}