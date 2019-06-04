import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class OrdersEvent extends Equatable {
  OrdersEvent([List props = const []]) : super(props);
}

class HandleInput extends OrdersEvent {
  final String number;

  HandleInput({@required this.number}) : super([number]);

  @override
  String toString() => 'Add order number $number';
}

class RemoveOrderButtonPressed extends OrdersEvent {
  final String number;

  RemoveOrderButtonPressed({@required this.number}) : super([number]);

  @override
  String toString() => 'Loading Orders';
}