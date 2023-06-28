part of 'user_bloc.dart';

@immutable
class UserState extends Equatable {
  final List<CategoriesModel> category;
  final List<DishesModel> dish;
  final List<DishesModel> cart;
  final UserStatus status;

  const UserState({
    this.category = const [],
    this.dish = const [],
    this.cart = const [],
    this.status = UserStatus.pure,
  });

  UserState copyWith({
    List<CategoriesModel>? category,
    List<DishesModel>? dish,
    List<DishesModel>? cart,
    UserStatus? status,
  }) {
    return UserState(
      category: category ?? this.category,
      dish: dish ?? this.dish,
      cart: cart ?? this.cart,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [category, dish, cart, status];
}

enum UserStatus {
  pure,
  loading,
  error,
  success,
}

extension XUserStatus on UserStatus {
  bool get isPure => this == UserStatus.pure;
  bool get isLoading => this == UserStatus.loading;
  bool get isError => this == UserStatus.error;
  bool get isSuccess => this == UserStatus.success;
}
