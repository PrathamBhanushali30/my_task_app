import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'navbar_event.dart';
part 'navbar_state.dart';

class NavbarBloc extends Bloc<NavbarEvent, NavbarInitial> {
  NavbarBloc() : super(NavbarInitial(selectedIndex: 0)) {
    on<ChangeNavbarIndex>((event, emit) {
      emit(NavbarInitial(selectedIndex: event.selectedIndex));
    });
  }
}
