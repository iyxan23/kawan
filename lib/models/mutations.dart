class Mutation {
  final int amount;
  final String description;
  final MutationType mutationType;
  final DateTime created;

  const Mutation(
      {required this.amount,
      required this.description,
      required this.mutationType,
      required this.created});
}

enum MutationType {
  addition,
  deduction,
}
