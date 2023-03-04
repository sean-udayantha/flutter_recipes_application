import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_recipes_application/Providers/AuthProvider.dart';
// import 'package:sliittodolistapp/Providers/TodoProvider.dart';
import 'package:flutter_recipes_application/Screens/LoginScreen.dart';
// import 'package:sliittodolistapp/Screens/TodoListScreen.dart';
// import 'package:sliittodolistapp/Todo.dart';
// import 'package:sliittodolistapp/TodoItem.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasData) {
          return ChangeNotifierProvider(
            create: (_) => AuthProvider(),
            child: const MaterialApp(
              title: 'recipes App',
              home: LoginScreen(),
            ),
          );
        } else {
          return const MaterialApp(
            title: 'recipes App',
            home: LoginScreen(),
          );
        }
      },
    );
  }
}
