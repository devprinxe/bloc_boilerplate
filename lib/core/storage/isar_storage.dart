import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';

import '../../features/cart/data/models/cart_item_model.dart';
import 'isar_model.dart';

@lazySingleton
class IsarStorage {
  final Isar _isar;

  IsarStorage(this._isar);

  // CREATE / UPDATE
  Future<void> put<T extends IsarModel>(T item) async {
    await _isar.writeTxn(() async {
      await _isar.collection<T>().put(item);
    });
  }

  // READ ALL
  Future<List<T>> getAll<T extends IsarModel>() async {
    return await _isar.collection<T>().where().findAll();
  }

  // READ BY ID
  Future<T?> getById<T extends IsarModel>(Id id) async {
    return await _isar.collection<T>().get(id);
  }

  // DELETE
  Future<bool> delete<T extends IsarModel>(Id id) async {
    return await _isar.writeTxn(() async {
      return await _isar.collection<T>().delete(id);
    });
  }

  // CLEAR COLLECTION
  Future<void> clear<T extends IsarModel>() async {
    await _isar.writeTxn(() async {
      await _isar.collection<T>().clear();
    });
  }

  Future<bool> isProductInCart(String productId) async {
    // This uses the generated code which is extremely fast
    final count = await _isar.cartItemModels.filter().productIdEqualTo(productId).count();

    return count > 0;
  }
}
