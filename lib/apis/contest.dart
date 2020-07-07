import 'dart:convert';
import 'package:http/http.dart' as http;

class ContestItemDescription {
  final String contestItemId;
  final String createdAt;
  final String descType;
  final String id;
  final String title;
  final String updatedAt;
  final String url;

  ContestItemDescription({
    this.contestItemId,
    this.createdAt,
    this.descType,
    this.id,
    this.title,
    this.updatedAt,
    this.url,
  });

  factory ContestItemDescription.fromJson(Map<String, String> json) {
    return ContestItemDescription(
      contestItemId: json['contest_item_id'],
      createdAt:     json['created_at'],
      descType:      json['desc_type'],
      id:            json['id'],
      title:         json['title'],
      updatedAt:     json['updated_at'],
      url:           json['url'],
    );
  }
}

class ContestItem {
  final String id;
  final String contestId;
  final String createdAt;
  final String updatedAt;
  final String title;
  final int    countLose;
  final int    countWin;

  final List<ContestItemDescription> descriptions;
  
  ContestItem({
    this.id,
    this.contestId,
    this.createdAt,
    this.updatedAt,
    this.title,
    this.countLose,
    this.countWin,
    this.descriptions
  });

  factory ContestItem.fromJson(Map<String, dynamic> json) {
    return ContestItem(
      id:           json['id'],
      contestId:    json['contest_id'],
      createdAt:    json['created_at'],
      updatedAt:    json['updated_at'],
      title:        json['title'],
      countLose:    json['count_lose'],
      countWin:     json['count_win'],
      descriptions: (json['descriptions'] as List<dynamic>).map((e) {
        return ContestItemDescription.fromJson(e);
      }).toList(),
    );
  }
}

class ContestResponse {
  final String createdAt;
  final String updatedAt;
  final String id;
  final String title;
  final int    numItems;

  final List<ContestItem> items;
  
  ContestResponse({
    this.createdAt,
    this.updatedAt,
    this.id,
    this.title,
    this.numItems,
    this.items,
  });

  factory ContestResponse.fromJson(Map<String, dynamic> json) {
    return ContestResponse(
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      id:        json['id'],
      title:     json['title'],
      numItems:  json['num_items'],
      items: (json['items'] as List<dynamic>).map((e) {
        return ContestItem.fromJson(e);
      }).toList(),
    );
  }
}

Future<ContestResponse> fetchContest(final String id) async {
  final response = await http.get('http://api.yjin.kim/contest/$id');
  if (response.statusCode == 200) {
    return ContestResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to fetch contests');
  }
}
