import 'dart:convert';
import 'package:http/http.dart' as http;
import 'model/ResponseMain.dart';

class Apiservice {
  Future<ResponseMain> fetchProducts() async {
    try {
      final url = Uri.parse('http://192.168.1.6:5000/products');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        print("Response Data: $jsonResponse"); // Debugging
        return ResponseMain.fromJson(jsonResponse);
      } else {
        print("Failed with status code: ${response.statusCode}");
        throw Exception('Failed to load products. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
      throw Exception('Failed to fetch data. Please check the server connection.');
    }
  }
}
