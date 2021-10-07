import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:postman/widgets/chat/message_bubble.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    // return FutureBuilder(
    //   future: FirebaseAuth.instance.currentUser(),
    //   builder: (ctx, futureSnapshot) {
    //     if (futureSnapshot.connectionState == ConnectionState.waiting) {
    //       return const Center(
    //         child: CircularProgressIndicator(),
    //       );
    //     }
    //     if (!futureSnapshot.hasData) {
    //       return const Center(
    //         child: Text('No messages found!'),
    //       );
    //     }
        return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('chat')
              .orderBy(
                'createdAt',
                descending: true,
              )
              .snapshots(),
          builder: (ctx, chatSnapshot) {
            if (chatSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final chatDocs = chatSnapshot.data.docs;
            return ListView.builder(
              reverse: true,
              itemCount: chatDocs.length,
              itemBuilder: (ctx, index) => MessageBubble(
                message: chatDocs[index].data()['text'],
                username: chatDocs[index].data()['username'],
                userImage: chatDocs[index].data()['userImage'],
                isMe: chatDocs[index].data()['userId'] == user.uid,
                key: ValueKey(chatDocs[index].id),
              ),
            );
          },
        );
    //   },
    // );
  }
}
