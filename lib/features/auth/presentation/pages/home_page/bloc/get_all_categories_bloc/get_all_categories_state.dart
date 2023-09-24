part of 'get_all_categories_bloc.dart';

@immutable
abstract class GetAllCategoriesState {}

class GetAllCategoriesInitial extends GetAllCategoriesState {}

class GetAllCategoriesLoaded extends GetAllCategoriesState{
  final List<dynamic> categoryList;

  GetAllCategoriesLoaded({required this.categoryList});
}