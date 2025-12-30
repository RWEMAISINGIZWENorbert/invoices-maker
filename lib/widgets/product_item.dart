import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:invoice/models/products.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  // color: products[index].color,
                                  color: Colors.amber,
                                ),
                                child: Center(
                                  child: Text(
                                    // state.products[index].productName[0].toUpperCase(),
                                    product.name[0].toUpperCase(),
                                    style:  const TextStyle(
                                        // color: Theme.of(context).hintColor,
                                        color: Colors.white,
                                        fontSize: 28),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 7),
                              Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 1),
                                  child: Text(
                                    product.name,
                                    style: GoogleFonts.poppins(color: Colors.grey[800],fontSize: 12,fontWeight: FontWeight.w400,decoration: TextDecoration.none),
                                  )
                              ),
   
                               Text(
                                    '${product.price.toStringAsFixed(2)} ',
                                    ) 
                            ],
                          ),
                        );
  }
}