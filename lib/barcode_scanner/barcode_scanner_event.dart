import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

abstract class BarcodeScannerEvent extends Equatable {
  BarcodeScannerEvent([List props = const []]) : super(props);
}

class BarcodeScannerKeyPressed extends BarcodeScannerEvent {
  final RawKeyEvent keyEvent;

  BarcodeScannerKeyPressed({@required this.keyEvent}) : super([keyEvent]);

  @override
  String toString() => 'Key Pressed';
}