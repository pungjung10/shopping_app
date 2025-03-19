import 'package:json_annotation/json_annotation.dart';

part 'item_response.g.dart';

@JsonSerializable()
class ItemResponse {
  final int? id;
  final String? name;
  final int? price;

  ItemResponse({this.id, this.name, this.price});

  factory ItemResponse.fromJson(Map<String, dynamic> json) =>
      _$ItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ItemResponseToJson(this);
}
