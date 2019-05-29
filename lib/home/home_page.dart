import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc homeBloc;
//  BarcodeScannerBloc barcodeScannerBloc;

  @override
  void initState() {
    homeBloc = HomeBloc();
//    barcodeScannerBloc = BarcodeScannerBloc(homeBloc: homeBloc);
//    barcodeScannerBloc = BarcodeScannerBloc(homeBloc: homeBloc);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FocusNode _textNode = new FocusNode();

    return BlocProvider<HomeBloc>(
      bloc: homeBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: BlocBuilder<HomeEvent, HomeState>(
          bloc: homeBloc,
          builder: (BuildContext context, HomeState state) {
            return new RawKeyboardListener(
              focusNode: _textNode,
              onKey: (keyEvent) {
                homeBloc.dispatch(KeyPressed(keyEvent: keyEvent));
              },
              child: Builder(
                builder: (BuildContext context) {
                  FocusScope.of(context).requestFocus(_textNode);
                  return ListView.builder(
                    itemCount: state.orderNumbers.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _buildRow(state.orderNumbers[index]);
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildRow(orderNumber) {
    debugPrint(orderNumber);
    return new ListTile(title: new Text(orderNumber));
  }

  @override
  void dispose() {
    homeBloc.dispose();
//    barcodeScannerBloc.dispose();
    super.dispose();
  }
}
