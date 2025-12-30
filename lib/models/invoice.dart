class Invoice {
  final String id;
  final DateTime date;
  final List<InvoiceItem> items;

  // Logic: The model handles the math
  double get subtotal => items.fold(0, (sum, item) => sum + item.total);
  double get taxRate => 0.10; // Example: 10% tax hardcoded for MVP
  double get taxAmount => subtotal * taxRate;
  double get total => subtotal + taxAmount;

  Invoice({required this.id, required this.date, required this.items});

  // Helper for UI: #001, #002, etc.
  String get displayId => '#${id.padLeft(3, '0')}';
}

class InvoiceItem {
  final String name;
  final double quantity;
  final double price;

  double get total => quantity * price;

  InvoiceItem({
    required this.name,
    required this.quantity,
    required this.price,
  });
}
