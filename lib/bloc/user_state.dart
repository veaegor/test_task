part of 'user_bloc.dart';

@immutable
abstract class UserState extends Equatable {}

class UserLoadingState extends UserState {
  @override
  List<Object?> get props => [];
}

class UserLoadedState extends UserState {
  final List<CategoriesModel> category;
  final List<DishesModel> dish;
  UserLoadedState(this.category, this.dish);
  @override
  List<Object?> get props => [category, dish];
}

class UserErrorState extends UserState {
  final String error;
  UserErrorState(this.error);
  @override
  List<Object?> get props => [error];
}

class CartLoaded extends UserState {
  final Cart cart;
  CartLoaded(this.cart);

  @override
  List<Object?> get props => [cart];
}
