import 'package:fintech/features/home/domain/entities/product_entities.dart';

class ProductModel extends ProductEntities {
  const ProductModel({required super.id, required super.title, required super.description, required super.price, required super.categoryName, required super.categoryImage, required super.productImages});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(id: json['id'], title: json['title'], description: json['description'], price: json['price'], categoryName: json['category']['name'], categoryImage: json['category']['image'], productImages: List<String>.from(json['images']));
  }

  ProductEntities toEntity() => ProductEntities(id: id, title: title, description: description, price: price, categoryName: categoryName, categoryImage: categoryImage, productImages: productImages);
}
