part of 'cart_bloc.dart';

@immutable
class CartState extends Equatable {
  final List<DishesModel> cart;
  final CartStatus status;

  const CartState({
    this.cart = const [],
    this.status = CartStatus.pure,
  });

  CartState copyWith({
    List<DishesModel>? cart,
    CartStatus? status,
  }) {
    return CartState(
      cart: cart ?? this.cart,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [cart, status];
}

enum CartStatus {
  pure,
  loading,
  error,
  success,
}

extension XCartStatus on CartStatus {
  bool get isPure => this == CartStatus.pure;
  bool get isLoading => this == CartStatus.loading;
  bool get isError => this == CartStatus.error;
  bool get isSuccess => this == CartStatus.success;
}
