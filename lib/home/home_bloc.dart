import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:warehouse_order_pick/home/home.dart';

import 'home.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  @override
  HomeState get initialState => HomeInitState();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is KeyPressed) {
      final keyEvent = event.keyEvent;

      if (keyEvent is RawKeyDownEvent) {
        final key = handleKey(keyEvent.data);
        if (key == 'enter') {
          var orderNumbers = currentState.orderNumbers;
          var buffer = currentState.inputBuffer;

          if (buffer != '' && !orderNumbers.contains(buffer)) {
            orderNumbers.add(buffer);
          }

          yield HomeInputState(inputBuffer: '', orderNumbers: orderNumbers);
        } else {
          yield HomeInputState(
              inputBuffer: currentState.inputBuffer + key,
              orderNumbers: currentState.orderNumbers);
        }
      }
    }
  }

  String handleKey(RawKeyEventDataAndroid data) {
    if (data.keyCode == 66) {
      return 'enter';
    } else if (![120, 59].contains(data.keyCode)) {
      const int combiningCharacterMask = 0x7fffffff;

      return String.fromCharCode(combiningCharacterMask & data.codePoint);
    }

    return '';
  }
}
