import 'dart:async';

import 'package:bloc/bloc.dart';

import 'orders.dart';

class OrdersBloc extends Bloc<OrdersEvent, List<String>> {
  @override
  List<String> get initialState => [];

  @override
  Stream<List<String>> mapEventToState(OrdersEvent event) async* {
    if (event is HandleInput) {
      var orderNumbers = List<String>.from(currentState);

      if (!orderNumbers.contains(event.number)) {
        orderNumbers.add(event.number);
      }

      yield orderNumbers;
    }

    if (event is RemoveOrderButtonPressed) {
      var orderNumbers = List<String>.from(currentState);

      orderNumbers.remove(event.number);

      yield orderNumbers;
    }
  }
}