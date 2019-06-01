import 'package:equatable/equatable.dart';
import 'package:warehouse_order_pick/models/item.dart';

class HomeState extends Equatable {
  String inputBuffer;
  List<String> orderNumbers;
  bool loading;
  List<Item> items;
  String error;

  HomeState(
      this.inputBuffer, this.orderNumbers, this.loading, this.items, this.error)
      : super([inputBuffer, orderNumbers, loading, items, error]);

  HomeState.initial() {
    this.inputBuffer = '';
    this.orderNumbers = [];
    this.loading = false;
    this.items = [];
    this.error = '';
  }
}
