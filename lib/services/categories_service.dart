import 'dart:convert';
import 'package:http/http.dart';
import 'package:test_task/models/categories_model.dart';

class CategoriesService {
  String baseUrl = 'https://run.mocky.io/v3/058729bd-1402-4578-88de-265481fd7d54';

  Future<List<CategoriesModel>> getCategories() async {
    Response response = await get(Uri.parse(baseUrl));
    if (response.statusCode==200) {
      final List result = jsonDecode(response.body)['сategories'];
      return result.map((e) => CategoriesModel.fromJson(e)).toList();
    }
    else {throw Exception(response.reasonPhrase);}
  }
}