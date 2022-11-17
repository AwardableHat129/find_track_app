
import 'package:flutter/material.dart';
import 'package:practica_uno/favorites_page.dart';
import 'package:practica_uno/song.dart';
import 'package:practica_uno/song_provider.dart';
import 'package:provider/provider.dart';

class CircleButton extends StatelessWidget {
  final Icon currentIcon;
  final String message;
  
  CircleButton({Key? key, required this.currentIcon, required this.message}) : super(key: key);
  
  
  @override
  Widget build(BuildContext context) {
    
    return Tooltip(
      message: message,
      child: CircleAvatar(
        radius: 20,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: IconButton(icon: currentIcon, onPressed: (() async {
            try {
            Navigator.push(context, MaterialPageRoute(builder: (context) => FavoritesPage(),));

            } catch(e) {
              print(e);
            }
        }),),
      ),
    );
  }
}