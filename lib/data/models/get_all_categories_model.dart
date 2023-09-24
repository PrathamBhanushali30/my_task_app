import 'dart:convert';

List<String> getAllCategoriesModelFromJson(String str) => List<String>.from(json.decode(str).map((x) => x));

String getAllCategoriesModelToJson(List<String> data) => json.encode(List<dynamic>.from(data.map((x) => x)));