import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kawan/bloc/mutations/mutations_events.dart';
import 'package:kawan/bloc/mutations/mutations_state.dart';
import 'package:kawan/repository/mutations.dart';

class MutationsBloc extends Bloc<MutationsEvents, MutationsState> {
  MutationsBloc({
    required MutationsRepository mutationsRepository,
  })  : _mutationsRepository = mutationsRepository,
        super(const MutationsState(
            mutations: [],
            cursor: null,
            balanceAggregate: 0,
            balanceDailyAggregate: 0,
            balanceWeeklyAggregate: 0)) {
    on<MutationAdded>(_onMutationAdded);
    on<LoadMutations>(_onLoadMutations);

    on<LoadAggregate>(_onLoadAggregate);
    on<LoadDailyAggregate>(_onLoadDailyAggregate);
    on<LoadWeeklyAggregate>(_onLoadWeeklyAggregate);
  }

  final MutationsRepository _mutationsRepository;

  void _onMutationAdded(MutationAdded event, Emitter<MutationsState> emit) {
    emit(
      state.copyWith(
        mutations: () => [...state.mutations, event.mutation],
      ),
    );
  }

  Future<void> _onLoadMutations(
      LoadMutations event, Emitter<MutationsState> emit) async {
    final mutations = await _mutationsRepository.getMutations(state.cursor);
    emit(
      state.copyWith(
        mutations: () => [...state.mutations, ...mutations.data],
        cursor: () => mutations.cursor,
      ),
    );
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
