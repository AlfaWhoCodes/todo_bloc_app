// by alfawhocodes
// follow on instagram/alfawhocodes

import 'package:flutter/material.dart';
import 'package:todo_bloc_app/task_screen.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase

void main() async {
  // Ensure Firebase is initialized before running the app
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp();

    print('Firebase initialization Success: ');
  } catch (e) {
    // Handle initialization error if necessary
    print('Firebase initialization error: $e');
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TaskScreen(),
    );
  }
}
