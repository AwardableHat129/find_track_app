import 'package:flutter/material.dart';
import 'package:practica_uno/song_provider.dart';
import 'package:provider/provider.dart';

import 'song.dart';

class favoriteButton extends StatelessWidget {
  const favoriteButton({
    Key? key,
    required this.currentSong,
    required this.isFavoritePage,
  }) : super(key: key);

  final Song currentSong;
  final bool isFavoritePage;
  

  @override
  Widget build(BuildContext context) {

    Future<void> showRemovalConfirmationDialog() async {
    return showDialog(barrierDismissible: false, context: context, builder: ((context) {
      return AlertDialog(
        title: Text("Remove from favorites"),
        content: Text("Are you sure you want to remove this element from your favorites list?"),
        actions: [
          ElevatedButton(onPressed: (){

          var snackRemove = SnackBar(
                      content: Text("Removed song from favorites"),
                      backgroundColor: Theme.of(context).colorScheme.secondary);
            context.read<SongProvider>().removeSongFromFavorites(currentSong);
            ScaffoldMessenger.of(context).showSnackBar(snackRemove);
            Navigator.of(context).pop();

          }, child: Text("Yes, remove it", style: TextStyle(color: Colors.white),), ),
          ElevatedButton(onPressed: (){

            Navigator.of(context).pop();

          }, child: Text("Cancel", style: TextStyle(color: Colors.white),))
        ],
      );
    }));
  }

  Future<void> showAddingConfirmationDialog() async {
    return showDialog(barrierDismissible: false, context: context, builder: ((context) {
      return AlertDialog(
        title: Text("Add to favorites"),
        content: Text("Are you sure you want to add this element to your favorites list?"),
        actions: [
          ElevatedButton(onPressed: (){

            context.read<SongProvider>().addSongToFavorites(currentSong);
            var snackAdd = SnackBar(
                          content: Text("Added song to favorites"),
                          backgroundColor: Theme.of(context).colorScheme.secondary);
            ScaffoldMessenger.of(context).showSnackBar(snackAdd);
            Navigator.of(context).pop();

          }, child: Text("Yes, add it", style: TextStyle(color: Colors.white),), ),
          ElevatedButton(onPressed: (){

            Navigator.of(context).pop();

          }, child: Text("Cancel", style: TextStyle(color: Colors.white),))
        ],
      );
    }));
  }

    
    return IconButton(onPressed: (){
        if(context.read<SongProvider>().isCurrentSongFavorite || isFavoritePage) {
          
          showRemovalConfirmationDialog();          

        } else {
          
          showAddingConfirmationDialog();

        }
    }, icon: Icon(Icons.favorite, 
    color: context.watch<SongProvider>().isCurrentSongFavorite || isFavoritePage? Colors.white :Colors.black),);
  }

  

}
