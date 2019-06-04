import 'package:warehouse_order_pick/barcode_scanner/barcode_scanner.dart';
import 'package:warehouse_order_pick/pick/pick.dart';
import 'package:bloc/bloc.dart';

class PickBarcodeScannerBloc extends BarcodeScannerBloc {
  PickBarcodeScannerBloc(Bloc inputHandlerBloc) : super(inputHandlerBloc: inputHandlerBloc);

  @override
  dispatchEvent(input) {
    inputHandlerBloc.dispatch(HandleInput(sku: input));
  }
}