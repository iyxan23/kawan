import 'package:kawan/models/mutations.dart';
import 'package:kawan/repository/mutations.dart';
import 'package:kawan/repository/mutations_generator.dart';

const onePage = 10;

class MutationsRam extends MutationsRepository<int> {
  late MutationsDb db;

  MutationsRam({MutationsDb? db}) {
    if (db is MutationsDb) {
      this.db = db;
    } else {
      this.db = MutationsDb(mutations: defaultMutations);
    }
  }

  @override
  Future<int> aggregateBalance() {
    return Future.value(
      db.mutations
          .map((m) => m.amount)
          .reduce((value, element) => value + element),
    );
  }

  @override
  Future<Paged<int, List<Mutation>>> getMutations(cursor) {
    return Future.value(Paged(
      cursor: (cursor ?? -1) + 1,
      data: db.mutations.sublist(cursor ?? -1 + 1, onePage),
    ));
  }

  @override
  Future<int> dailyAggregate() {
    return Future.value(
      db.mutations
          .where((element) => element.created.day == DateTime.now().day)
          .map((e) => e.amount)
          .reduce((value, element) => value + element),
    );
  }

  @override
  Future<int> weeklyAggregate() {
    return Future.value(
      db.mutations
          .where(
            (element) => element.created.isAfter(
              DateTime.now().subtract(
                const Duration(days: 7),
              ),
            ),
          )
          .map((e) => e.amount)
          .reduce((value, element) => value + element),
    );
  }
}

class MutationsDb {
  final List<Mutation> mutations;

  const MutationsDb({required this.mutations});
}
