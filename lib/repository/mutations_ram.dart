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
  Future<void> pushMutation(Mutation mutation) {
    db.mutations.insert(0, mutation);
    return Future.value();
  }

  @override
  Future<int> aggregateBalance() {
    print("[db] aggregate balance called");
    return Future.value(
      db.mutations.isEmpty
          ? 0
          : db.mutations
              .map((m) => m.amount)
              .reduce((value, element) => value + element),
    );
  }

  @override
  Future<List<Mutation>> getMutations() {
    return Future.value(db.mutations);
  }

  @override
  Future<int> dailyAggregate() {
    print("[db] daily aggregate called");
    final mutationsToday = db.mutations.where(
      (element) => element.created.day == DateTime.now().day,
    );

    return Future.value(
      mutationsToday.isEmpty
          ? 0
          : mutationsToday
              .map((e) => e.amount)
              .reduce((value, element) => value + element),
    );
  }

  @override
  Future<int> weeklyAggregate() {
    print("[db] weekly aggregate called");
    final mutationsThisWeek = db.mutations.where(
      (element) => element.created.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      ),
    );

    return Future.value(
      mutationsThisWeek.isEmpty
          ? 0
          : mutationsThisWeek
              .map((e) => e.amount)
              .reduce((value, element) => value + element),
    );
  }
}

class MutationsDb {
  final List<Mutation> mutations;

  const MutationsDb({required this.mutations});
}
