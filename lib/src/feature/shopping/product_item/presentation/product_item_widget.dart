import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/src/dashboard/tab/shopping/bloc/shopping_bloc.dart';

import '../../../../shared/widget/button_widget.dart';

class ProductItemWidget extends StatelessWidget {
  final String product;

  const ProductItemWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.image, size: 40, color: Colors.grey[600]),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.deepPurple[900]),
                ),
                const SizedBox(height: 4),
                Text(
                  "59.00 / unit",
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          BlocBuilder<ShoppingBloc, ShoppingState>(
            builder: (context, state) {
              int quantity = 0;
              return quantity > 0
                  ? Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove,
                              color: Colors.deepPurple),
                          onPressed: () => {},
                        ),
                        Text(quantity.toString(),
                            style: const TextStyle(fontSize: 16)),
                        IconButton(
                          icon: const Icon(Icons.add, color: Colors.deepPurple),
                          onPressed: () => {},
                        ),
                      ],
                    )
                  : buttonTextWhite(text: "Add to cart", onEvent: () {});
            },
          ),
        ],
      ),
    );
  }
}
