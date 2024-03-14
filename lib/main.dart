import 'package:flutter/material.dart';
import 'package:sudoku_solver/pages/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
const MyApp({Key? key}) : super(key: key);
@override
Widget build(BuildContext context) {
return MaterialApp(
title: 'Sudoku Solver',
theme: ThemeData(
  primaryColor: Colors.blue ,
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch:  Colors.blue , // Imposta il colore principale per tutti i widget
    backgroundColor: Color.fromARGB(255, 1, 26, 149), // Imposta il colore di sfondo per tutti i widget
    
  ),
),
home: const Splash(),
);
}//build
}//MyApp


