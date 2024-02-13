import 'dart:math';

import '../models/mutations.dart';
const additionDescriptions = [
  "Dari emak",
  "Gaji Bulanan",
  "Jual Barang",
  "Dari bapak",
  "Hasil investasi",
  "Penjualan online",
  "Hadiah ulang tahun",
  "Bonus kerja",
  "Dana bantuan",
  "Pendapatan freelancing",
  // Add more addition descriptions as needed
];

const deductionDescriptions = [
  "Beli Makanan",
  "Bayar Kos",
  "Beli Baju",
  "Beli Kopi",
  "Bayar Listrik",
  "Beli Roti",
  "Beli buku",
  "Bayar internet",
  "Beli minuman",
  "Servis kendaraan",
  "Biaya transportasi",
  "Beli obat",
  // Add more deduction descriptions as needed
];

List<Mutation> generateMutations(int count) {
  var rng = Random();
  List<Mutation> mutations = [];
  DateTime date = DateTime.now();

  for (int i = 0; i < count; i++) {
    date = date.subtract(Duration(hours: rng.nextInt(48)));
    MutationType mutationType = MutationType.values[rng.nextInt(MutationType.values.length)];
  
    String description;
    if (mutationType == MutationType.addition) {
      description = additionDescriptions[rng.nextInt(additionDescriptions.length)];
    } else {
      description = deductionDescriptions[rng.nextInt(deductionDescriptions.length)];
    }

    mutations.insert(
      mutations.length,
      Mutation(
        amount: int.parse(
            "${rng.nextInt(1000).toString()}${'0' * (rng.nextInt(2) + 3)}"),
        description: description,
        mutationType: mutationType,
        created: date,
      ),
    );
  }

  return mutations;
}

final defaultMutations = generateMutations(50);
