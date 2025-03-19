import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/src/feature/shopping/product_item/presentation/product_item_loading_widget.dart';
import 'package:shopping_app/src/feature/shopping/product_recommend_list/presentation/bloc/recommended_product_list_bloc.dart';

import '../../../../feature/shopping/product_item/presentation/product_item_widget.dart';
import '../../../../shared/widget/general_page_state_widget.dart';

class RecommendedProductList extends StatefulWidget {
  const RecommendedProductList({super.key});

  @override
  State<RecommendedProductList> createState() => _RecommendedProductListState();
}

class _RecommendedProductListState extends State<RecommendedProductList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecommendedProductListBloc, RecommendedProductListState>(
      builder: (context, state) {
        if (state is RecommendedProductListLoading) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            itemBuilder: (context, index) {
              return const ProductItemLoadingWidget();
            },
          );
        } else if (state is RecommendProductListSuccess) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.product.length,
            itemBuilder: (context, index) {
              return ProductItemWidget(
                  item: state.product[index], quality: 0, isCart: false);
            },
          );
        } else if (state is RecommendedProductListError) {
          return generalWidget(
              title: "Something went wrong",
              image: "assets/common/cancel.png",
              buttonText: "Refresh",
              onEvent: () {
                BlocProvider.of<RecommendedProductListBloc>(context)
                    .add(RecommendedProductListLoadData());
              });
        }
        return const SizedBox.shrink();
      },
    );
  }
}
