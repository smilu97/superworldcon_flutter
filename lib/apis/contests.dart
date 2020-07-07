import 'dart:convert';
import 'package:http/http.dart' as http;

class ContestListResponse {
  final String createdAt;
  final String updatedAt;
  final String id;
  final String title;
  final int    numItems;

  ContestListResponse({
    this.createdAt,
    this.updatedAt,
    this.id,
    this.title,
    this.numItems,
  });

  factory ContestListResponse.fromJson(Map<String, dynamic> json) {
    return ContestListResponse(
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      id:        json['id'],
      title:     json['title'],
      numItems:  json['num_items'],
    );
  }
}

Future<List<ContestListResponse>> fetchContests() async {
  final response = await http.get('http://api.yjin.kim/contests');
  if (response.statusCode == 200) {
    return (jsonDecode(response.body) as List<dynamic>).map((e) {
      return ContestListResponse.fromJson(e);
    }).toList();
  } else {
    throw Exception('Failed to fetch contests');
  }
}
