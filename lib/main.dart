import 'package:flutter/material.dart';
import 'package:postman/screens/auth_screen.dart';
import 'package:postman/screens/chat_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Postman',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        backgroundColor: Colors.cyan,
        accentColor: Colors.limeAccent,
        accentColorBrightness: Brightness.light,
        buttonTheme: ButtonTheme.of(context).copyWith(
            buttonColor: Colors.cyan,
            textTheme: ButtonTextTheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            )),
      ),
      home: AuthScreen(),
    );
  }
}
