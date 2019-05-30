import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:warehouse_order_pick/home/home.dart';
import 'package:flutter/material.dart';

class HomeBloc extends Bloc<HomeEvent, List<String>> {
  String inputBuffer = '';

  @override
  List<String> get initialState => [];

  @override
  Stream<List<String>> mapEventToState(HomeEvent event) async* {
    if (event is OrderNumberEntered) {
      if (!currentState.contains(event.orderNumber)) {
        currentState.add(event.orderNumber);
      }

      yield currentState;
    }
  }
}
