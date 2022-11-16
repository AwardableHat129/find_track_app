import 'package:flutter/material.dart';
import 'package:practica_uno/favorite_button.dart';
import 'package:practica_uno/link_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:practica_uno/song.dart';
import 'package:practica_uno/song_provider.dart';
import 'package:provider/provider.dart';



class SongPage extends StatelessWidget {
  final Song currentSong;
  

  const SongPage({    
    Key? key,
    required this.currentSong,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Song Displayer'),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          favoriteButton(currentSong: currentSong, isFavoritePage: false,)
        ],        
      ),
      body: Column(children: [
        Image.network(currentSong.imageURL),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 2),
          child: Text(currentSong.title, style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis)),
        ),
        Text(currentSong.album, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),),
        Padding(
          padding: const EdgeInsets.only(top: 6, bottom: 2),
          child: Text(currentSong.artist, style: TextStyle(fontSize: 18, color: Colors.grey, overflow: TextOverflow.ellipsis)),
        ),
        Text(currentSong.date, style: TextStyle(fontSize: 18, color: Colors.grey)),
        SizedBox(height: 10,),        
        Text("Open with:"),
        Expanded(child: Row(children: [
          LinkButton(currentIcon: FaIcon(FontAwesomeIcons.spotify), name: "Spotify", url: currentSong.spotifyURL,),
          LinkButton(currentIcon: FaIcon(FontAwesomeIcons.podcast), name: "ListTN", url: currentSong.generalURL,),
          LinkButton(currentIcon: FaIcon(FontAwesomeIcons.itunes), name: "iTunes", url: currentSong.appleMusicURL,)
        ], mainAxisAlignment: MainAxisAlignment.spaceEvenly,)
        ,)


      ],) 
    );
  }
}



