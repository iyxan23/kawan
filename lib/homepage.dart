import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              leading: Padding(
                padding: const EdgeInsets.all(4.0),
                child: SvgPicture.asset(
                  "assets/img/iconplain-duotone.svg",
                ),
              ),
              leadingWidth: 72,
              automaticallyImplyLeading: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              expandedHeight: 200,
              pinned: true,
              backgroundColor: Theme.of(context).primaryColor,
              flexibleSpace: FlexibleSpaceBar(
                title: Transform.translate(
                  offset: const Offset(0, 3),
                  child: SvgPicture.asset(
                    "assets/img/textplain-duotone.svg",
                    width: 80,
                  ),
                ),
                background: Image.asset(
                  "assets/img/bg.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            )
          ];
        },
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const BalanceWidget(),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Card(
                      elevation: 0,
                      color: Theme.of(context).colorScheme.surfaceVariant,
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Hari ini"),
                            Text(
                              "Rp. 100,000,-",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Card(
                      elevation: 0,
                      color: Theme.of(context).colorScheme.surfaceVariant,
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Minggu ini"),
                            Text(
                              "Rp. 100,000,-",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 24),
              const InvoicesSection()
            ],
          ),
        ),
      ),
    );
  }
}

class InvoicesSection extends StatelessWidget {
  const InvoicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Mutasi",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 12),
        const InvoiceCard(
          price: "Rp. 12,000,-",
          mutationType: MutationType.deduction,
          description: "Beli Kopi",
        ),
        const InvoiceCard(
          price: "Rp. 500,000,-",
          mutationType: MutationType.addition,
          description: "Dari emak",
        ),
        const InvoiceCard(
          price: "Rp. 17,500,-",
          mutationType: MutationType.deduction,
          description: "Belanja Mie",
        ),
        const InvoiceCard(
          price: "Rp. 100,000,-",
          mutationType: MutationType.deduction,
          description: "Bayar Kos",
        ),
        const InvoiceCard(
          price: "Rp. 700,000,-",
          mutationType: MutationType.addition,
          description: "Gaji part time",
        ),
      ],
    );
  }
}

enum MutationType {
  addition,
  deduction,
}

class InvoiceCard extends StatelessWidget {
  final String price;
  final MutationType mutationType;
  final String description;

  const InvoiceCard(
      {super.key,
      required this.price,
      required this.mutationType,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {},
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        mutationType == MutationType.addition
                            ? Icons.add
                            : Icons.remove,
                        color: mutationType == MutationType.addition
                            ? Colors.green
                            : Colors.red,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        price,
                        style: TextStyle(
                          color: mutationType == MutationType.addition
                              ? Colors.green
                              : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        "Bulan lalu",
                        style: TextStyle(color: Colors.black45),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(description),
                ],
              )),
              Container(
                padding: const EdgeInsets.only(left: 16),
                child: const Icon(
                  Icons.chevron_right,
                  color: Colors.black45,
                  size: 24,
                ),
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
    return const Card();
    ;
  }
}

class BalanceWidget extends StatelessWidget {
  const BalanceWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
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
                  style:
                      const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                          .merge(Theme.of(context).textTheme.headlineSmall),
                )
              ],
            ),
            const Spacer(),
            IconButton(
              onPressed: () => Navigator.of(context).pushNamed("/topup"),
              icon: const Icon(Icons.add_circle),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: () => Navigator.of(context).pushNamed("/kirim"),
              icon: const Icon(Icons.send),
            ),
          ],
        ),
      ),
    );
    // return Container(
    //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    //   decoration: ShapeDecoration(
    //     color: Theme.of(context).colorScheme.primaryContainer,
    //     shape: const RoundedRectangleBorder(
    //       borderRadius: BorderRadius.all(
    //         Radius.circular(8),
    //       ),
    //     ),
    //   ),
    //   child: Row,
    // );
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
