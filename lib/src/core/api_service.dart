import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;

class ApiService {
  static String get base {
    if (!kIsWeb && Platform.isAndroid) return "http://10.0.2.2/api_users";
    return "http://127.0.0.1/api_users";
  }

  Future<Map<String, dynamic>> get(String path, {Map<String,String>? query}) async {
    final uri = Uri.parse("$base$path").replace(queryParameters: query);
    final r = await http.get(uri);
    return jsonDecode(r.body) as Map<String, dynamic>;
  }
}