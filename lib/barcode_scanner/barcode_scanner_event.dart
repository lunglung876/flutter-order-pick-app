import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:flutter/services.dart';

abstract class BarcodeScannerEvent extends Equatable {
  BarcodeScannerEvent([List props = const []]) : super(props);
}

class KeyPressed extends BarcodeScannerEvent {
  final RawKeyEvent keyEvent;

  KeyPressed({@required this.keyEvent}) : super([keyEvent]);

  @override
  String toString() => 'Key Pressed';
}

