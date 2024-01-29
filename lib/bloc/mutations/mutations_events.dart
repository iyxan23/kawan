import 'package:equatable/equatable.dart';

class MutationsEvents extends Equatable {
  const MutationsEvents();

  @override
  List<Object?> get props => [];
}

final class AdditionMutationAdded extends MutationsEvents {
  final int nominal;
  final String description;

  const AdditionMutationAdded(
      {required this.nominal, required this.description});

  @override
  List<Object?> get props => [nominal, description];
}

final class DeductionMutationAdded extends MutationsEvents {
  final int nominal;
  final String description;

  const DeductionMutationAdded(
      {required this.nominal, required this.description});

  @override
  List<Object?> get props => [nominal, description];
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
