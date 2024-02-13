import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kawan/bloc/mutations/mutations_bloc.dart';
import 'package:kawan/bloc/mutations/mutations_state.dart';
import 'package:kawan/models/mutations.dart';
import 'package:kawan/utils.dart';
import 'package:kawan/widgets/balance.dart';
import 'package:relative_time/relative_time.dart';

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
              BalanceWidget(
                createActions: (context) => [
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
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: BlocBuilder<MutationsBloc, MutationsState>(
                      builder: (context, state) {
                        return BalanceGlanceCard(
                          title: "Hari ini",
                          value: state.balanceDailyAggregate != null
                              ? "Rp. ${formatIDR(state.balanceDailyAggregate!)},-"
                              : "Loading",
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: BlocBuilder<MutationsBloc, MutationsState>(
                      builder: (context, state) {
                        return BalanceGlanceCard(
                          title: "Minggu ini",
                          value: state.balanceWeeklyAggregate != null
                              ? "Rp. ${formatIDR(state.balanceWeeklyAggregate!)},-"
                              : "Loading",
                        );
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(height: 24),
              const MutationsSection()
            ],
          ),
        ),
      ),
    );
  }
}

class BalanceGlanceCard extends StatelessWidget {
  final String title;
  final String value;

  const BalanceGlanceCard(
      {super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title),
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class MutationsSection extends StatelessWidget {
  const MutationsSection({super.key});

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
        const MutationCards(),
      ],
    );
  }
}

class MutationCards extends StatelessWidget {
  const MutationCards({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MutationsBloc, MutationsState>(
        builder: (context, state) {
      return Column(
        children: [
          ...state.mutations.map((mutation) {
            return MutationCard(
              price: "Rp. ${formatIDR(mutation.amount)},-",
              mutationType: mutation.mutationType,
              description: mutation.description,
              date: mutation.created,
            );
          })
        ],
      );
    });
  }
}

class MutationCard extends StatelessWidget {
  final String price;
  final MutationType mutationType;
  final String description;
  final DateTime date;

  const MutationCard(
      {super.key,
      required this.price,
      required this.mutationType,
      required this.description,
      required this.date});

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
                      Text(
                        RelativeTime(context).format(date),
                        style: const TextStyle(color: Colors.black45),
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
