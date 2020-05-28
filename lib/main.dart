import 'package:chat_app/screens/auth_screen.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
final primaryColor = Colors.pink;
final accentColor = Colors.purple;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chat',
      theme: ThemeData(
        primarySwatch: primaryColor,
        backgroundColor: primaryColor,
        accentColor: accentColor,
        accentColorBrightness: Brightness.dark,
        buttonTheme: ButtonTheme.of(context).copyWith(
            buttonColor: primaryColor,
            textTheme: ButtonTextTheme.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0))),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (ctx, userSnapshot){
          if(userSnapshot.hasData){
            return ChatScreen();
          }else{
            return AuthScreen();
          }
        } ,
      ),
    );
  }
}
 