import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc homeBloc;

  @override
  void initState() {
    homeBloc = HomeBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FocusNode _textNode = new FocusNode();

    return BlocListener(
      bloc: homeBloc,
      listener: (BuildContext context, HomeState state) {
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

        homeBloc.dispatch(DisplayedError());
      },
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
                  return Container(
                    child: Column(
                      children: <Widget>[
                        ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: state.orderNumbers.length,
                          itemBuilder: (BuildContext context, int index) {
                            return _buildRow(state.orderNumbers[index]);
                          },
                        ),
                        RaisedButton(
                          onPressed: () => homeBloc.dispatch(LoadOrders()),
                          child: Text('Next'),
                        )
                      ],
                    ),
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
    return new ListTile(title: new Text(orderNumber));
  }

  @override
  void dispose() {
    homeBloc.dispose();
    super.dispose();
  }
}
