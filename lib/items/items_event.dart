import 'package:equatable/equatable.dart';

abstract class ItemsEvent extends Equatable {
  ItemsEvent([List props = const []]) : super(props);
}

class LoadOrderButtonPressed extends ItemsEvent {
  final List<String> orderNumbers;

  LoadOrderButtonPressed(this.orderNumbers) : super([orderNumbers]);

  @override
  String toString() => 'Load items from orders ${this.orderNumbers.join(',')}';
}
