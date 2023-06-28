import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../models/dishes_model.dart';
import '../services/dishes_service.dart';

part 'dish_event.dart';
part 'dish_state.dart';

class DishBloc extends Bloc<DishEvent, DishState> {
  final DishesService dishesService = DishesService();
  DishBloc() : super(const DishState()) {
    on<LoadDishEvent>(_onLoadDishEvent);
  }
  void _onLoadDishEvent(
    LoadDishEvent event,
    Emitter<DishState> emit,
  ) async {
    try {
      emit(state.copyWith(status: DishStatus.loading));
      final dish = await dishesService.getDishes();
      emit(state.copyWith(
        status: DishStatus.success,
        dish: dish,
      ));
    } catch (e) {
      emit(state.copyWith(status: DishStatus.error));
    }
  }
}
