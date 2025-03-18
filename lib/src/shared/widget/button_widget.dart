import 'package:flutter/material.dart';
import 'package:shopping_app/src/core/color_resource.dart';
import 'package:shopping_app/src/core/text_styles.dart';

FilledButton buttonTextWhite(
    {required String text, required void Function() onEvent}) {
  return FilledButton(
      style: FilledButton.styleFrom(
          fixedSize: const Size(double.infinity, 40),
          backgroundColor: ColorResources.primary),
      onPressed: () => onEvent(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1),
          child: Text(
            text,
            style: fontLarge.copyWith(color: ColorResources.white),
            textAlign: TextAlign.center,
          ),
        ),
      ));
}
