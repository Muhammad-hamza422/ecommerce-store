import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isPrimary;
  final bool isLoading;
  final ButtonStyle? style;

  const CustomButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isPrimary = true,
    this.isLoading = false,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final defaultStyle = ElevatedButton.styleFrom(
      backgroundColor: isPrimary ? colorScheme.primary : colorScheme.secondary,
      foregroundColor:
          isPrimary ? colorScheme.onPrimary : colorScheme.onSecondary,
    );

    final btn = ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: style ?? defaultStyle,

      child:
          isLoading
              ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    colorScheme.onPrimary,
                  ),
                ),
              )
              : Text(label),
    );
    return SizedBox(width: double.infinity, child: btn);
  }
}
