part of 'navbar_bloc.dart';

@immutable
abstract class NavbarState {}

class NavbarInitial extends NavbarState {
  final int? selectedIndex;

  NavbarInitial({this.selectedIndex});
}