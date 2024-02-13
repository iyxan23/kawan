import 'package:kawan/models/mutations.dart';

abstract class MutationsRepository<MutationCursor> {
  Future<List<Mutation>> getMutations();
  Future<void> pushMutation(Mutation mutation);

  Future<int> aggregateBalance();
  Future<int> weeklyAggregate();
  Future<int> dailyAggregate();
}

// class Paged<Cursor, Data> {
//   final Cursor cursor;
//   final Data data;

//   const Paged({required this.cursor, required this.data});
// }
