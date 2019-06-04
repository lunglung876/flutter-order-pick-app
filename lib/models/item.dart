class Item {
  int id;
  int quantity;
  int quantityScanned = 0;
  String orderNumber;
  String sku;
  String brand;
  String name;
  String size;
  String image;
  String shelf;
  String box;
  String vendorCode;

  Item({this.id, this.quantity, this.orderNumber, this.sku, this.brand, this.name, this.size,
      this.image, this.shelf, this.box, this.vendorCode});

  factory Item.fromJson(Map<String, dynamic> json, orderNumber) {
    final variant = json['variant'];

    return Item(
      orderNumber: orderNumber,
      id: variant['id'],
      quantity: json['quantity'],
      sku: variant['sku'],
      brand: variant['_embedded']['brand_name'],
      name: variant['_embedded']['product_name'],
      size: variant['_embedded']['size'],
      image: variant['object']['images'][0]['_links']['small']['href'],
      shelf: variant['shelf'],
      box: variant['box'],
      vendorCode: variant['vendorCode']
    );
  }
}
