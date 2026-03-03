import 'package:fintech/features/home/domain/entities/product_entities.dart';
import 'package:isar/isar.dart';

import '../../../../core/storage/isar_model.dart';

part 'cart_item_model.g.dart';

@collection
class CartItemModel implements IsarModel {
  @override
  Id id = Isar.autoIncrement;
  @Index(unique: true, replace: true)
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
