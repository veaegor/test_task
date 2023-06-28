part of 'cart_bloc.dart';

@immutable
abstract class CartEvent extends Equatable {
  const CartEvent();
  @override
  List<Object> get props => [];
}

class LoadCartEvent extends CartEvent {
  @override
  List<Object> get props => [];
}

class CartDishAdded extends CartEvent {
  final DishesModel dish;
  const CartDishAdded(this.dish);
  @override
  List<Object> get props => [];
}

class CartDishRemoved extends CartEvent {
  final DishesModel dish;
  const CartDishRemoved(this.dish);
  @override
  List<Object> get props => [];
}
