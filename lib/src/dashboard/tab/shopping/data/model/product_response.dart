import 'package:json_annotation/json_annotation.dart';
import 'package:shopping_app/src/dashboard/tab/shopping/data/model/item_response.dart';


part 'product_response.g.dart';

@JsonSerializable()
class ProductResponse {
  final List<ItemResponse>? items;
  final String? nextCursor;

  ProductResponse({this.items, this.nextCursor});

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductResponseToJson(this);
}
