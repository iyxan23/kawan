import 'package:flutter/material.dart';

class SendPage extends StatelessWidget {
  const SendPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kirim")),
      body: Center(
          child: ElevatedButton(
        onPressed: () {},
        child: const Text("Kirim"),
      )),
    );
  }
}
