import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

abstract class HomeEvent extends Equatable {
  HomeEvent([List props = const []]) : super(props);
}

class OrderNumberEntered extends HomeEvent {
  final String orderNumber;

  OrderNumberEntered({@required this.orderNumber}) : super([orderNumber]);

  @override
  String toString() => 'orderNumberEntered { number: $orderNumber }';
}

class KeyPressed extends HomeEvent {
  final RawKeyEvent keyEvent;

  KeyPressed({@required this.keyEvent}) : super([keyEvent]);

  @override
  String toString() => 'Key Pressed';
}

class LoadOrders extends HomeEvent {
  @override
  String toString() => 'Load Orders';
}

class DisplayedError extends HomeEvent {
  @override
  String toString() => 'Displayed Error';
}

class RemoveOrder extends HomeEvent {
  final String orderNumber;

  RemoveOrder({@required this.orderNumber}) : super([orderNumber]);

  @override
  String toString() => 'Remove order { number: $orderNumber }';
}
