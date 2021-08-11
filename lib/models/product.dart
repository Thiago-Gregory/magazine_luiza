import 'package:magazine_luiza/models/forward_price.dart';

class Product {
  final String photo;
  final String name;
  final String description;
  final double price;
  final int installments;
  final int interestRate;
  bool isFavorite;

  Product({
    required this.photo,
    required this.name,
    required this.description,
    required this.price,
    required this.installments,
    required this.interestRate,
    this.isFavorite = false,
  });

  double getInstallmentPrice(double price){
    return price / this.installments * (1 + (this.interestRate / 100));
  }
}
