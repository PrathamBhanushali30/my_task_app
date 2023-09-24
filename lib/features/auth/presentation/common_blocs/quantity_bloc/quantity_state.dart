part of 'quantity_bloc.dart';

@immutable
abstract class QuantityState {}

class QuantityInitial extends QuantityState {
  final int qty;

  QuantityInitial(this.qty);
}