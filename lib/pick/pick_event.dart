import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class PickEvent extends Equatable {
  PickEvent([List props = const []]) : super(props);
}

class HandleInput extends PickEvent {
  final String sku;

  HandleInput({@required this.sku}) : super([sku]);

  @override
  String toString() => 'Scanned SKU: $sku';
}
