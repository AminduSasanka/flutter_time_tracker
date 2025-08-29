import 'package:flutter/material.dart';

enum ButtonType { primary, secondary, danger }

class OutlinedActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonType type;
  final bool fullWidth;
  final IconData? icon;
  final bool iconAtEnd;
  final bool isLoading;

  const OutlinedActionButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.type = ButtonType.primary,
    this.fullWidth = false,
    this.icon,
    this.iconAtEnd = false,
    this.isLoading = false,
  });

  Color _getBorderColor() {
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
    final borderColor = _getBorderColor();

    final buttonChild = isLoading
        ? SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(borderColor),
            ),
          )
        : (icon == null
              ? Text(text, style: TextStyle(color: borderColor))
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (!iconAtEnd) Icon(icon, size: 18, color: borderColor),
                    if (!iconAtEnd) const SizedBox(width: 8),
                    Text(text, style: TextStyle(color: borderColor)),
                    if (iconAtEnd) const SizedBox(width: 8),
                    if (iconAtEnd) Icon(icon, size: 18, color: borderColor),
                  ],
                ));

    return SizedBox(
      width: fullWidth ? double.infinity : null,
      child: OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: borderColor, width: 2),
          foregroundColor: borderColor,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: buttonChild,
      ),
    );
  }
}
