

import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:path_provider/path_provider.dart';
import 'package:practica_uno/http_handler.dart';
import 'package:practica_uno/song.dart';
import 'package:practica_uno/utils/secrets.dart';
import 'package:record/record.dart';
import 'package:http/http.dart' as http;


class SongProvider with ChangeNotifier {

  HttpHandler httpHandler = HttpHandler();
  List<Song> favoriteSongsList = [];

  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;  

  String url = "https://api.audd.io/";  
  final record = Record();

  bool listeningAnimation = false;
  bool isCurrentSongFavorite = false;
  bool isLoading = false;


  Future googleLogin() async {
    try
    {final googleUser = await googleSignIn.signIn();

    if(googleUser == null) 
      return; 

    _user = googleUser;

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.idToken,
      idToken: googleAuth.idToken
    );


    notifyListeners();
    await FirebaseAuth.instance.signInWithCredential(credential);}
    catch(e) {
      print(e);
    }
  }

  Future googleLogout() async {

    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();

  }



  void turnOnListeningAnimation() {
    listeningAnimation = true;
    notifyListeners();
  }

  void turnOffListeningAnimation() {
    listeningAnimation = false;
    notifyListeners();
  }

  Future<bool> checkIfSongInFavorites(Song song) async
  {
    var currentUser = FirebaseFirestore.instance.collection("users").doc(
      FirebaseAuth.instance.currentUser!.uid
    );

    QuerySnapshot<Map<String, dynamic>> q = await currentUser.collection("songs").get();


    for(var s in q.docs)
    {
      if(s["title"] == song.title && s["artist"] == song.artist) {
        return true;
      }
    }

    return false;
  }

  // bool checkIfSongInFavorites(Song song)
  // {
  //   Song currentSong;

  //   for(int i = 0; i < favoriteSongsList.length; i++)
  //   {
  //     currentSong = favoriteSongsList[i];
  //     if(currentSong.title == song.title && currentSong.artist == song.artist) {
  //       return true;
  //     }
  //   }

  //   return false;
  // }

  // void addSongToFavorites(Song song)
  // {
    
  //   favoriteSongsList.add(song);
  //   isCurrentSongFavorite = true;

  //   notifyListeners();    
  // }  

  void addSongToFavorites(Song song) async
  {
    var currentUser = FirebaseFirestore.instance.collection("users").doc(
      FirebaseAuth.instance.currentUser!.uid
    );

    print(song.toJson());
    await currentUser.collection("songs").add(song.toJson());
    isCurrentSongFavorite = true;

    getFavoriteSongs();

    favoriteSongsList.add(song);
    notifyListeners();    
  }

  void removeSongFromFavorites(Song song) async
  {
    var currentUser = FirebaseFirestore.instance.collection("users").doc(
      FirebaseAuth.instance.currentUser!.uid
    );

    QuerySnapshot<Map<String, dynamic>> q = await currentUser.collection("songs").get();


    for(var s in q.docs)
    {
      if(s["title"] == song.title && s["artist"] == song.artist) {
        await s.reference.delete();
      }
    }

    getFavoriteSongs(); 

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

    notifyListeners();
  }

  // void removeSongFromFavorites(Song song) {
  //   Song currentSong;

  //   for(int i = 0; i < favoriteSongsList.length; i++)
  //   {
  //     currentSong = favoriteSongsList[i];
  //     if(currentSong.title == song.title && currentSong.artist == song.artist) {
  //       favoriteSongsList.removeAt(i);
  //       isCurrentSongFavorite = false;
  //       notifyListeners();
  //       return;
  //     }
  //   }

  //   isCurrentSongFavorite = false;
  //   notifyListeners();
  // }

  void getFavoriteSongs() async
  {
    List<Song> favoriteSongs = [];
    
    var currentUser = FirebaseFirestore.instance.collection("users").doc(
      FirebaseAuth.instance.currentUser!.uid
    );

    QuerySnapshot<Map<String, dynamic>> q = await currentUser.collection("songs").get();


    for(var s in q.docs)
    {
      favoriteSongs.add(
        Song(
          title: s["title"],
          album: s["album"],
          artist: s["artist"],
          date: s["date"],
          imageURL: s["imageURL"],
          appleMusicURL: s["appleMusicURL"],
          spotifyURL: s["spotifyURL"],
          generalURL: s["generalURL"]
          ,
        )
      );
    }

    favoriteSongsList = favoriteSongs;

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
      isCurrentSongFavorite = await checkIfSongInFavorites(finalSong);
      turnOffListeningAnimation();
      return finalSong;
    
    }
    
    turnOffListeningAnimation();
    throw Exception("No permission to record");

  }

}