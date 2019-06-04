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
      var items = List<Item>.from(currentState.items);

        var item = items.firstWhere((item) => item.sku == event.sku && item.quantity != item.quantityScanned, orElse: () => null);

        if (item != null) {
          item.quantityScanned ++;

          yield PickState(items, '');
        } else {
          yield PickState(items, 'Invalid SKU: ${event.sku}');
          yield PickState(items, '');
        }
    }
  }
}