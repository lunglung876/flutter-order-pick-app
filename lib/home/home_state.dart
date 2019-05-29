import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  String inputBuffer;
  List<String> orderNumbers;

  HomeState([List props = const []]) : super(props);
}

class HomeInitState extends HomeState {
  final String inputBuffer = '';
  final List<String> orderNumbers = [];
}

class HomeInputState extends HomeState {
  final String inputBuffer;
  final List<String> orderNumbers;

  HomeInputState({this.inputBuffer, this.orderNumbers})
      : super([inputBuffer, orderNumbers]);

  @override
  String toString() => 'Buffer: $inputBuffer, Numbers: $orderNumbers';
}
