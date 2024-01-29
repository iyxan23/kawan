import 'package:flutter/material.dart';
import 'package:kawan/widgets/balance.dart';

import 'widgets/blinking_cursor.dart';

class TopUpPage extends StatelessWidget {
  const TopUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          const SliverAppBar.medium(
            title: Text("Top Up"),
            pinned: true,
          ),
        ],
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Column(
                children: [
                  const TopUpNominal(),
                  const SizedBox(height: 8),
                  const Text("Topup ke"),
                  const SizedBox(height: 8),
                  BalanceWidget(
                    createActions: (context) => [],
                    elevation: 1,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Expanded(child: Numpad()),
              FilledButton(
                onPressed: () {},
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TopUpNominal extends StatelessWidget {
  const TopUpNominal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "NOMINAL TOP-UP",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                Row(
                  // crossAxisAlignment:
                  //     CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Rp. ",
                      style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)
                          .merge(Theme.of(context).textTheme.headlineSmall),
                    ),
                    const BlinkingCursor()
                  ],
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class Numpad extends StatelessWidget {
  const Numpad({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle.merge(
      style: Theme.of(context)
          .textTheme
          .bodyMedium!
          .merge(const TextStyle(fontSize: 24)),
      child: GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 3 / 2,
        children: [
          ...[
            ...[1, 2, 3, 4, 5, 6, 7, 8, 9].map(
              (e) => Text(
                e.toString(),
                style: const TextStyle(fontSize: 24),
              ),
            ),
            const Text("000", style: TextStyle(fontSize: 20)),
            const Text("0", style: TextStyle(fontSize: 24)),
            const Icon(Icons.arrow_back)
          ].map((e) {
            return ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                ),
              ),
              onPressed: () {},
              child: e,
            );
          }),
        ],
      ),
    );
  }
}
