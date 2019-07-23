import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:warehouse_order_pick/api/mock_api.dart';

import 'items.dart';

class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {
  final api = MockApi();

  @override
  ItemsState get initialState => ItemsInitial();

  @override
  Stream<ItemsState> mapEventToState(ItemsEvent event) async* {
    if (event is LoadOrderButtonPressed) {
      yield ItemsLoading();

      try {
        final items = await api.getItems(event.orderNumbers);

        // Sort items by shelf. The order is TIMES > A > AA > Z > Z8.
        items.sort((a, b) {
          RegExp regex = RegExp('^(TIMES|Z8|Z\/|[A-Z]{1,2})');
          Match areaMatchesA = regex.firstMatch(a.shelf);
          Match areaMatchesB = regex.firstMatch(b.shelf);

          if (null == areaMatchesA || null == areaMatchesB) {
            return 0;
          }

          String areaA = areaMatchesA.group(0);
          String areaB = areaMatchesB.group(0);

          if (areaA == 'TIMES') {
            return -1;
          } else if (areaB == 'TIMES') {
            return 1;
          }

          if (areaA == areaB) {
            return a.shelf.compareTo(b.shelf);
          }

          if (areaA.length != areaB.length) {
            return (areaA.length < areaB.length ? -1 : 1);
          }

          return areaA.compareTo(areaB);
        });

        yield ItemsLoaded(items: items);
      } catch (e) {
        yield ItemsError(error: e.message);
      }
    }
  }
}