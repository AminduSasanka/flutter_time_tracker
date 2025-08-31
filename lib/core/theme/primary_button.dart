import 'package:flutter/material.dart';

enum ButtonType { primary, secondary, danger }

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonType type;
  final bool fullWidth;
  final IconData? icon;
  final bool iconAtEnd;
  final bool isLoading;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.type = ButtonType.primary,
    this.fullWidth = false,
    this.icon,
    this.iconAtEnd = false,
    this.isLoading = false,
  });

  Color _getBackgroundColor() {
    switch (type) {
      case ButtonType.secondary:
        return Colors.grey.shade600;
      case ButtonType.danger:
        return Colors.red.shade600;
      case ButtonType.primary:
      default:
        return const Color(0xFF4A90E2);
    }
  }

  @override
  Widget build(BuildContext context) {
    final buttonChild = isLoading
        ? SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          )
        : (icon == null
              ? Text(text)
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (!iconAtEnd) Icon(icon, size: 18),
                    if (!iconAtEnd) const SizedBox(width: 8),
                    Text(text),
                    if (iconAtEnd) const SizedBox(width: 8),
                    if (iconAtEnd) Icon(icon, size: 18),
                  ],
                ));

    return SizedBox(
      width: fullWidth ? double.infinity : null,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(backgroundColor: _getBackgroundColor()),
        child: buttonChild,
      ),
    );
  }
}
