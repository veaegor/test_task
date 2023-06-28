part of 'dish_bloc.dart';

@immutable
class DishState extends Equatable {
  final List<DishesModel> dish;
  final DishStatus status;

  const DishState({
    this.dish = const [],
    this.status = DishStatus.pure,
  });

  DishState copyWith({
    List<DishesModel>? dish,
    DishStatus? status,
  }) {
    return DishState(
      dish: dish ?? this.dish,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [dish, status];
}

enum DishStatus {
  pure,
  loading,
  error,
  success,
}

extension XDishStatus on DishStatus {
  bool get isPure => this == DishStatus.pure;
  bool get isLoading => this == DishStatus.loading;
  bool get isError => this == DishStatus.error;
  bool get isSuccess => this == DishStatus.success;
}
