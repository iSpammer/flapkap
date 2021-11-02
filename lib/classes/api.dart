// To parse this JSON data, do
//
//     final api = apiFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Api> apiFromJson(String str) => List<Api>.from(json.decode(str).map((x) => Api.fromJson(x)));

String apiToJson(List<Api> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Api {
  Api({
    required this.id,
    required this.isActive,
    required this.price,
    required this.company,
    required this.picture,
    required this.buyer,
    required this.tags,
    required this.status,
    required this.registered,
  });

  final String id;
  final bool isActive;
  final String price;
  final String company;
  final String picture;
  final String buyer;
  final List<String> tags;
  final Status status;
  final String registered;

  factory Api.fromJson(Map<String, dynamic> json) => Api(
    id: json["id"],
    isActive: json["isActive"],
    price: json["price"],
    company: json["company"],
    picture: json["picture"],
    buyer: json["buyer"],
    tags: List<String>.from(json["tags"].map((x) => x)),
    status: statusValues.map[json["status"]]!,
    registered: json["registered"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "isActive": isActive,
    "price": price,
    "company": company,
    "picture": picture,
    "buyer": buyer,
    "tags": List<dynamic>.from(tags.map((x) => x)),
    "status": statusValues.reverse[status],
    "registered": registered,
  };
}

enum Status { ORDERED, DELIVERED, RETURNED }

final statusValues = EnumValues({
  "DELIVERED": Status.DELIVERED,
  "ORDERED": Status.ORDERED,
  "RETURNED": Status.RETURNED
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
