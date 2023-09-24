part of 'password_view_bloc.dart';

@immutable
abstract class PasswordViewEvent {}

class ViewPassword extends PasswordViewEvent{
  final bool? isView;

  ViewPassword({this.isView});
}