import 'package:shopping_app/src/dashboard/tab/shopping/domain/model/item_model.dart';

import '../shopping_data.dart';

class ProductListModel {
  final List<ItemModel> items;
  String cursor;
  ProductState? state;

  ProductListModel(this.items, this.cursor, {this.state});

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
