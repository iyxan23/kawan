import 'package:flutter/material.dart';

class TopUpPage extends StatelessWidget {
  const TopUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Top Up")),
      body: Center(
          child: ElevatedButton(
        onPressed: () {},
        child: const Text("Top up"),
      )),
    );
  }
}