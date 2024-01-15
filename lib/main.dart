import 'package:flutter/material.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text(
              "Kawan",
              textAlign: TextAlign.center,
            ),
          ),
          body: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: ShapeDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)))),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("SALDO",
                              style: Theme.of(context).textTheme.labelSmall),
                          Text(
                            "Rp. 1,500,000,-",
                            style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)
                                .merge(
                                    Theme.of(context).textTheme.headlineSmall),
                          )
                        ],
                      ),
                      const Spacer(),
                      const BalanceAction(
                        showText: "Mengirim",
                        icon: Icons.send,
                        title: 'Kirim',
                      ),
                      const SizedBox(width: 20),
                      const BalanceAction(
                        showText: "Topping up",
                        icon: Icons.open_in_browser,
                        title: 'Top Up',
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}

class BalanceAction extends StatelessWidget {
  final String title;
  final String showText;
  final IconData icon;

  const BalanceAction(
      {super.key,
      required this.title,
      required this.showText,
      required this.icon});
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(showText),
          ));
        },
        child: Column(children: [Icon(icon), Text(title)]));
  }
}
