import 'package:flutter/material.dart';
import 'package:kawan/homepage.dart';
import 'package:kawan/sendpage.dart';
import 'package:kawan/topuppage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kawan',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 98, 20, 223),
        ),
        useMaterial3: true,
      ),
      routes: {
        "/": (ctx) => const HomePage(),
        "/kirim": (ctx) => const SendPage(),
        "/topup": (ctx) => const TopUpPage(),
      },
    );
  }
}
