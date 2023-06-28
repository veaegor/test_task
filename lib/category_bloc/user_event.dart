part of 'user_bloc.dart';

@immutable
abstract class UserEvent extends Equatable {
  const UserEvent();
  @override
  List<Object> get props => [];
}

class LoadUserEvent extends UserEvent {
  @override
  List<Object> get props => [];
}

class CartDishAdded extends UserEvent {
  final DishesModel dish;
  const CartDishAdded(this.dish);
  @override
  List<Object> get props => [];
}

class CartDishRemoved extends UserEvent {
  final DishesModel dish;
  const CartDishRemoved(this.dish);
  @override
  List<Object> get props => [];
}
