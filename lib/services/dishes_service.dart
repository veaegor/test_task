import 'dart:convert';
import 'package:http/http.dart';
import 'package:test_task/models/dishes_model.dart';

class DishesService {
  String baseUrl = 'https://run.mocky.io/v3/aba7ecaa-0a70-453b-b62d-0e326c859b3b';

  Future<List<DishesModel>> getDishes() async {
    Response response = await get(Uri.parse(baseUrl));
    if (response.statusCode==200) {
      final List result = jsonDecode(response.body)['dishes'];
      return result.map((e) => DishesModel.fromJson(e)).toList();
    }
    else {throw Exception(response.reasonPhrase);}
  }
}