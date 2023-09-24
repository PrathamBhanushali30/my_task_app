part of 'get_product_bloc.dart';

@immutable
abstract class GetProductState {}

class GetProductInitial extends GetProductState {}

class GetProductLoaded extends GetProductState{
  final List<GetProductModel>? productList;

  GetProductLoaded({this.productList});
}