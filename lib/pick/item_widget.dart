import 'package:flutter/material.dart';

import 'package:warehouse_order_pick/models/item.dart';

class ItemWidget extends StatelessWidget {
  final Item item;

  ItemWidget({this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Image.network(
              item.image,
              width: 150,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Text(item.brand),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Text(item.name),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Text('Size: ${item.size}'),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Text('SKU: ${item.sku}'),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Text('Location: ${item.shelf}-${item.box}'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Quantity: ${item.quantity}'),
              Text('Quantity Scanned: ${item.quantityScanned}'),
            ],
          ),
        ],
      ),
    );
  }
}
