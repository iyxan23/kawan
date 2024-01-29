import 'package:flutter/material.dart';

class BalanceWidget extends StatelessWidget {
  final List<Widget> Function(BuildContext) createActions;
  final double elevation;

  const BalanceWidget(
      {super.key, required this.createActions, this.elevation = 2});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "balance",
      child: Card(
        elevation: elevation,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "SALDO",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  Text(
                    "Rp. 1,500,000,-",
                    style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)
                        .merge(Theme.of(context).textTheme.headlineSmall),
                  )
                ],
              ),
              const Spacer(),
              ...createActions(context)
            ],
          ),
        ),
      ),
    );
  }
}

class BalanceAction extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final IconData icon;

  const BalanceAction(
      {super.key,
      required this.title,
      required this.onTap,
      required this.icon});
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      shadowColor: Colors.black.withAlpha(50),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Column(
            children: [
              Icon(icon),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }
}
