import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:practica_uno/home_page.dart';
import 'package:practica_uno/login.dart';
import 'package:practica_uno/page_manager.dart';
import 'package:practica_uno/song_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      ChangeNotifierProvider<SongProvider>(
        create: (context) => SongProvider(),
        child: MyApp(),
      ),
    );
  }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FindTrackApp',
      home: PageManager(),
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.purple,
        colorScheme: ColorScheme(brightness: Brightness.dark, 
          primary: Colors.purple, 
          onPrimary: Colors.purple, 
          secondary: Colors.white, 
          onSecondary: Colors.white, 
          error: Colors.red,          
          onError: Colors.orange, 
          background: Colors.black, 
          onBackground: Colors.black, 
          surface: Colors.white, 
          onSurface: Colors.white)
        
      ),
      
    );
  }
}

