import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';

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
            onKey: handleKey,
            child: Builder(
              builder: (BuildContext context) {
                FocusScope.of(context).requestFocus(_textNode);
                return new Container();
              },
            ),
          )
        )
    );
  }

  handleKey(input) {
    if (input is RawKeyDownEvent) {
      const int combiningCharacterMask = 0x7fffffff;
      // ignore:
        final String codePointChar = String.fromCharCode(
            combiningCharacterMask & input.data.codePoint);
      // ignore: all
        debugPrint('codePoint: ${input.data.codePoint} (${_asHex(
            input.data.codePoint)}: $codePointChar)');
    }
  }
}
