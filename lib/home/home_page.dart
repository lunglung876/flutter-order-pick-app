import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home.dart';
import 'package:warehouse_order_pick/barcode_scanner/barcode_scanner_event.dart';
import 'package:warehouse_order_pick/orders/orders.dart';
import 'package:warehouse_order_pick/items/items.dart';
import 'package:warehouse_order_pick/pick/pick.dart';
import 'package:warehouse_order_pick/authentication/authentication.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  OrdersBloc ordersBloc;
  HomeBarcodeScannerBloc barcodeScannerBloc;
  ItemsBloc itemsBloc;
  AuthenticationBloc authenticationBloc;

  @override
  void initState() {
    authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    ordersBloc = OrdersBloc();
    barcodeScannerBloc = HomeBarcodeScannerBloc(ordersBloc);
    itemsBloc = ItemsBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FocusNode _textNode = new FocusNode();

    return BlocListener(
      bloc: itemsBloc,
      listener: (BuildContext context, ItemsState state) {
        if (state is ItemsError) {
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

        if (state is ItemsLoaded) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PickPage(items: state.items)),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          actions: <Widget>[
            RaisedButton(
              onPressed: () {
                authenticationBloc.dispatch(LoggedOut());
              },
              child: Text('Logout'),
              textColor: Colors.white,
              color: Colors.grey,
            ),
          ],
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
            BlocBuilder<OrdersEvent, List<String>>(
              bloc: ordersBloc,
              builder: (BuildContext context, List<String> ordersState) {
                FocusScope.of(context).requestFocus(_textNode);
                if (ordersState.length > 0) {
                  return BlocBuilder<ItemsEvent, ItemsState>(
                    bloc: itemsBloc,
                    builder: (BuildContext context, ItemsState itemsState) {
                      return Container(
                        child: Column(
                          children: <Widget>[
                            ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: ordersState.length,
                              itemBuilder: (BuildContext context, int index) {
                                return _buildRow(ordersState[index]);
                              },
                            ),
                            RaisedButton(
                              onPressed: () {
                                if (itemsState is! ItemsLoading) {
                                  itemsBloc.dispatch(
                                      LoadOrderButtonPressed(ordersState));
                                }
                              },
                              child: Text('Next'),
                              textColor: Colors.white,
                              color: Colors.green,
                            ),
                            Container(
                              child: itemsState is ItemsLoading
                                  ? CircularProgressIndicator()
                                  : null,
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return Container(
                    child: Text('Please scan orders to get started.'),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(orderNumber) {
    return new ListTile(
      title: new Text(orderNumber),
      trailing: RaisedButton(
        onPressed: () =>
            ordersBloc.dispatch(RemoveOrderButtonPressed(number: orderNumber)),
        child: Text('Remove'),
        textColor: Colors.white,
        color: Colors.redAccent,
      ),
    );
  }

  @override
  void dispose() {
    barcodeScannerBloc.dispose();
    ordersBloc.dispose();
    super.dispose();
  }
}
