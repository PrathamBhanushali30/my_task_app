part of 'get_all_categories_bloc.dart';

@immutable
abstract class GetAllCategoriesEvent {}

class GetCategories extends GetAllCategoriesEvent{
  final String? searchedKeyword;

  GetCategories({this.searchedKeyword});
}