import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ronkhlab_agro/authantification/seconnnecter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RonkhLab_Agro',
      theme: ThemeData(primaryColor: Color(0xFF128023)),
      home: const LoginScreen(),
    );
  }
}
