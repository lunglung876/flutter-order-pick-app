import 'package:warehouse_order_pick/barcode_scanner/barcode_scanner.dart';
import 'package:warehouse_order_pick/orders/orders.dart';
import 'package:bloc/bloc.dart';

class HomeBarcodeScannerBloc extends BarcodeScannerBloc {
  HomeBarcodeScannerBloc(Bloc inputHandlerBloc) : super(inputHandlerBloc: inputHandlerBloc);

  @override
  dispatchEvent(input) {
    inputHandlerBloc.dispatch(HandleInput(number: input));
  }
}