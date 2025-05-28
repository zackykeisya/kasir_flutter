import 'package:flutter/material.dart';
import 'views/get_started_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ticketing App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Inter',
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: GetStartedPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}