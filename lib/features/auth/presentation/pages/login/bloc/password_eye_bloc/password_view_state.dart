part of 'password_view_bloc.dart';

@immutable
abstract class PasswordViewState {}

class PasswordViewInitial extends PasswordViewState {
  bool? isView;

  PasswordViewInitial({this.isView});
}