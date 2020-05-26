import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {},
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection("chats/M01LJtZwNqzYOFhSok82/messages")
              .snapshots(),
          builder: (ctx, streamSnapshot) {
            if (streamSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(),);
            }
            final documents = streamSnapshot.data.documents;
            return ListView.builder(
                itemCount: documents.length,
                itemBuilder: (ctx, index) => Container(
                      padding: EdgeInsets.all(8),
                      child: Text(documents[index]['text']),
                    ));
          },
        ));
  }
}
