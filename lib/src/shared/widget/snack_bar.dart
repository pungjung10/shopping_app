import 'package:flutter/material.dart';
import 'package:shopping_app/src/core/style/color_resource.dart';

import '../../core/style/text_styles.dart';

SnackBar snackBarWidget(
    {required String text, required void Function() onEvent}) {
  return SnackBar(
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.zero,
    padding: const EdgeInsets.only(left: 16),
    backgroundColor: ColorResources.red,
    content: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text, style: fontBodyMedium),
        IconButton(
          icon: const Icon(Icons.close, color: ColorResources.white),
          onPressed: () {
            onEvent();
          },
        ),
      ],
    ),
  );
}
