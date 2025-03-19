import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/src/core/style/color_resource.dart';
import 'package:shopping_app/src/dashboard/tab/shopping/domain/model/item_model.dart';
import 'package:shopping_app/src/feature/shopping/product_item/presentation/bloc/product_bloc.dart';

import '../../../../core/style/text_styles.dart';
import '../../../../shared/widget/button_widget.dart';

class ProductItemWidget extends StatelessWidget {
  final ItemModel item;

  const ProductItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            width: 76,
            height: 76,
            "assets/common/image.png",
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: fontTitleMedium.copyWith(
                      color: ColorResources.primaryContainer),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      (item.price).toString(),
                      style: fontTitleLarge.copyWith(
                          color: ColorResources.primaryFixVariant),
                    ),
                    Text(
                      " / unit",
                      style: fontTitleSmall.copyWith(
                          color: ColorResources.secondary),
                    ),
                  ],
                )
              ],
            ),
          ),
          BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              int quantity = state.items[item.name] ?? 0;
              return quantity > 0
                  ? Row(
                      children: [
                        buttonIcon(
                            icon: Icons.remove,
                            onEvent: () {
                              BlocProvider.of<ProductBloc>(context)
                                  .add(RemoveItemEvent(item.name));
                            }),
                        Text(quantity.toString(), style: fontTitleMedium),
                        buttonIcon(
                            icon: Icons.add,
                            onEvent: () {
                              BlocProvider.of<ProductBloc>(context)
                                  .add(AddItemEvent(item.name));
                            })
                      ],
                    )
                  : buttonTextWhite(
                      text: "Add to cart",
                      onEvent: () {
                        BlocProvider.of<ProductBloc>(context)
                            .add(AddItemEvent(item.name));
                      });
            },
          ),
        ],
      ),
    );
  }
}
