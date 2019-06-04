import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:warehouse_order_pick/barcode_scanner/barcode_scanner_event.dart';
import 'package:warehouse_order_pick/models/item.dart';

import 'pick.dart';

class PickPage extends StatefulWidget {
  final items;

  PickPage({Key key, @required this.items}) : super(key: key);

  @override
  State<PickPage> createState() => _PickPageState(items);
}

class _PickPageState extends State<PickPage> {
  PickBarcodeScannerBloc barcodeScannerBloc;
  PickBloc pickBloc;
  List<Item> items;

  _PickPageState(this.items);

  @override
  void initState() {
    pickBloc = PickBloc(items: items);
    barcodeScannerBloc = PickBarcodeScannerBloc(pickBloc);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FocusNode _textNode = new FocusNode();

    return BlocListener(
      bloc: pickBloc,
      listener: (BuildContext context, PickState state) {
        if (state.error != '') {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(state.error),
                actions: <Widget>[
                  new FlatButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('Close'),
                  ),
                ],
              );
            },
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: Column(
          children: <Widget>[
            RawKeyboardListener(
              focusNode: _textNode,
              onKey: (keyEvent) {
                barcodeScannerBloc
                    .dispatch(BarcodeScannerKeyPressed(keyEvent: keyEvent));
              },
              child: Builder(builder: (BuildContext context) {
                FocusScope.of(context).requestFocus(_textNode);

                return TextField();
              }),
            ),
            BlocBuilder<PickEvent, PickState>(
              bloc: pickBloc,
              builder: (BuildContext context, PickState pickState) {
                FocusScope.of(context).requestFocus(_textNode);

                return Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    itemCount: pickState.items.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ItemWidget(item: pickState.items[index]);
                    },
                    separatorBuilder: (context, index) {
                      return Divider(height: 30);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
