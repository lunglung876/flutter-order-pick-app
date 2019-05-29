import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class HomeEvent extends Equatable {
  HomeEvent([List props = const []]) : super(props);
}

class KeyPressed extends HomeEvent {
  final String key;

  KeyPressed({@required this.key}) : super([key]);

  @override
  String toString() => 'KeyPressed { key: $key }';
}

class OrderNumberEntered extends HomeEvent {
  final String orderNumber;

  OrderNumberEntered({@required this.orderNumber}) : super([orderNumber]);

  @override
  String toString() => 'orderNumberEntered { number: $orderNumber }';
}
