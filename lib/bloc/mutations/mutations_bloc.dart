import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kawan/bloc/mutations/mutations_events.dart';
import 'package:kawan/bloc/mutations/mutations_state.dart';
import 'package:kawan/models/mutations.dart';
import 'package:kawan/repository/mutations.dart';

class MutationsBloc extends Bloc<MutationsEvents, MutationsState> {
  MutationsBloc({
    required MutationsRepository mutationsRepository,
  })  : _mutationsRepository = mutationsRepository,
        super(const MutationsState(
            mutations: [],
            balanceAggregate: 0,
            balanceDailyAggregate: 0,
            balanceWeeklyAggregate: 0)) {
    on<AdditionMutationAdded>(_onAdditionMutationAdded);
    on<DeductionMutationAdded>(_onDeductionMutationAdded);
    on<LoadMutations>(_onLoadMutations);

    on<LoadAggregate>(_onLoadAggregate);
    on<LoadDailyAggregate>(_onLoadDailyAggregate);
    on<LoadWeeklyAggregate>(_onLoadWeeklyAggregate);
  }

  final MutationsRepository _mutationsRepository;

  Future<void> _onAdditionMutationAdded(
      AdditionMutationAdded event, Emitter<MutationsState> emit) async {
    await _mutationsRepository.pushMutation(
      Mutation(
        amount: event.nominal,
        description: event.description,
        mutationType: MutationType.addition,
        created: DateTime.now(),
      ),
    );

    add(const LoadMutations());
  }

  Future<void> _onDeductionMutationAdded(
    DeductionMutationAdded event,
    Emitter<MutationsState> emit,
  ) async {
    await _mutationsRepository.pushMutation(
      Mutation(
        amount: event.nominal,
        description: event.description,
        mutationType: MutationType.deduction,
        created: DateTime.now(),
      ),
    );

    add(const LoadMutations());
  }

  Future<void> _onLoadMutations(
      LoadMutations event, Emitter<MutationsState> emit) async {
    final mutations = await _mutationsRepository.getMutations();

    emit(
      state.copyWith(
        mutations: () => mutations,
      ),
    );

    add(const LoadAggregate());
    add(const LoadDailyAggregate());
    add(const LoadWeeklyAggregate());
  }

  Future<void> _onLoadAggregate(
    LoadAggregate event,
    Emitter<MutationsState> emit,
  ) async {
    final balance = await _mutationsRepository.aggregateBalance();
    emit(state.copyWith(balanceAggregate: () => balance));
  }

  Future<void> _onLoadDailyAggregate(
    LoadDailyAggregate event,
    Emitter<MutationsState> emit,
  ) async {
    final balance = await _mutationsRepository.dailyAggregate();
    emit(state.copyWith(balanceDailyAggregate: () => balance));
  }

  Future<void> _onLoadWeeklyAggregate(
    LoadWeeklyAggregate event,
    Emitter<MutationsState> emit,
  ) async {
    final balance = await _mutationsRepository.weeklyAggregate();
    emit(state.copyWith(balanceWeeklyAggregate: () => balance));
  }
}
