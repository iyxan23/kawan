import 'package:equatable/equatable.dart';
import 'package:kawan/models/mutations.dart';

class MutationsEvents extends Equatable {
  const MutationsEvents();

  @override
  List<Object?> get props => [];
}

final class MutationAdded extends MutationsEvents {
  final Mutation mutation;
  const MutationAdded(this.mutation);

  @override
  List<Object?> get props => [mutation];
}

final class LoadMutations extends MutationsEvents {
  const LoadMutations();
}

final class LoadAggregate extends MutationsEvents {
  const LoadAggregate();
}

final class LoadDailyAggregate extends MutationsEvents {
  const LoadDailyAggregate();
}

final class LoadWeeklyAggregate extends MutationsEvents {
  const LoadWeeklyAggregate();
}
