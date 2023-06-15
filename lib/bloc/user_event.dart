part of 'user_bloc.dart';

@immutable
abstract class UserEvent extends Equatable {
  const UserEvent();
}

class LoadUserEvent extends UserEvent {
  @override
  List<Object?> get props => [];
}

class CartDishAdded extends UserEvent {
  List<DishesModel> dish;
  CartDishAdded(this.dish);
  @override
  List<Object> get props => [];
}

class CartDishRemoved extends UserEvent {
  List<DishesModel> dish;
  int index;
  CartDishRemoved(this.dish,this.index);
  @override
  List<Object> get props => [];
}
