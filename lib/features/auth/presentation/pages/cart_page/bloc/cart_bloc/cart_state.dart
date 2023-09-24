part of 'cart_bloc.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class CartLoaded extends CartState{
  final List<GetProductModel> cartList;

  CartLoaded(this.cartList);
}