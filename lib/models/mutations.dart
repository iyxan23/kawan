import 'package:equatable/equatable.dart';

class Mutation extends Equatable {
  final int amount;
  final String description;
  final MutationType mutationType;
  final DateTime created;

  const Mutation(
      {required this.amount,
      required this.description,
      required this.mutationType,
      required this.created});

  @override
  List<Object?> get props => [amount, description, mutationType, created];
}

enum MutationType {
  addition,
  deduction,
}
