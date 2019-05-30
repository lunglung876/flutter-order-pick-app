import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:flutter/services.dart';

abstract class HomeEvent extends Equatable {
  HomeEvent([List props = const []]) : super(props);
}

class OrderNumberEntered extends HomeEvent {
  final String orderNumber;

  OrderNumberEntered({@required this.orderNumber}) : super([orderNumber]);

  @override
  String toString() => 'orderNumberEntered { number: $orderNumber }';
}
