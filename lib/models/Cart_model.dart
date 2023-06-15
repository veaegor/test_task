import 'package:equatable/equatable.dart';
import '../models/dishes_model.dart';

class Cart extends Equatable {
  List<DishesModel> dishes;
  Cart(this.dishes);

  @override
  List<Object?> get props => [dishes];
}
