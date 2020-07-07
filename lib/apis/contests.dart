import 'dart:convert';
import 'package:http/http.dart' as http;

class ContestListItem {
  final String createdAt;
  final String updatedAt;
  final String id;
  final String title;
  final int    numItems;

  ContestListItem({
    this.createdAt,
    this.updatedAt,
    this.id,
    this.title,
    this.numItems,
  });

  factory ContestListItem.fromJson(Map<String, dynamic> json) {
    return ContestListItem(
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      id:        json['id'],
      title:     json['title'],
      numItems:  json['num_items'],
    );
  }
}

class ContestListResponse {
  final List<ContestListItem> items;

  ContestListResponse({this.items});

  factory ContestListResponse.fromJson(List<dynamic> json) {
    return ContestListResponse(
      items: json.map((e) {
        return ContestListItem.fromJson(e);
      }).toList()
    );
  }
}

Future<ContestListResponse> fetchContests() async {
  final response = await http.get('http://api.yjin.kim/contests');
  if (response.statusCode == 200) {
    return ContestListResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to fetch contests');
  }
}
