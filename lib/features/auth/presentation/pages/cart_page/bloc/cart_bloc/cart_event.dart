part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class ProductLoading extends CartEvent{}

class ProductAdd extends CartEvent{
  final GetProductModel product;

  ProductAdd(this.product);
}

class ProductRemove extends CartEvent{
  final GetProductModel product;

  ProductRemove(this.product);
}