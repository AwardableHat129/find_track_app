import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:practica_uno/song.dart';
import 'package:practica_uno/utils/secrets.dart';

class HttpHandler {


  final String url = "https://api.audd.io/";
  final String APIToken = privateAPItoken;

  HttpHandler._internal();
  static final HttpHandler _httpHandler = HttpHandler._internal();  

  factory HttpHandler() {
    return _httpHandler;
  }

  Future<Song> findSong(String audioFileString) async {
    
    Map<String, dynamic> requestBody = {
        "api_token": this.APIToken,
        "audio": "$audioFileString",
        "return": "apple_music,spotify,deezer",
        "method": "recognize"
      };

    print(requestBody);

    var requestStatus = await http.post(
      Uri.parse(this.url),
      body: json.encode(requestBody)
    );

    print(requestStatus.body);

    if(requestStatus.statusCode == 200)
    {        
      Map<String, dynamic> songJson = jsonDecode(requestStatus.body);

      if(songJson["result"] == null) {
        throw Exception("The API couldn't find the song");
      }    

      return Song.fromJson(songJson);
    }
    
    throw Exception("Something went wrong");

    }  
  

}