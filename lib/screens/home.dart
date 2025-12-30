import 'package:flutter/material.dart';
import 'package:invoice/widgets/shadcun_button.dart';
import 'package:invoice/screens/sale.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ShadcnButton(
        text: 'Sale',
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => const Sale()));
        },
        size: ShadcnButtonSize.md,
        variant: ShadcnButtonVariant.primary,
      ),
    );
  }
}
