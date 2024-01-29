import 'package:flutter/material.dart';

class Numpad extends StatelessWidget {
  final void Function(NumpadAction action) onTap;

  const Numpad({super.key, required this.onTap});

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
          ...(createButtons(onTap).map((e) {
            return ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                ),
              ),
              onPressed: e.$2,
              child: e.$1,
            );
          })),
        ],
      ),
    );
  }
}

List<(Widget, VoidCallback)> createButtons(Function(NumpadAction) onTap) {
  return [
    ...(List.generate(9, (i) => (i + 1, NumpadAction.values[i]))).map(
      (e) => (
        Text(
          e.$1.toString(),
          style: const TextStyle(fontSize: 24),
        ),
        () => onTap(e.$2)
      ),
    ),
    (
      const Text("000", style: TextStyle(fontSize: 20)),
      () => onTap(NumpadAction.tripleZero)
    ),
    (
      const Text("0", style: TextStyle(fontSize: 24)),
      () => onTap(NumpadAction.numberZero)
    ),
    (const Icon(Icons.arrow_back), () => onTap(NumpadAction.backspace))
  ];
}

enum NumpadAction {
  numberOne,
  numberTwo,
  numberThree,
  numberFour,
  numberFive,
  numberSix,
  numberSeven,
  numberEight,
  numberNine,
  numberZero,
  tripleZero,
  backspace,
}
