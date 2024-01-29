import 'package:kawan/models/mutations.dart';
import 'package:kawan/repository/mutations.dart';
import 'package:kawan/repository/mutations_generator.dart';

const onePage = 10;

class MutationsRam extends MutationsRepository {
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
  Future<int> dailyAggregate() {
    // TODO: implement dailyAggregate
    throw UnimplementedError();
  }

  @override
  Future<Paged<dynamic, List<Mutation>>> getMutations(cursor) {
    // TODO: implement getMutations
    throw UnimplementedError();
  }

  @override
  Future<int> weeklyAggregate() {
    // TODO: implement weeklyAggregate
    throw UnimplementedError();
  }
}

class MutationsDb {
  final List<Mutation> mutations;

  const MutationsDb({required this.mutations});
}
