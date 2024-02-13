import 'package:equatable/equatable.dart';
import 'package:kawan/models/mutations.dart';

class MutationsState<Cursor> extends Equatable {
  final List<Mutation> mutations;

  final int? balanceAggregate;
  final int? balanceDailyAggregate;
  final int? balanceWeeklyAggregate;

  const MutationsState(
      {this.mutations = const [],
      this.balanceAggregate,
      this.balanceDailyAggregate,
      this.balanceWeeklyAggregate});

  MutationsState copyWith({
    List<Mutation> Function()? mutations,
    int Function()? balanceAggregate,
    int Function()? balanceDailyAggregate,
    int Function()? balanceWeeklyAggregate,
  }) {
    return MutationsState(
      mutations: mutations != null ? mutations() : this.mutations,
      balanceAggregate:
          balanceAggregate != null ? balanceAggregate() : this.balanceAggregate,
      balanceDailyAggregate: balanceDailyAggregate != null
          ? balanceDailyAggregate()
          : this.balanceDailyAggregate,
      balanceWeeklyAggregate: balanceWeeklyAggregate != null
          ? balanceWeeklyAggregate()
          : this.balanceWeeklyAggregate,
    );
  }

  @override
  List<Object?> get props => [
        mutations,
        balanceAggregate,
        balanceDailyAggregate,
        balanceWeeklyAggregate
      ];
}
