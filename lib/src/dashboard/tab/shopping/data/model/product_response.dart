import 'package:json_annotation/json_annotation.dart';
import 'package:shopping_app/src/dashboard/tab/shopping/data/model/item_model.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  final List<ItemModel>? items;

  ProductModel({this.items});

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
