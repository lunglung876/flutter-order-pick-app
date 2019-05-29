import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:warehouse_order_pick/authentication/authentication.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);

    FocusNode _textNode = new FocusNode();
    TextEditingController _controller = new TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Container(
        child: new RawKeyboardListener(
          focusNode: _textNode,
          onKey: (input) {
            if (input is RawKeyDownEvent) {
              handleKey(input.data);
            }
          },
          child: Builder(
            builder: (BuildContext context) {
              FocusScope.of(context).requestFocus(_textNode);
              return new Container();
            },
          ),
        ),
      ),
    );
  }

  handleKey(RawKeyEventDataAndroid data) {
    const int combiningCharacterMask = 0x7fffffff;
    final String codePointChar =
        String.fromCharCode(combiningCharacterMask & data.codePoint);
    debugPrint(codePointChar);
  }
}
