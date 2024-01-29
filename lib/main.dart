import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kawan/app_observer.dart';
import 'package:kawan/bootstrap.dart';

void main() {
  Bloc.observer = const AppObserver();

  bootstrap();
}
