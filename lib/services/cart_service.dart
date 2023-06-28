import '../models/dishes_model.dart';

class CartService {
  final List<DishesModel> dishes;
  CartService({this.dishes = const <DishesModel>[]});
}
