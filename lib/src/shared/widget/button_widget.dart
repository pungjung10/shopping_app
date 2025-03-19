import 'package:flutter/material.dart';
import 'package:shopping_app/src/core/style/color_resource.dart';
import 'package:shopping_app/src/core/style/text_styles.dart';

FilledButton buttonTextWhite(
    {required String text, required void Function() onEvent}) {
  return FilledButton(
      style: FilledButton.styleFrom(
          fixedSize: const Size(double.infinity, 40),
          backgroundColor: ColorResources.primary),
      onPressed: () => onEvent(),
      child: Center(
        child: Text(
          text,
          style: fontLarge.copyWith(color: ColorResources.white),
          textAlign: TextAlign.center,
        ),
      ));
}

IconButton buttonIcon(
    {required IconData icon, required void Function() onEvent}) {
  return IconButton(
    icon:  Container(
      decoration: BoxDecoration(
        color: ColorResources.primary,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: ColorResources.white,
      ),
    ),
    onPressed: () => onEvent(),
  );
}
