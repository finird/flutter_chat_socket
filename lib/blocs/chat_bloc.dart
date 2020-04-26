import 'dart:async';

import 'package:socket_io_client/socket_io_client.dart';

class ChatBloc {
  final Socket socket;
  StreamController<String> _textFieldCtrl = StreamController<String>();
  StreamController<bool> _submitBtnCtrl = StreamController<bool>();
  StreamController<String> _chatItemsCtrl = StreamController<String>();

  ChatBloc(this.socket) {
    _textFieldCtrl.stream.listen((value) {
      _submitBtnCtrl.sink.add(value != null && value.isNotEmpty);
    });
    socket.connect();

    socket.on('connect_error', (value) {
      // handle
    });

    socket.on('chat message', (value) {
      _chatItemsCtrl.sink.add(value);
    });
  }

  sendMessage(String message) {
    socket.emit('chat message', 'From Mobile: $message');
  }

  Stream<bool> get submitButtonStream => _submitBtnCtrl.stream;
  Stream<String> get chatItemsStream => _chatItemsCtrl.stream;
  void onTextValueChange(String value) => _textFieldCtrl.sink.add(value);

  Stream dispose() {
    _textFieldCtrl.close();
    _submitBtnCtrl.close();
    _chatItemsCtrl.close();
  }
}
