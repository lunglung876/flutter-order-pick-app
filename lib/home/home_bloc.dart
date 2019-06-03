import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:warehouse_order_pick/api/api.dart';
import 'package:warehouse_order_pick/home/home.dart';
import 'package:warehouse_order_pick/models/item.dart';

import 'home.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final api = Api();

  @override
  HomeState get initialState => HomeState.initial();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is KeyPressed) {
      final keyEvent = event.keyEvent;

      if (keyEvent is RawKeyDownEvent) {
        final key = handleKey(keyEvent.data);
        if (key == 'enter') {
          var orderNumbers = List<String>.from(currentState.orderNumbers);
          var buffer = currentState.inputBuffer;

          if (buffer != '' && !orderNumbers.contains(buffer)) {
            orderNumbers.add(buffer);
          }

          yield updateState(inputBuffer: '', orderNumbers: orderNumbers);
        } else {
          yield updateState(inputBuffer: currentState.inputBuffer + key);
        }
      }
    }

    if (event is LoadOrders) {
      yield updateState(loading: true);
      try {
        final items = await api.getItems(currentState.orderNumbers);

        yield updateState(loading: false, items: items);
      } catch (e) {
        yield updateState(loading: false, error: e.message);
      }

      yield updateState(loading: false);
    }

    if (event is DisplayedError) {
      yield updateState(error: '');
    }

    if (event is RemoveOrder) {
      var orderNumbers = List<String>.from(currentState.orderNumbers);
      orderNumbers.remove(event.orderNumber);

      yield updateState(orderNumbers: orderNumbers);
    }
  }

  // Determine which key was pressed
  String handleKey(RawKeyEventDataAndroid data) {
    // Key code of 'Enter' key is 66
    if (data.keyCode == 66) {
      return 'enter';
    } else if (![120, 59].contains(data.keyCode)) {
      // Convert keycode to character
      const int combiningCharacterMask = 0x7fffffff;

      return String.fromCharCode(combiningCharacterMask & data.codePoint);
    }

    return '';
  }

  // Helper function to create new state
  HomeState updateState(
      {String inputBuffer,
      List<String> orderNumbers,
      bool loading,
      List<Item> items,
      String error}) {
    return HomeState(
        inputBuffer ?? currentState.inputBuffer,
        orderNumbers ?? currentState.orderNumbers,
        loading ?? currentState.loading,
        items ?? currentState.items,
        error ?? currentState.error);
  }
}
