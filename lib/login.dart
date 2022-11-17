import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:practica_uno/song_provider.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {

    if(context.watch<SongProvider>().isLoading) {
      return Center(child: CircularProgressIndicator());
    } 

    return Material(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/equalizer.gif'),
            fit: BoxFit.cover
          ),
        
        ),
        child: Column(children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(image: AssetImage('assets/images/music.png'), width: 200, height: 200,),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Find Track App", style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35, 
                color: Theme.of(context).colorScheme.secondary
    
                ),),
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(onPressed: () {
                  try {
                    context.read<SongProvider>().googleLogin();
                  } catch(e) {
                    print(e.toString());
                  }
                }, icon: FaIcon(FontAwesomeIcons.google, color: Colors.white,),
                label: Text("Sign in with Google", style: TextStyle(color: Colors.white),))
            ]),
          )
        ]),
      ),
    );
  }
}