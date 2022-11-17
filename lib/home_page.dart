import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:practica_uno/circle_button.dart';
import 'package:practica_uno/link_button.dart';
import 'package:practica_uno/listen_button.dart';
import 'package:practica_uno/song_provider.dart';
import 'package:provider/provider.dart';


class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Track App'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [Text(context.watch<SongProvider>().listeningAnimation? "Listening..." : "Press the button to start listening!", 
              style: Theme.of(context).textTheme.subtitle1,),
            ],),
          Row(children: [
            Expanded(child: ListenButton())
          ], mainAxisAlignment: MainAxisAlignment.center,),
          Row(children: [
            SizedBox(width: 80,),
            CircleButton(currentIcon: Icon(Icons.favorite), message: "See your favorite songs",),
            Tooltip(
              message: "Log out",
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Theme.of(context).colorScheme.secondary,
                child: IconButton(icon: Icon(Icons.logout), onPressed: (() {
                  context.read<SongProvider>().googleLogout();
                }),),
              ),
            ),
            
            SizedBox(width: 80,),
          ], mainAxisAlignment: MainAxisAlignment.spaceEvenly,)
        ],),
      )
    );
  }
}