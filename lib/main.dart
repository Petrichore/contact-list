import 'package:flutter/material.dart';

import 'contacts_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contacts List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ContactsList(),
    );
  }
}