import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'repository/mutations.dart';
import 'homepage.dart';
import 'sendpage.dart';
import 'topuppage.dart';

class App extends StatelessWidget {
  final MutationsRepository mutationsRepository;

  const App({super.key, required this.mutationsRepository});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: mutationsRepository,
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({
    super.key,
  });

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
