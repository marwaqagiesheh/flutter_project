import 'package:flutter/material.dart';
import 'package:medical_care_project/provider.dart';
import 'package:provider/provider.dart';
import 'pages/main_page.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: ((context) => ReminderProvider()), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage(title: "Today"),
    );
  }
}
