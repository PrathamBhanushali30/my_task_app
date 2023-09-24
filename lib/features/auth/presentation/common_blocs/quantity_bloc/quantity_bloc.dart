import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../shared/utils/local_storage.dart';

part 'quantity_event.dart';
part 'quantity_state.dart';

class QuantityBloc extends Bloc<QuantityEvent, QuantityInitial> {
  QuantityBloc(String key) : super(QuantityInitial(LocalStorage.instance.read(key) ?? 0)) {
    on<QuantityAdd>((event, emit) {
      emit(QuantityInitial(state.qty + 1));
    });
    on<QuantityRemove>((event, emit) {
      emit(QuantityInitial(state.qty - 1));
    });
  }
}
