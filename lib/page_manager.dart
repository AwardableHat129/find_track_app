

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practica_uno/home_page.dart';
import 'package:practica_uno/login.dart';

class PageManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(

        body: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {

                return Center(child: CircularProgressIndicator());

              } else if (snapshot.hasData) {

                return HomePage();
              
              } else if (snapshot.hasError) {

                return Center(
                  child: Text("Error: Something went wrong while logging in. Please try again."),
                );

              } else {

                return Login();

              }
        }
      )
    );
  }

}