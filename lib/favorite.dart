import 'package:flutter/material.dart';
import 'package:practica_uno/favorite_button.dart';
import 'package:practica_uno/song.dart';
import 'package:practica_uno/song_page.dart';
import 'package:practica_uno/song_provider.dart';
import 'package:provider/provider.dart';

class Favorite extends StatelessWidget {
  Song currentSong;

  Favorite({Key? key, required this.currentSong}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: "See song details",
      child: GestureDetector(
        onTap: () {
          context.read<SongProvider>().isCurrentSongFavorite = true;
          Navigator.push(context, MaterialPageRoute(builder: (context) => SongPage(currentSong: currentSong,),));
        },
        child: Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            width: 325,
            height: 325,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Stack(
                children: [                
                  Positioned.fill(child: Image.network(this.currentSong.imageURL, fit: BoxFit.fill),
                  ),
                  Positioned(top: 0, left: 0,
                    child: favoriteButton(currentSong: currentSong, isFavoritePage: true,)),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.purple.withOpacity(0.8),
                        borderRadius: 
                          BorderRadius.only(topRight: Radius.circular(15), bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15))
                      ),
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        Text(this.currentSong.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0), overflow: TextOverflow.ellipsis,),
                        Text(this.currentSong.artist, overflow: TextOverflow.ellipsis,)
                      ]),
                    ),
                  )
    
                ],
              ),
            ),
          )
      ),
    );
  }
}