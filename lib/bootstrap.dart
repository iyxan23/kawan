import 'package:flutter/material.dart';
import 'package:kawan/repository/mutations.dart';
import 'package:kawan/repository/mutations_ram.dart';

import 'app.dart';

void bootstrap() {
  MutationsRepository mutationsRepository = MutationsRam();

  runApp(App(mutationsRepository: mutationsRepository));
}
