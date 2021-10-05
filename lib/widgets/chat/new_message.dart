import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _enteredMessage = '';
  final _textController = TextEditingController();

  void _sendMessage() {
    FocusScope.of(context).unfocus();
    Firestore.instance.collection('chat').add({
      'text': _enteredMessage.trim(),
      'createdAt' : Timestamp.now(),
    });
    _textController.clear();
    setState(() {
      _enteredMessage = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: const InputDecoration(
                labelText: 'Text message',
              ),
              onChanged: (value) {
                // if (value.) {
                setState(() {
                  _enteredMessage = value;
                });
                // }
              },
            ),
          ),
          IconButton(
            color: Theme.of(context).primaryColor,
            icon: const Icon(Icons.send),
            onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
          ),
        ],
      ),
    );
  }
}
