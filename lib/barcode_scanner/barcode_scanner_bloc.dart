import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/services.dart';

import 'barcode_scanner.dart';

abstract class BarcodeScannerBloc extends Bloc<BarcodeScannerEvent, String> {
  final Bloc inputHandlerBloc;

  BarcodeScannerBloc({@required this.inputHandlerBloc});

  @override
  String get initialState => '';

  @override
  Stream<String> mapEventToState(BarcodeScannerEvent event) async* {
    if (event is BarcodeScannerKeyPressed) {
      final keyEvent = event.keyEvent;

      if (keyEvent is RawKeyDownEvent) {
        final key = handleKey(keyEvent.data);

        if (key == 'enter') {
          if (currentState != '') {
            dispatchEvent(currentState);
          }

          yield '';
        } else {
          yield currentState + key;
        }
      }
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

  dispatchEvent(input) {}
}
