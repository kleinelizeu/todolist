import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/app/providers/todo_provider.dart';
import 'package:todolist/app/screens/home_screen.dart';

import 'app/screens/todoform_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TodoProvider(),
      child: MaterialApp(
        initialRoute: '/',
        title: 'Flutter Demo',
        routes: {
          '/': (context) => HomeScreen(),
          '/entry': (context) => TodoForm(),
        },
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      ),
    );
  }
}
