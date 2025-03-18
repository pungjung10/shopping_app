import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/src/dashboard/tab/shopping/bloc/shopping_bloc.dart';

import '../../core/color_resource.dart';
import '../../core/text_styles.dart';
import '../../feature/shopping/product_item/presentation/product_item_widget.dart';

class CartDashboard extends StatefulWidget {
  const CartDashboard({super.key});

  @override
  State<CartDashboard> createState() => _CartDashboardState();
}

class _CartDashboardState extends State<CartDashboard> {
  final List<String> products = [
    "Gourmet Fusion Pizza",
    "Organic Quinoa Salad",
    "Herb-Infused Bread",
    "Zesty Lemon Garlic Shrimp",
    "Berry Bliss Yogurt",
    "Gourmet Fusion Pizza",
    "Organic Quinoa Salad",
    "Herb-Infused Bread",
    "Zesty Lemon Garlic Shrimp",
    "Berry Bliss Yogurt",
    "Gourmet Fusion Pizza",
    "Organic Quinoa Salad",
    "Herb-Infused Bread",
    "Zesty Lemon Garlic Shrimp",
    "Berry Bliss Yogurt",
    "Gourmet Fusion Pizza",
    "Organic Quinoa Salad",
    "Herb-Infused Bread",
    "Zesty Lemon Garlic Shrimp",
    "Berry Bliss Yogurt",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Cart", style: fontTitleLarge)),
        body: SafeArea(child:
            BlocBuilder<ShoppingBloc, ShoppingState>(builder: (context, state) {
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              String product = products[index];
              return Dismissible(
                key: Key(product),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {},
                background: Container(
                  color: ColorResources.red,
                  child: Stack(alignment: Alignment.centerRight, children: [
                    Positioned(
                      right: 76,
                      child: Image.asset(
                          width: 24, height: 24, "assets/common/delete.png"),
                    ),
                  ]),
                ),
                child: ProductItemWidget(product: product),
              );
            },
          );
        })),
        bottomNavigationBar: Container(
          height: 163,
          color: ColorResources.lightPurple,
        ));
  }
}
