import 'package:dio/dio.dart';

class CategoriesPage {
  final Dio _dio = Dio();
  
  Future<List<dynamic>> fetchCategories() async {
    try {
      // Replace this with your actual API endpoint
      final response = await _dio.get("http://192.168.1.143:3000/v1/user/categories/");

      if (response.statusCode == 200) {
        return response.data['categories']; // Assuming the key is 'categories'
      } else {
        throw Exception("Failed to load categories");
      }
    } catch (e) {
      throw Exception("Error fetching categories: $e");
    }
  }

}

