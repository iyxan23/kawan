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
  DateTime date = DateTime.now();

  for (int i = 0; i < count; i++) {
    date = date.subtract(Duration(hours: rng.nextInt(48)));
    mutations.insert(
      mutations.length,
      Mutation(
        amount: int.parse(
            "${rng.nextInt(1000).toString()}${'0' * (rng.nextInt(2) + 3)}"),
        description: descriptions[
            rng.nextInt(descriptions.length)], // random description
        mutationType: MutationType.values[
            rng.nextInt(MutationType.values.length)], // random mutation type
        created: date,
      ),
    );
  }

  return mutations;
}

final defaultMutations = generateMutations(50);
