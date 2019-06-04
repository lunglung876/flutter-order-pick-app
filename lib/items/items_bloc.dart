import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:warehouse_order_pick/api/api.dart';

import 'items.dart';

class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {
  final api = Api();

  @override
  ItemsState get initialState => ItemsInitial();

  @override
  Stream<ItemsState> mapEventToState(ItemsEvent event) async* {
    if (event is LoadOrderButtonPressed) {
      yield ItemsLoading();

      try {
        final items = await api.getItems(event.orderNumbers);

        yield ItemsLoaded(items: items);
      } catch (e) {
        yield ItemsError(error: e.message);
      }
    }
  }
}