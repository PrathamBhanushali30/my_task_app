part of 'quantity_bloc.dart';

@immutable
abstract class QuantityEvent {}

class QuantityAdd extends QuantityEvent{}

class QuantityRemove extends QuantityEvent{}