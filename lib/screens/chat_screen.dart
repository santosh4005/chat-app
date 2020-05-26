import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Firestore.instance
              .collection("chats/M01LJtZwNqzYOFhSok82/messages")
              .snapshots()
              .listen((data) {
            data.documents.forEach((element) {
              print(element['text']);
            });
          });
        },
      ),
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (ctx, index) => Container(
                padding: EdgeInsets.all(8),
                child: Text("this works!"),
              )),
    );
  }
}
