import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kawan/bloc/mutations/mutations_bloc.dart';
import 'package:kawan/bloc/mutations/mutations_events.dart';
import 'package:kawan/utils.dart';
import 'package:kawan/widgets/balance.dart';
import 'package:kawan/widgets/blinking_cursor.dart';
import 'package:kawan/widgets/numpad.dart';

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
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: TopUpInput(),
        ),
      ),
    );
  }
}

class TopUpInput extends StatefulWidget {
  const TopUpInput({
    super.key,
  });

  @override
  State<TopUpInput> createState() => _TopUpInputState();
}

class _TopUpInputState extends State<TopUpInput> {
  int nominal = 0;
  String description = "Dari emak";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            TopUpNominal(nominal: nominal),
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
        Expanded(
          child: TopUpNumpad(
            nominal: nominal,
            updateNominal: (nominal) {
              setState(() {
                this.nominal = nominal;
              });
            },
          ),
        ),
        FilledButton(
          onPressed: onSubmit,
          child: const Text("Submit"),
        ),
      ],
    );
  }

  void onSubmit() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Masukkan deskripsi"),
          content: TextField(
            onChanged: (value) {
              setState(() {
                description = value;
              });
            },
          ),
          actions: [
            TextButton(
              child: const Text("Top Up"),
              onPressed: () {
                final mutationsBloc = context.read<MutationsBloc>();
                mutationsBloc.add(
                  AdditionMutationAdded(
                    nominal: nominal,
                    description: description,
                  ),
                );

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class TopUpNumpad extends StatelessWidget {
  final void Function(int) updateNominal;
  final int nominal;

  const TopUpNumpad({
    super.key,
    required this.nominal,
    required this.updateNominal,
  });

  @override
  Widget build(BuildContext context) {
    return Numpad(
      onTap: (action) {
        switch (action) {
          case NumpadAction.numberOne:
            updateNominal(nominal * 10 + 1);
            break;
          case NumpadAction.numberTwo:
            updateNominal(nominal * 10 + 2);
            break;
          case NumpadAction.numberThree:
            updateNominal(nominal * 10 + 3);
            break;
          case NumpadAction.numberFour:
            updateNominal(nominal * 10 + 4);
            break;
          case NumpadAction.numberFive:
            updateNominal(nominal * 10 + 5);
            break;
          case NumpadAction.numberSix:
            updateNominal(nominal * 10 + 6);
            break;
          case NumpadAction.numberSeven:
            updateNominal(nominal * 10 + 7);
            break;
          case NumpadAction.numberEight:
            updateNominal(nominal * 10 + 8);
            break;
          case NumpadAction.numberNine:
            updateNominal(nominal * 10 + 9);
            break;
          case NumpadAction.numberZero:
            updateNominal(nominal * 10);
            break;
          case NumpadAction.tripleZero:
            updateNominal(nominal * 1000);
            break;
          case NumpadAction.backspace:
            updateNominal(nominal ~/ 10);
            break;
        }
      },
    );
  }
}

class TopUpNominal extends StatelessWidget {
  final int nominal;

  const TopUpNominal({
    super.key,
    required this.nominal,
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
                  children: [
                    Text(
                      "Rp. ${formatIDR(nominal)},-",
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
