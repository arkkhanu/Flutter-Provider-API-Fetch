import 'dart:io';

import 'package:http/http.dart' as http;

class API_Fetch {
  static String _BASE_URL1 = "https://jsonplaceholder.typicode.com/todos/1";
  static String _BASE_URL2 = "https://jsonplaceholder.typicode.com/todos";

  static Future<String> fetchSingleTodo() async {
    try {
      var response =
          await http.get(Uri.parse(_BASE_URL1)).timeout(Duration(seconds: 3));
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return "null";
      }
    } on SocketException catch (_) {
      return "SocketError";
    } catch (_) {
      print(_.toString());
      return "NetworkError";
    }
  }

  static Future<String> fetchListOfTodo() async {
    try {
      var response =
          await http.get(Uri.parse(_BASE_URL2)).timeout(Duration(seconds: 3));
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return "null";
      }
    } on SocketException catch (_) {
      return "SocketError";
    } catch (_) {
      print(_.toString());
      return "NetworkError";
    }
  }
}
