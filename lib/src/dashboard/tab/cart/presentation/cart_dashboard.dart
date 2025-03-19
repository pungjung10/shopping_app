import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/src/core/injection.dart';
import 'package:shopping_app/src/dashboard/tab/cart/data/model/product_request.dart';
import 'package:shopping_app/src/dashboard/tab/cart/domain/model/summary_model.dart';
import 'package:shopping_app/src/dashboard/tab/cart/presentation/checkout_bloc/checkout_bloc.dart';
import 'package:shopping_app/src/dashboard/tab/shopping/domain/model/item_model.dart';
import 'package:shopping_app/src/dashboard/tab/cart/presentation/bloc/cart_bloc.dart';
import 'package:shopping_app/src/feature/shopping/product_item/presentation/bloc/product_bloc.dart';
import 'package:shopping_app/src/shared/widget/general_page_state_widget.dart';

import '../../../../core/style/color_resource.dart';
import '../../../../core/style/text_styles.dart';
import '../../../../feature/shopping/product_item/presentation/product_item_widget.dart';
import '../../../../shared/widget/button_widget.dart';
import '../../../../shared/widget/snack_bar.dart';

class CartDashboard extends StatefulWidget {
  const CartDashboard({super.key});

  @override
  State<CartDashboard> createState() => _CartDashboardState();
}

class _CartDashboardState extends State<CartDashboard> {
  final checkOutBloc = CheckoutBloc(sl());

  @override
  void initState() {
    super.initState();
    List<Map<ItemModel, int>> productList =
        BlocProvider.of<ProductBloc>(context).productList;
    BlocProvider.of<CartBloc>(context).add(UpdateCart(productList));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.white,
      appBar: AppBar(
        title: const Text("Cart", style: fontTitleLarge),
        backgroundColor: ColorResources.white,
      ),
      body: BlocProvider(
        create: (context) => checkOutBloc,
        child: BlocConsumer<CheckoutBloc, CheckoutState>(
          listener: (context, state) {
            if (state is CheckoutError) {
              ScaffoldMessenger.of(context).showSnackBar(snackBarWidget(
                  text: "Something went wrong",
                  onEvent: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  }));
            }
          },
          builder: (context, state) {
            if (state is CheckoutSuccess) {
              return generalWidget(
                title: "Success!",
                buttonText: "Shop again",
                description: "Thank you for shopping with us!",
                onEvent: () {
                  BlocProvider.of<ProductBloc>(context)
                      .add(ClearAllItemEvent());
                  Navigator.pop(context);
                },
              );
            }
            return BlocBuilder<CartBloc, CartState>(
              builder: (context, cartState) {
                if (cartState is CartUpdated) {
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: cartState.productList.length,
                          itemBuilder: (context, index) {
                            Map<ItemModel, int> product =
                                cartState.productList[index];
                            return Dismissible(
                              key: Key(product.keys.first.id.toString()),
                              direction: DismissDirection.endToStart,
                              onDismissed: (direction) {
                                BlocProvider.of<ProductBloc>(context)
                                    .add(ClearItemEvent(product.keys.first));
                              },
                              background: Container(
                                color: ColorResources.red,
                                child: Stack(
                                    alignment: Alignment.centerRight,
                                    children: [
                                      Positioned(
                                        right: 76,
                                        child: Image.asset(
                                            width: 24,
                                            height: 24,
                                            "assets/common/delete.png"),
                                      ),
                                    ]),
                              ),
                              child: ProductItemWidget(
                                  item: product.keys.first,
                                  quality: product.values.firstOrNull ?? 0,
                                  isCart: true),
                            );
                          },
                        ),
                      ),
                      _summarySection(cartState.summary)
                    ],
                  );
                } else if (cartState is CartEmpty) {
                  return generalWidget(
                    title: "Empty Cart",
                    buttonText: "Go to shopping",
                    onEvent: () {
                      Navigator.pop(context);
                    },
                  );
                }
                return Container();
              },
            );
          },
        ),
      ),
    );
  }

  Widget _summarySection(SummaryModel data) {
    return Container(
      height: 163,
      color: ColorResources.lightPurple,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("Subtotal",
                  style: fontTitleMedium.copyWith(
                      color: ColorResources.primaryFixVariant)),
              Text(data.totalPriceBeforeDiscount.toStringAsFixed(2),
                  style: fontTitleMedium.copyWith(
                      color: ColorResources.primaryFixVariant))
            ]),
            const SizedBox(height: 4),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("Promotion discount",
                  style: fontTitleMedium.copyWith(
                      color: ColorResources.primaryFixVariant)),
              Text("-${data.totalDiscount.toStringAsFixed(2)}",
                  style: fontTitleMedium.copyWith(color: ColorResources.red))
            ]),
            const SizedBox(height: 16),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(data.totalNetPrice.toStringAsFixed(2),
                  style: fontHeadlineLarge.copyWith(
                      color: ColorResources.primaryFixVariant)),
              buttonTextWhite(
                  text: "Checkout",
                  onEvent: () {
                    checkOutBloc.add(CheckOut(
                        ProductRequest(products: data.productNetPrices)));
                  })
            ]),
          ],
        ),
      ),
    );
  }
}
