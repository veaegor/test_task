import 'dart:async';
import 'package:dio/dio.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:test_task/services/cart_service.dart';
import 'package:test_task/services/categories_service.dart';
import 'package:test_task/services/dishes_service.dart';
import '../models/Cart_model.dart';
import '../models/categories_model.dart';
import '../models/dishes_model.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final CartService cartService = CartService();
  final CategoriesService categoriesService = CategoriesService();
  final DishesService dishesService = DishesService();
  UserBloc() : super(const UserState()) {
    on<LoadUserEvent>(_onLoadUserEvent);
    on<CartDishAdded>(_onCartDishAdded);
  }

  void _onLoadUserEvent(
    LoadUserEvent event,
    Emitter<UserState> emit,
  ) async {
    try {
      emit(state.copyWith(status: UserStatus.loading));
      final category = await categoriesService.getCategories();
      final dish = await dishesService.getDishes();
      emit(state.copyWith(
        status: UserStatus.success,
        category: category,
        dish: dish,
      ));
    } catch (e) {
      emit(state.copyWith(status: UserStatus.error));
    }
  }

  void _onCartDishAdded(
    CartDishAdded event,
    Emitter<UserState> emit,
  ) {
    try {
      emit(state.copyWith(status: UserStatus.loading));
      //TODO: add request to server
      List<DishesModel> newCart = state.cart.toList();
      newCart.add(event.dish);
      print(newCart.length);
      emit(state.copyWith(cart: newCart));
      emit(state.copyWith(status: UserStatus.success));
    } catch (e) {
      emit(state.copyWith(status: UserStatus.error));
    }
  }
}
