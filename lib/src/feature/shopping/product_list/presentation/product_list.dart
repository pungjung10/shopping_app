import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/src/core/style/text_styles.dart';
import 'package:shopping_app/src/dashboard/tab/shopping/domain/model/item_model.dart';
import 'package:shopping_app/src/dashboard/tab/shopping/domain/model/product_model.dart';
import 'package:shopping_app/src/dashboard/tab/shopping/domain/shopping_data.dart';
import 'package:shopping_app/src/dashboard/tab/shopping/presentation/bloc/shopping_bloc.dart';

import '../../../../feature/shopping/product_item/presentation/product_item_loading_widget.dart';
import '../../../../feature/shopping/product_item/presentation/product_item_widget.dart';
import '../../../../shared/widget/general_page_state_widget.dart';

class ShoppingDashboard extends StatefulWidget {
  const ShoppingDashboard({super.key});

  @override
  State<ShoppingDashboard> createState() => _ShoppingDashboardState();
}

class _ShoppingDashboardState extends State<ShoppingDashboard> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<ShoppingBloc>(context).add(ProductLoadData());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShoppingBloc, ShoppingState>(
      builder: (context, state) {
        List<Widget> widgetList = [];
        if (state is ShoppingLoading) {
          widgetList.add(_buildLoadingScreen());
        } else if (state is ProductSuccess) {
          List<Widget> list = [];
          for (var product in state.product) {
            list = _buildProductList(product);
          }
          widgetList.addAll(list);
        }
        return ListView.builder(
          itemCount: widgetList.length,
          itemBuilder: (context, index) {
            return widgetList[index];
          },
        );
      },
    );
  }

  List<Widget> _buildProductList(ProductListModel products) {
    List<Widget> list = [];
    switch (products.itemType) {
      case ProductType.products:
        {
          list.add(const Text("Latest Products", style: fontTitleLarge));
        }
      case ProductType.recommendedProducts:
        {
          list.add(const Text("Recommend Product", style: fontTitleLarge));
        }
    }
    if (products.state == ProductState.error) {
      list.add(generalWidget(
          title: "Something went wrong",
          image: "assets/common/cancel.png",
          buttonText: "Refresh",
          onEvent: () {}));
    } else {
      list.add(ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: products.items.length,
        itemBuilder: (context, index) {
          ItemModel item = products.items[index];
          return ProductItemWidget(item: item);
        },
      ));
    }
    return list;
  }

  Widget _buildLoadingScreen() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Recommend Product", style: fontTitleLarge),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            itemBuilder: (context, index) {
              return const ProductItemLoadingWidget();
            },
          ),
          const Text("Latest Products", style: fontTitleLarge),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            itemBuilder: (context, index) {
              return const ProductItemLoadingWidget();
            },
          ),
        ],
      ),
    );
  }
}
