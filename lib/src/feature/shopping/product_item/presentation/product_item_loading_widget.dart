import 'package:flutter/material.dart';
import 'package:shopping_app/src/core/style/color_resource.dart';

class ProductItemLoadingWidget extends StatelessWidget {
  const ProductItemLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 152,
                height: 18,
                decoration: BoxDecoration(
                  color: ColorResources.gray,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 96,
                height: 22,
                decoration: BoxDecoration(
                  color: ColorResources.gray,
                  borderRadius: BorderRadius.circular(12),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
