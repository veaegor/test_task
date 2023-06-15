import 'dart:async';
import 'package:dio/dio.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:test_task/services/categories_service.dart';
import 'package:test_task/services/dishes_service.dart';
import '../models/Cart_model.dart';
import '../models/categories_model.dart';
import '../models/dishes_model.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserLoadingState()) {
    final CategoriesService categoriesService = CategoriesService();
    final DishesService dishesService = DishesService();
    on<LoadUserEvent>(
      (event, emit) async {
        emit(UserLoadingState());
        try {
          final category = await categoriesService.getCategories();
          final dish = await dishesService.getDishes();
          emit(UserLoadedState(category, dish));
        } catch (e) {
          emit(UserErrorState(e.toString()));
        }
      },
    );
  }
}
.