import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:warehouse_order_pick/home/home.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  Timer inputTimer;

  @override
  HomeState get initialState => HomeState();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is KeyPressed) {
      currentState.inputBuffer += event.key;
      inputTimer = new Timer(Duration(milliseconds: 200), () {
        yield OrderNumberEntered();

        return;
      })
    }
  }
}
