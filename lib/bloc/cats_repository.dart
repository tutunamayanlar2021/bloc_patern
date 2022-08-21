import 'dart:convert';
import 'dart:io';


import 'package:bloc_patern/bloc/cat.dart';
import 'package:http/http.dart' as http;

abstract class CatsRepository {
  Future<List<Cat>> getCats();
}

class SampleCatsRepository implements CatsRepository {
  static const String baseUrl = "https://hwasampleapi.firebaseio.com/http.json";

  @override
  Future<List<Cat>> getCats() async {
    final response = await http.get(Uri.parse(baseUrl));
    //throw UnimplementedError();
    switch (response.statusCode) {
      case HttpStatus.ok:
        final jsonBody = jsonDecode(response.body) as List;
        return jsonBody.map((e) => Cat.fromJson(e)).toList();

      default:
    }
    throw NetworkException(response.statusCode.toString(), response.body);
  }
}

class NetworkException implements Exception {
  final String statusCode;
  final String message;
  NetworkException(this.statusCode,this.message);
}
