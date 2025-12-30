import 'package:flutter/material.dart';
import 'package:invoice/models/products.dart';
import 'package:invoice/models/cart_item.dart';
import 'package:invoice/widgets/animated_snackbar.dart';
import 'package:invoice/widgets/product_item.dart';

class Sale extends StatefulWidget {
  const Sale({super.key});

  @override
  State<Sale> createState() => _SaleState();
}

class _SaleState extends State<Sale> {
  final List<CartItem> _cartItems = [];

  void _addToCart(Product product) {
    setState(() {
      final existingIndex = _cartItems.indexWhere(
        (item) => item.product.name == product.name,
      );
      if (existingIndex != -1) {
        _cartItems[existingIndex].quantity++;
      } else {
        _cartItems.add(CartItem(product: product));
      }
    });
    showAnimatedSnackBar(context, '${product.name} added to cart');
  }

  void _removeFromCart(CartItem item) {
    setState(() {
      _cartItems.remove(item);
    });
  }

  void _incrementQuantity(CartItem item) {
    setState(() {
      item.quantity++;
    });
  }

  void _decrementQuantity(CartItem item) {
    setState(() {
      if (item.quantity > 1) {
        item.quantity--;
      } else {
        _cartItems.remove(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Product> products = Product.getProducts();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sale'),
        actions: [
          IconButton(
            icon: Badge(
              label: Text(_cartItems.length.toString()),
              child: const Icon(Icons.shopping_cart),
            ),
            onPressed: () {
              saleCart(
                context,
                _cartItems,
                _removeFromCart,
                _incrementQuantity,
                _decrementQuantity,
              );
            },
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 160,
          crossAxisSpacing: 15,
          mainAxisSpacing: 10,
          childAspectRatio: 0.8,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              _addToCart(products[index]);
            },
            child: ProductItem(product: products[index]),
          );
        },
      ),
    );
  }
}

Future<dynamic> saleCart(
  BuildContext context,
  List<CartItem> cartItems,
  Function(CartItem) onRemove,
  Function(CartItem) onIncrement,
  Function(CartItem) onDecrement,
) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Container(
            padding: const EdgeInsets.all(16),
            height: MediaQuery.of(context).size.height * 0.6,
            child: Column(
              children: [
                const Text(
                  'Cart Items',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child:
                      cartItems.isEmpty
                          ? const Center(child: Text('Your cart is empty'))
                          : ListView.separated(
                            itemCount: cartItems.length,
                            separatorBuilder:
                                (ctx, i) =>
                                    const Divider(height: 30, thickness: 0.5),
                            itemBuilder: (context, index) {
                              final item = cartItems[index];
                              return Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      item.product.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      item.product.price.toStringAsFixed(1),
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          onDecrement(item);
                                          setState(() {});
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: const BoxDecoration(
                                            color: Colors.orange,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.remove,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 30,
                                        child: Text(
                                          item.quantity.toStringAsFixed(1),
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          onIncrement(item);
                                          setState(() {});
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: const BoxDecoration(
                                            color: Colors.orange,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      item.total.toStringAsFixed(1),
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: Colors.grey[800],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  InkWell(
                                    onTap: () {
                                      onRemove(item);
                                      setState(() {});
                                    },
                                    child: const Icon(
                                      Icons.delete_outline,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
