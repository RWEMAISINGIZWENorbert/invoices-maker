
class Product {
  final String name;
  final double price;

  Product({required this.name, required this.price});

  static List<Product> products = [
    Product(name: 'Product 1', price: 10.0),
    Product(name: 'Product 2', price: 20.0),
    Product(name: 'Product 3', price: 30.0),
  ];

  static List<Product> getProducts() {
    return products;
  }
}