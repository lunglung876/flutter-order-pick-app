import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:warehouse_order_pick/models/item.dart';

import 'pick.dart';

class PickBloc extends Bloc<PickEvent, PickState> {
  final List<Item> items;

  PickBloc({@required this.items});

  @override
  PickState get initialState => PickState(items, '');

  @override
  Stream<PickState> mapEventToState(PickEvent event) async* {
    if (event is HandleInput) {
      var item = currentState.items.firstWhere(
          (item) =>
              item.sku == event.sku && item.quantity != item.quantityScanned,
          orElse: () => null);

      if (item != null) {
        List<Item> items = [];

        currentState.items.forEach((item) {
          int quantity =
              item.sku == event.sku && item.quantity != item.quantityScanned
                  ? 1
                  : 0;
          items.add(Item.incrementQuantity(item, quantity));
        });

        yield PickState(items, '');
      } else {
        yield PickState(items, 'Invalid SKU: ${event.sku}');
        yield PickState(items, '');
      }
    }
  }
}
