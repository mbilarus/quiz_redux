import 'package:flutter/material.dart';
import 'package:quiz_redux/src/screens.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Опросник',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SelectModeScreen(),
    );
  }
}