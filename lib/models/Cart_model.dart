import 'package:equatable/equatable.dart';
import '../models/dishes_model.dart';

class Cart extends Equatable {
  final List<DishesModel> dishes;
  const Cart({this.dishes = const []});

  @override
  List<Object?> get props => [dishes];
}
