import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qtech_ecommerce/data/model/product_model.dart';

class ApiService {
  static Future<List<ProductModel>?>AllProducts()async{
    final response =await http.get(Uri.parse('https://dummyjson.com/products'));

    if(response.statusCode == 200){
      final json = jsonDecode(response.body);
      final products = json['products'] as List;
      return products.map((productJson)=>ProductModel.fromJson(productJson)).toList();

    }else{
      print("Failed Status Code : $response.statusCode");
      return null;
    }


  }
}