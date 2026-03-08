import 'package:equatable/equatable.dart';

class ProductDetailsEntities extends Equatable {
  final num id;
  final String title;
  final String description;
  final num price;
  final String categoryName;
  final String categoryImage;
  final List<String> productImages;

  const ProductDetailsEntities({required this.id, required this.title, required this.description, required this.price, required this.categoryName, required this.categoryImage, required this.productImages});

  @override
  List<Object?> get props => [id, title, description, price, categoryName, categoryImage, productImages];
}
