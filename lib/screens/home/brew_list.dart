import 'package:auth/models/brew.dart';
import 'package:auth/screens/home/brew_tile.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class BrewList extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<BrewList> {
  @override
  Widget build(BuildContext context) { 
    final brews =Provider.of<List<Brew>>(context) ?? [];
   return ListView.builder(
     itemCount: brews.length,
     itemBuilder:(context,index){

    return BrewTile(brew: brews[index]);
     },
    );
  }
}