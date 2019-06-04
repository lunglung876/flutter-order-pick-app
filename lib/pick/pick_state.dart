import 'package:equatable/equatable.dart';
import 'package:warehouse_order_pick/models/item.dart';

class PickState extends Equatable {
  final List<Item> items;
  final String error;

  PickState(this.items, this.error) : super([items, error]);
}
