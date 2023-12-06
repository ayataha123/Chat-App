import 'package:chat_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/model/chat.dart';
import '../wedgets/Chats.dart';

class UserPage extends StatelessWidget {
UserPage({Key? key}) : super(key: key);
 static String id = 'UserPage';
  CollectionReference chats =
      FirebaseFirestore.instance.collection('chats');
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
       stream: chats.snapshots(),
        builder: (context, snapshot) {
          List<ChatUser> chatsList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            print(snapshot.data!.docs);
            chatsList.add(ChatUser.fromDocument(snapshot.data!.docs[i]));
          }
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: kPrimaryColor,
                title: Text('Chats'),
              ),
              body: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: 'Search',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30))),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: chatsList.length,
                    itemBuilder: (context, index) {
                      return Chats(email: email, chatUser:chatsList[index] ,);
                    },
                  ),
                )
              ]),
            );
          } else {
            return Text('Loading');
          }
        });
  }
}
