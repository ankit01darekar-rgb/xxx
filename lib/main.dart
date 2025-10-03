
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:the_waiter/screens/welcome_screen.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(
    options: const FirebaseOptions(
       apiKey: "AIzaSyDNRq5nRDX7h4BpNGbq-qfcWOQjReuQe3Y",
       authDomain: "the-waiter-10f7a.firebaseapp.com",
       projectId: "the-waiter-10f7a",
       storageBucket: "the-waiter-10f7a.firebasestorage.app",
       messagingSenderId: "38690330541",
       appId: "1:38690330541:web:62d8db12793ad67a163324",
       measurementId: "G-LW1B7JD4X4"));
       }else{
        await Firebase.initializeApp();
       }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: WelcomeScreen(),
    );
  }
}



