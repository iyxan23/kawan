import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kawan/bloc/mutations/mutations_bloc.dart';
import 'package:kawan/bloc/mutations/mutations_events.dart';
import 'package:kawan/repository/mutations.dart';
import 'package:relative_time/relative_time.dart';

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
    return BlocProvider(
      create: (context) => MutationsBloc(
        mutationsRepository: context.read<MutationsRepository>(),
      )
        ..add(const LoadMutations())
        ..add(const LoadAggregate())
        ..add(const LoadDailyAggregate())
        ..add(const LoadWeeklyAggregate()),
      child: MaterialApp(
        localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
          RelativeTimeLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('id'),
        ],
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
      ),
    );
  }
}
