import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/src/core/style/text_styles.dart';
import 'package:shopping_app/src/feature/shopping/product_list/presentation/bloc/product_list_bloc.dart';
import 'package:shopping_app/src/feature/shopping/product_recommend_list/presentation/bloc/recommended_product_list_bloc.dart';
import 'package:shopping_app/src/feature/shopping/product_recommend_list/presentation/recommended_product_list.dart';

import '../../../../feature/shopping/product_list/presentation/product_list.dart';

class ShoppingDashboard extends StatefulWidget {
  const ShoppingDashboard({super.key});

  @override
  State<ShoppingDashboard> createState() => _ShoppingDashboardState();
}

class _ShoppingDashboardState extends State<ShoppingDashboard> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoadMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    BlocProvider.of<ProductListBloc>(context).add(ProductListLoadData());
    BlocProvider.of<RecommendedProductListBloc>(context)
        .add(RecommendedProductListLoadData());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      BlocProvider.of<ProductListBloc>(context).add(ProductListLoadMoreData());
      setState(() {
        _isLoadMore = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text("Recommend Product", style: fontTitleLarge),
            ),
            const RecommendedProductList(),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text("Latest Products", style: fontTitleLarge),
            ),
            const ProductList(),
            if (_isLoadMore)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth:3)),
                    SizedBox(width: 12),
                    Text(
                      "Loading..",
                      style: fontTitleSmall,
                    )
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
