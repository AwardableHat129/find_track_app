
import 'package:flutter/material.dart';
import 'package:practica_uno/favorites_page.dart';

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
        child: IconButton(icon: currentIcon, onPressed: (() {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const FavoritesPage(),));
        }),),
      ),
    );
  }
}