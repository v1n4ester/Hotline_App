import 'package:flutter/material.dart';
import 'package:hotline_app/utils/app_phrases.dart';
import 'package:hotline_app/utils/extensions.dart';

class EmptyPlaceholder extends StatelessWidget {
  final Function() onPressed;

  const EmptyPlaceholder({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppPhrases.emptyPlaceholder,
          textAlign: TextAlign.center,
          style: context.textTheme.labelMedium,
        ),
        const SizedBox(height: 15),
        ElevatedButton(
          onPressed: onPressed,
          child: const Text(AppPhrases.repeatCaption),
        ),
      ],
    );
  }
}
