part of 'navbar_bloc.dart';

@immutable
abstract class NavbarEvent {}

class ChangeNavbarIndex extends NavbarEvent{
  final int? selectedIndex;

  ChangeNavbarIndex({this.selectedIndex});
}