

import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:practica_uno/http_handler.dart';
import 'package:practica_uno/song.dart';
import 'package:practica_uno/utils/secrets.dart';
import 'package:record/record.dart';
import 'package:http/http.dart' as http;


class SongProvider with ChangeNotifier {

  HttpHandler httpHandler = HttpHandler();
  List favoriteSongsList = [];

  String url = "https://api.audd.io/";  
  final record = Record();

  bool listeningAnimation = false;
  bool isCurrentSongFavorite = false;

  void turnOnListeningAnimation() {
    listeningAnimation = true;
    notifyListeners();
  }

  void turnOffListeningAnimation() {
    listeningAnimation = false;
    notifyListeners();
  }

  bool checkIfSongInFavorites(Song song)
  {
    Song currentSong;

    for(int i = 0; i < favoriteSongsList.length; i++)
    {
      currentSong = favoriteSongsList[i];
      if(currentSong.title == song.title && currentSong.artist == song.artist) {
        return true;
      }
    }

    return false;
  }

  void addSongToFavorites(Song song)
  {
    favoriteSongsList.add(song);
    isCurrentSongFavorite = true;

    notifyListeners();    
  }  

  void removeSongFromFavorites(Song song) {
    Song currentSong;

    for(int i = 0; i < favoriteSongsList.length; i++)
    {
      currentSong = favoriteSongsList[i];
      if(currentSong.title == song.title && currentSong.artist == song.artist) {
        favoriteSongsList.removeAt(i);
        isCurrentSongFavorite = false;
        notifyListeners();
        return;
      }
    }

    isCurrentSongFavorite = false;
    notifyListeners();
  }

  

  Future<Song> recordSong() async {
    turnOnListeningAnimation();
    
    Directory? audioPath = await getExternalStorageDirectory();
    print(audioPath);

    if(await record.hasPermission()) {
           
      print('${audioPath?.path}/${DateTime.now().millisecondsSinceEpoch}.m4a');
      await record.start(
        path: '${audioPath?.path}/${DateTime.now().millisecondsSinceEpoch}.m4a',
        encoder: AudioEncoder.aacLc,
        bitRate: 128000,
        samplingRate: 44100,
      );

      bool currentlyRecording = await(record.isRecording());
      if(currentlyRecording) {
        await Future.delayed(Duration(seconds: 7));
      }

      final audioFilePath = await record.stop();
      String audioFileString = base64Encode(File(audioFilePath!).readAsBytesSync());   
    
      Song finalSong = await httpHandler.findSong(audioFileString);
      isCurrentSongFavorite = checkIfSongInFavorites(finalSong);
      turnOffListeningAnimation();
      return finalSong;
    
    }
    
    turnOffListeningAnimation();
    throw Exception("No permission to record");

  }








}