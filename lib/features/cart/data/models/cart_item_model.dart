import 'package:fintech/features/home/domain/entities/product_entities.dart';

class CartItemModel {
  late String productId;
  late String title;
  late String description;
  late double price;
  late String category;
  late String image;
  late int quantity;

  static CartItemModel fromProductEntity(ProductEntities entity, int qty) {
    return CartItemModel()
      ..productId = entity.id.toString()
      ..title = entity.title
      ..description = entity.description
      ..price = entity.price.toDouble()
      ..category = entity.categoryName
      ..image = entity.productImages.first
      ..quantity = qty;
  }
}
