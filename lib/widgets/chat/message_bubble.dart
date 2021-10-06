import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  String message = '';
  String username = '';
  String userImage = '';
  final bool isMe;
  final Key key;

  MessageBubble({
    this.key,
    this.message,
    this.userImage,
    this.isMe,
    this.username,
  });
  final radius = const Radius.circular(15);
  final noRadius = const Radius.circular(0);

  final msgPadding = const EdgeInsets.symmetric(
    vertical: 10,
    horizontal: 8,
  );
  final ownMsgPadding = const EdgeInsets.symmetric(
    vertical: 2,
    horizontal: 8,
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(width: 20),
            Container(
              decoration: BoxDecoration(
                color:
                    isMe ? Colors.grey.shade300 : Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: radius,
                  topRight: radius,
                  bottomLeft: !isMe ? noRadius : radius,
                  bottomRight: isMe ? noRadius : radius,
                ),
              ),
              width: 140,
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 16,
              ),
              margin: isMe ? ownMsgPadding : msgPadding,
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    username ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    message ?? '',
                    style: TextStyle(
                      color: Theme.of(context).accentTextTheme.headline6.color,
                    ),
                    textAlign: isMe ? TextAlign.end : TextAlign.start,
                  ),
                ],
              ),
            ),
          ],
        ),
        isMe
            ? const SizedBox(
                width: 0,
              )
            : Positioned(
                top: -5,
                left: 5,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    userImage,
                  ),
                ),
              ),
      ],
      overflow: Overflow.visible,
    );
  }
}
