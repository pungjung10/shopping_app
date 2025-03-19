import 'package:flutter/cupertino.dart';
import 'package:shopping_app/src/core/style/text_styles.dart';
import 'package:shopping_app/src/shared/widget/button_widget.dart';

Widget generalWidget({String? image,
  required String title,
  String? description,
  required String buttonText,
  required void Function() onEvent}) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (image != null)
            Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          Text(title, style: fontTitleLarge),

          if (description != null) ...[
            const SizedBox(height: 10),
            Text(description, style: fontTitleSmall),
          ],
          const SizedBox(height: 10),
          IntrinsicWidth(
              child: buttonTextWhite(text: buttonText, onEvent: () => onEvent()))
        ],
      ),
    ),
  );
}
