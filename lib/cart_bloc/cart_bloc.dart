import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../models/dishes_model.dart';
import '../services/cart_service.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartService cartService = CartService();
  CartBloc() : super(const CartState()) {
    on<LoadCartEvent>(_onLoadCartEvent);
    on<CartDishAdded>(_onCartDishAdded);
  }
  void _onLoadCartEvent(
    LoadCartEvent event,
    Emitter<CartState> emit,
  ) async {
    try {
      emit(state.copyWith(status: CartStatus.loading));
      List<DishesModel> newCart = state.cart.toList();
      emit(state.copyWith(
        status: CartStatus.success,
        cart: newCart,
      ));
    } catch (e) {
      emit(state.copyWith(status: CartStatus.error));
    }
  }

  void _onCartDishAdded(
    CartDishAdded event,
    Emitter<CartState> emit,
  ) {
    try {
      emit(state.copyWith(status: CartStatus.loading));
      List<DishesModel> newCart = state.cart.toList();
      newCart.add(event.dish);
      print(newCart.length);
      emit(state.copyWith(cart: newCart));
      emit(state.copyWith(status: CartStatus.success));
    } catch (e) {
      emit(state.copyWith(status: CartStatus.error));
    }
  }
}
