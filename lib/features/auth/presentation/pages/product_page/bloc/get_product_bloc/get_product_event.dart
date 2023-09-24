part of 'get_product_bloc.dart';

@immutable
abstract class GetProductEvent {}

class GetProducts extends GetProductEvent{
  final String? category;
  final String? limit;

  GetProducts({this.category,this.limit});
}