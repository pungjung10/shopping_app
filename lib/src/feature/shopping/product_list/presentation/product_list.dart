import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/src/feature/shopping/product_item/presentation/product_item_loading_widget.dart';
import 'package:shopping_app/src/feature/shopping/product_list/presentation/bloc/product_list_bloc.dart';

import '../../../../feature/shopping/product_item/presentation/product_item_widget.dart';
import '../../../../shared/widget/general_page_state_widget.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductListBloc, ProductListState>(
      builder: (context, state) {
        if (state is ProductListLoading) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 6,
            itemBuilder: (context, index) {
              return const ProductItemLoadingWidget();
            },
          );
        } else if (state is ProductListSuccess) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.product.items.length,
            itemBuilder: (context, index) {
              return ProductItemWidget(item: state.product.items[index], quality: 0, isCart: false);
            },
          );
        } else if (state is ProductListError) {
          return generalWidget(
              title: "Something went wrong",
              image: "assets/common/cancel.png",
              buttonText: "Refresh",
              onEvent: () {
                BlocProvider.of<ProductListBloc>(context).add(ProductListLoadData());
              });
        }
        return const SizedBox.shrink();
      },
    );
  }
}
