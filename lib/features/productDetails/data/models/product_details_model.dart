import 'package:fintech/features/productDetails/domain/entities/product_details.dart';

class ProductDetailsModel {
  num? id;
  String? title;
  String? description;
  num? price;
  String? categoryName;
  String? categoryImage;
  List<String>? productImages;

  ProductDetailsModel({this.id, this.title, this.description, this.price, this.categoryName, this.categoryImage, this.productImages});

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailsModel(id: json['id'], title: json['title'], description: json['description'], price: json['price'], categoryName: json['category']['name'], categoryImage: json['category']['image'], productImages: List<String>.from(json['images']));
  }

  ProductDetailsEntities toEntity() => ProductDetailsEntities(id: id ?? 0, title: title ?? "", description: description ?? "", price: price ?? 0, categoryName: categoryName ?? "", categoryImage: categoryImage ?? "", productImages: productImages ?? []);
}
