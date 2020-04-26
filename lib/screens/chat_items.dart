import 'package:flutter/material.dart';
import 'package:flutter_socket/blocs/chat_bloc.dart';
import 'package:provider/provider.dart';

class ChatListWidget extends StatefulWidget {
  @override
  _ChatListWidgetState createState() => _ChatListWidgetState();
}

class _ChatListWidgetState extends State<ChatListWidget> {
  List<String> messages = [];

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatBloc>(
      builder: (context, bloc, _) => StreamProvider.value(
        initialData: null,
        value: bloc.chatItemsStream,
        child: Consumer<String>(
          builder: (context, msg, _) {
            if (msg != null && msg.isNotEmpty) {
              messages.add(msg);
            }
            return ListView.builder(
              itemCount: messages.length,
              itemBuilder: (ctx, id) => _itemBuilder('Alex', messages[id]),
            );
          },
        ),
      ),
    );
  }

  Widget _itemBuilder(String name, String msg) {
    return ListTile(
      leading: Text(name),
      title: Text(msg),
    );
  }
}
