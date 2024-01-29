import 'dart:math';

import '../models/mutations.dart';

const descriptions = [
  "Dari emak",
  "Beli Makanan",
  "Bayar Kos",
  "Beli Baju",
  "Gaji Bulanan",
  "Jual Barang",
  "Beli Kopi",
  "Bayar Listrik",
  "Beli Roti",
  "Dari bapak",
]; // add more descriptions as needed

List<Mutation> generateMutations(int count) {
  var rng = Random();
  List<Mutation> mutations = [];

  for (int i = 0; i < count; i++) {
    mutations.insert(
      mutations.length,
      Mutation(
        amount: rng.nextInt(1000000), // random amount up to 1,000,000
        description: descriptions[
            rng.nextInt(descriptions.length)], // random description
        mutationType: MutationType.values[
            rng.nextInt(MutationType.values.length)], // random mutation type
        created: DateTime.now(),
      ),
    );
  }

  return mutations;
}

final defaultMutations = generateMutations(50);
