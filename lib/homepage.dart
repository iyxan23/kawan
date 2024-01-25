import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200,
              pinned: true,
              backgroundColor: Theme.of(context).primaryColor,
              flexibleSpace: const FlexibleSpaceBar(
                title: Text("Kawan"),
              ),
            )
          ];
        },
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              BalanceWidget(),
              SizedBox(height: 16),
              HomePageCard(
                title: "Pengeluaran hari ini",
                amount: "Rp. 100.000,-",
              ),
              SizedBox(height: 8),
              HomePageCard(
                title: "Pengeluaran minggu ini",
                amount: "Rp. 100.000,-",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePageCard extends StatelessWidget {
  final String title;
  final String amount;

  const HomePageCard({super.key, required this.title, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black.withAlpha(30)),
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title),
          const Spacer(),
          Text(
            amount,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class BalanceWidget extends StatelessWidget {
  const BalanceWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: ShapeDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
      ),
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
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                        .merge(Theme.of(context).textTheme.headlineSmall),
              )
            ],
          ),
          const Spacer(),
          BalanceAction(
            onTap: () => Navigator.of(context).pushNamed("/kirim"),
            icon: Icons.send,
            title: 'Kirim',
          ),
          const SizedBox(width: 20),
          BalanceAction(
            onTap: () => Navigator.of(context).pushNamed("/topup"),
            icon: Icons.open_in_browser,
            title: 'Top Up',
          ),
        ],
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
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon),
          Text(title),
        ],
      ),
    );
  }
}
