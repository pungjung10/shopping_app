import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/src/dashboard/tab/shopping/presentation/bloc/shopping_bloc.dart';

import '../../../../core/style/color_resource.dart';
import '../../../../core/style/text_styles.dart';
import '../../../../shared/widget/button_widget.dart';
import '../../../../shared/widget/snack_bar.dart';

class CartDashboard extends StatefulWidget {
  const CartDashboard({super.key});

  @override
  State<CartDashboard> createState() => _CartDashboardState();
}

class _CartDashboardState extends State<CartDashboard> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.white,
      appBar: AppBar(
        title: const Text("Cart", style: fontTitleLarge),
        backgroundColor: ColorResources.white,
      ),
      body: SafeArea(child:
          BlocBuilder<ShoppingBloc, ShoppingState>(builder: (context, state) {
        return Column(
          children: [
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: products.length,
            //     itemBuilder: (context, index) {
            //       String product = products[index];
            //       return Dismissible(
            //         key: Key(product),
            //         direction: DismissDirection.endToStart,
            //         onDismissed: (direction) {},
            //         background: Container(
            //           color: ColorResources.red,
            //           child: Stack(alignment: Alignment.centerRight, children: [
            //             Positioned(
            //               right: 76,
            //               child: Image.asset(
            //                   width: 24,
            //                   height: 24,
            //                   "assets/common/delete.png"),
            //             ),
            //           ]),
            //         ),
            //         child: ProductItemWidget(item: product),
            //       );
            //     },
            //   ),
            // ),
            _summarySection()
          ],
        );
      })),
    );
  }

  Widget _summarySection() {
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
              Text("3,845.00",
                  style: fontTitleMedium.copyWith(
                      color: ColorResources.primaryFixVariant))
            ]),
            const SizedBox(height: 4),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("Promotion discount",
                  style: fontTitleMedium.copyWith(
                      color: ColorResources.primaryFixVariant)),
              Text("-500.00",
                  style: fontTitleMedium.copyWith(color: ColorResources.red))
            ]),
            const SizedBox(height: 16),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("3,345.00",
                  style: fontHeadlineLarge.copyWith(
                      color: ColorResources.primaryFixVariant)),
              buttonTextWhite(
                  text: "Checkout",
                  onEvent: () {
                    ScaffoldMessenger.of(context).showSnackBar(snackBarWidget(
                        text: "Something went wrong",
                        onEvent: () {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        }));
                  })
            ]),
          ],
        ),
      ),
    );
  }
}
