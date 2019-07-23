import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'api_interface.dart';
import 'package:warehouse_order_pick/models/item.dart';
import 'package:warehouse_order_pick/user_repository.dart';

class MockApi extends ApiInterface {
  final userRepository = new UserRepository();

  @override
  Future<String> login({
    @required String username,
    @required String password,
  }) async {
    if (username != 'test' || password != 'test') {
      throw Exception('Incorrect username / password');
    }

    return '1234';
  }

  @override
  Future<List<Item>> getItems(List<String> orderNumbers) async {
    var items = <Item>[];

    await Future.forEach(orderNumbers, (number) async {
      Map json;

      if (number == '694260') {
        json = jsonDecode(await rootBundle.loadString('assets/order_694260.json'));
      } else if (number == '694428') {
        json = jsonDecode(await rootBundle.loadString('assets/order_694428.json'));
      } else {
        throw Exception('Order #$number not found.');
      }

      json['items'].forEach((item) {
        items.add(new Item.fromJson(item, number));
      });
    });

    return items;
  }
}
