import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:warehouse_order_pick/home/home.dart';
import 'package:flutter/services.dart';

import 'barcode_scanner.dart';
import 'package:warehouse_order_pick/home/home.dart';

class BarcodeScannerBloc extends Bloc<BarcodeScannerEvent, String> {
  final HomeBloc homeBloc;

  BarcodeScannerBloc({
    @required this.homeBloc,
  })  : assert(homeBloc != null);

  @override
  String get initialState => '';

  @override
  Stream<String> mapEventToState(BarcodeScannerEvent event) async* {
    if (event is KeyPressed) {
      final keyEvent = event.keyEvent;

      if (keyEvent is RawKeyDownEvent) {
        final key = handleKey(keyEvent.data);
        if (key == 'enter') {
          homeBloc.dispatch(OrderNumberEntered(orderNumber: currentState));
          yield '';
        } else {
          yield currentState + key;
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
