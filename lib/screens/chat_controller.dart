import 'package:flutter/material.dart';
import 'package:flutter_socket/blocs/chat_bloc.dart';
import 'package:provider/provider.dart';

class ChatControllerWidget extends StatelessWidget {
  final TextEditingController _textEditCtrl = TextEditingController();
  final FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Consumer<ChatBloc>(
      builder: (ctx, bloc, _) => Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Message',
                hintText: 'Type here...',
              ),
              onChanged: (value) {
                bloc.onTextValueChange(value);
              },
              focusNode: focusNode,
              controller: _textEditCtrl,
            ),
          ),
          StreamProvider.value(
            // default disable button
            initialData: false,
            value: bloc.submitButtonStream,
            child: Consumer<bool>(
              builder: (ctx, isEnable, _) => RaisedButton(
                onPressed: isEnable
                    ? () {
                        bloc.sendMessage(_textEditCtrl.text);
                        focusNode.unfocus();
                        _textEditCtrl.clear();
                      }
                    : null,
                child: Icon(Icons.send),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
