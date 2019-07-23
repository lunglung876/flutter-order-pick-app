import 'package:equatable/equatable.dart';

class Item extends Equatable {
  int id;
  int quantity;
  int quantityScanned;
  String orderNumber;
  String sku;
  String brand;
  String name;
  String size;
  String image;
  String shelf;
  String box;
  String vendorCode;

  Item(
      this.id,
      this.quantity,
      this.orderNumber,
      this.sku,
      this.brand,
      this.name,
      this.size,
      this.image,
      this.shelf,
      this.box,
      this.vendorCode,
      this.quantityScanned)
      : super([
          id,
          quantity,
          orderNumber,
          sku,
          brand,
          name,
          size,
          image,
          shelf,
          box,
          vendorCode,
          quantityScanned
        ]);

  factory Item.fromJson(Map<String, dynamic> json, orderNumber) {
    final variant = json['variant'];
    print(variant);

    return Item(
        variant['id'],
        json['quantity'],
        orderNumber,
        variant['sku'],
        variant['_embedded']['brand_name'],
        variant['_embedded']['product_name'],
        variant['_embedded']['size'],
        variant['object']['images'][0]['_links']['small']['href'],
        variant['shelf'],
        variant['box'],
        variant['vendorCode'],
        0);
  }

  factory Item.incrementQuantity(Item item, int quantity) {
    return Item(
        item.id,
        item.quantity,
        item.orderNumber,
        item.sku,
        item.brand,
        item.name,
        item.size,
        item.image,
        item.shelf,
        item.box,
        item.vendorCode,
        item.quantityScanned + quantity);
  }
}
