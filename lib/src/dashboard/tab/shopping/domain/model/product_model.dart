import 'package:shopping_app/src/dashboard/tab/shopping/domain/model/item_model.dart';

class ProductListModel {
  final List<ItemModel> items;
  String cursor;

  ProductListModel(this.items, this.cursor);

  ProductListModel copyWith({
    List<ItemModel>? items,
    String? cursor,
  }) {
    return ProductListModel(
      items ?? this.items,
      cursor ?? this.cursor,
    );
  }
}
