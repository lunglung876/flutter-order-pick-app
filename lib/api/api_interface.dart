import 'package:flutter/foundation.dart';
import 'package:warehouse_order_pick/models/item.dart';

abstract class ApiInterface {
  Future<String> login({
    @required String username,
    @required String password,
  });

  Future<List<Item>> getItems(List<String> orderNumbers);
}
