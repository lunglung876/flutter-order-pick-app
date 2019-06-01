import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:warehouse_order_pick/models/item.dart';
import 'package:warehouse_order_pick/user_repository.dart';

class Api {
  static const host = 'hbx.com';
  static const endpoints = {
    'login': '/login_check',
    'getOrders': '/api/v2/warehouse/picking-orders',
    'confirmOrders': '/api/v2/warehouse/order/picked',
  };
  final userRepository = new UserRepository();

  Future<String> login({
    @required String username,
    @required String password,
  }) async {
    final uri = Uri.https(host, endpoints['login']);
    var request = new http.MultipartRequest("POST", uri);
    var json = jsonDecode(await rootBundle.loadString('assets/dev.json'));
    request.headers.addAll({'Accept': 'application/json'});
    request.fields['_username'] = json['username'];
    request.fields['_password'] = json['password'];

    var response = await request.send();
    final body = jsonDecode(await response.stream.bytesToString());

    return body['jwt_token'];
  }

  Future<List<Item>> getItems(List<String> orderNumbers) async {
    var items = <Item>[];
    final uri = new Uri.https(
        host, endpoints['getOrders'], {'orders': orderNumbers.join(',')});
    var response = await http.get(uri, headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await userRepository.getToken()}'
    });

    final body = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw Exception(body['message']);
    }

    final orders = body['orders'];

    orders.forEach((order) {
      order['items'].forEach((item) {
        items.add(new Item.fromJson(item, order['number']));
      });
    });

    return items;
  }
}
