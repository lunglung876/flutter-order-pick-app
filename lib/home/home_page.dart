import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:warehouse_order_pick/authentication/authentication.dart';
import 'package:flutter/material.dart';

import 'package:warehouse_order_pick/barcode_scanner/barcode_scanner.dart';

import 'home.dart';

class HomePage extends StatefulWidget {
  @override
  Widget build(BuildContext context) {
    final HomeBloc homeBloc = HomeBloc();
    final BarcodeScannerBloc barcodeScannerBloc =
        BarcodeScannerBloc(homeBloc: homeBloc);

    FocusNode _textNode = new FocusNode();

    return BlocBuilder(
      bloc: homeBloc,
      builder: (BuildContext context, List<String> state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Home'),
          ),
          body: Container(
            child: new RawKeyboardListener(
              focusNode: _textNode,
              onKey: (keyEvent) {
                barcodeScannerBloc.dispatch(KeyPressed(keyEvent: keyEvent));
              },
              child: Builder(
                builder: (BuildContext context) {
                  FocusScope.of(context).requestFocus(_textNode);
                  return ListView.builder(
                    itemCount: 2,
                    itemBuilder: (BuildContext context, int index) {
                      return _buildRow(state);
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildRow(state) {
    debugPrint('dsfds');
    return new ListTile(title: new Text('fsdf'));
  }
}
