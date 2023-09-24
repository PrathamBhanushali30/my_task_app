import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'password_view_event.dart';

part 'password_view_state.dart';

class PasswordViewBloc extends Bloc<PasswordViewEvent, PasswordViewInitial> {
  PasswordViewBloc() : super(PasswordViewInitial(isView: false)) {
    on<ViewPassword>((event, emit) {
      emit(PasswordViewInitial(isView: event.isView));
    });
  }
}
