import 'package:flutter/material.dart';
import 'package:practica_uno/favorite.dart';
import 'package:practica_uno/song.dart';
import 'package:practica_uno/song_provider.dart';
import 'package:provider/provider.dart';


class FavoritesPage extends StatelessWidget {
  const FavoritesPage({
    Key? key,
    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    List songList = context.watch<SongProvider>().favoriteSongsList;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Favorites'),
        backgroundColor: Theme.of(context).primaryColor,        
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(children: [
          FavoriteArea(context, songList)
        ],),
      )
    );
  }

  Widget FavoriteArea(BuildContext context, List songList) {    
    return Container(
      margin: EdgeInsets.all(15.0),
      height: MediaQuery.of(context).size.height * (9 / 12),
      child: FavoritesList(songList),
    );
  }

  Widget FavoritesList(List songList) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: songList.length,
      itemBuilder: (BuildContext, int index) {
        return Favorite(currentSong: songList[index],);
      });
  }
}

