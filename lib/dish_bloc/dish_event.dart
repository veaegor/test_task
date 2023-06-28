part of 'dish_bloc.dart';

@immutable
abstract class DishEvent extends Equatable {
  const DishEvent();
  @override
  List<Object> get props => [];
}

class LoadDishEvent extends DishEvent {
  @override
  List<Object> get props => [];
}
