import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:practica_uno/song_page.dart';
import 'package:practica_uno/song.dart';
import 'package:practica_uno/song_provider.dart';
import 'package:provider/provider.dart';

class ListenButton extends StatelessWidget {
  const ListenButton({super.key});

  @override
  Widget build(BuildContext context) {
    

    return AvatarGlow(
      glowColor: Theme.of(context).colorScheme.secondary,
      duration: Duration(milliseconds: 2000),
      repeat: true,            
      showTwoGlows: true,
      repeatPauseDuration: Duration(milliseconds: 50),
      animate: context.watch<SongProvider>().listeningAnimation,
      
      child: ElevatedButton(
        child: Icon(CupertinoIcons.waveform, color: Theme.of(context).colorScheme.primary, size: 120,),
        onPressed: () async {
          
            try {
              Song song =  await context.read<SongProvider>().recordSong();
              Navigator.push(context, MaterialPageRoute(builder: (context) => SongPage(currentSong: song,),));
            } catch(error) {
              context.read<SongProvider>().turnOffListeningAnimation();
              var snackError = SnackBar(
                content: Text(error.toString(), style: TextStyle(color: Colors.white),),
                backgroundColor: Theme.of(context).colorScheme.error,                
              );
              ScaffoldMessenger.of(context).showSnackBar(snackError);
            }
                    
                       
        },
        
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(200, 200),
          shape: const CircleBorder(),          
          primary: Theme.of(context).colorScheme.secondary
        ),
      ),
    
    endRadius: 190.0);
  }
}