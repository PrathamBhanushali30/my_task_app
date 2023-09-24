part of 'get_user_details_bloc.dart';

@immutable
abstract class GetUserDetailsState {}

class GetUserDetailsInitial extends GetUserDetailsState {}

class GetUserDetailsLoaded extends GetUserDetailsState{
  final UserModel? user;

  GetUserDetailsLoaded({this.user});
}