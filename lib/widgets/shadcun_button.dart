import 'package:flutter/material.dart';

enum ShadcnButtonVariant {
  primary,
  secondary,
  destructive,
  outline,
  ghost,
  link,
}

enum ShadcnButtonSize { sm, md, lg, icon }

class ShadcnButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final ShadcnButtonVariant variant;
  final ShadcnButtonSize size;
  final IconData? icon;
  final bool widthFull;

  const ShadcnButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.variant = ShadcnButtonVariant.primary,
    this.size = ShadcnButtonSize.md,
    this.icon,
    this.widthFull = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widthFull ? double.infinity : null,
      height: _getHeight(),
      child: ElevatedButton(
        onPressed: onPressed,
        style: _getStyle(context),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: _getIconSize()),
              if (text.isNotEmpty) const SizedBox(width: 8),
            ],
            if (text.isNotEmpty) Text(text, style: _getTextStyle()),
          ],
        ),
      ),
    );
  }

  double _getHeight() {
    switch (size) {
      case ShadcnButtonSize.sm:
        return 36;
      case ShadcnButtonSize.lg:
        return 44;
      case ShadcnButtonSize.icon:
        return 40;
      case ShadcnButtonSize.md:
      default:
        return 40;
    }
  }

  double _getIconSize() {
    switch (size) {
      case ShadcnButtonSize.sm:
        return 16;
      case ShadcnButtonSize.lg:
        return 20;
      default:
        return 18;
    }
  }

  TextStyle _getTextStyle() {
    return TextStyle(
      fontSize: size == ShadcnButtonSize.sm ? 13.0 : 14.0,
      fontWeight: FontWeight.w500,
    );
  }

  ButtonStyle _getStyle(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    Color backgroundColor;
    Color foregroundColor;
    Color? borderColor;
    double elevation = 0;

    switch (variant) {
      case ShadcnButtonVariant.primary:
        backgroundColor = theme.colorScheme.primary;
        foregroundColor = theme.colorScheme.onPrimary;
        break;
      case ShadcnButtonVariant.secondary:
        backgroundColor = theme.colorScheme.secondary;
        foregroundColor = theme.colorScheme.onSecondary;
        break;
      case ShadcnButtonVariant.destructive:
        backgroundColor = theme.colorScheme.error;
        foregroundColor = theme.colorScheme.onError;
        break;
      case ShadcnButtonVariant.outline:
        backgroundColor = Colors.transparent;
        foregroundColor = theme.colorScheme.onSurface;
        borderColor = theme.colorScheme.outline;
        break;
      case ShadcnButtonVariant.ghost:
        backgroundColor = Colors.transparent;
        foregroundColor = theme.colorScheme.onSurface;
        break;
      case ShadcnButtonVariant.link:
        backgroundColor = Colors.transparent;
        foregroundColor = theme.colorScheme.primary;
        break;
    }

    return ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.hovered)) {
          if (variant == ShadcnButtonVariant.ghost ||
              variant == ShadcnButtonVariant.outline) {
            return isDark
                ? Colors.white.withValues(alpha: 0.1)
                : Colors.grey.shade100;
          }
          if (variant == ShadcnButtonVariant.link) return Colors.transparent;

          // Slight opacity change for solid buttons
          return backgroundColor.withValues(alpha: 0.9);
        }
        return backgroundColor;
      }),
      overlayColor: WidgetStateProperty.all(
        Colors.transparent,
      ), // Manage hover via bg color
      foregroundColor: WidgetStateProperty.all(foregroundColor),
      elevation: WidgetStateProperty.all(elevation),
      side:
          borderColor != null
              ? WidgetStateProperty.all(BorderSide(color: borderColor))
              : null,
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      padding: WidgetStateProperty.all(
        EdgeInsets.symmetric(
          horizontal: size == ShadcnButtonSize.icon ? 0 : 16,
        ),
      ),
    );
  }
}