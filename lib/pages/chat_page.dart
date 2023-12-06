import 'package:chat_app/constants.dart';
import 'package:chat_app/model/message.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../wedgets/chat_bubble.dart';

class chatPage extends StatelessWidget {
  chatPage({Key? key}) : super(key: key);
  static String id = 'chatPage';

  CollectionReference messages =
      FirebaseFirestore.instance.collection(kCollectionReference);
  TextEditingController controller = TextEditingController();
  ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    var email=ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy(kcurrentDate,descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Message> messageList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messageList.add(Message.fromjson(snapshot.data!.docs[i]));
            }
            return Scaffold(
              appBar: AppBar(
                backgroundColor: kPrimaryColor,
                automaticallyImplyLeading: false,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      kLogo,
                      height: 50,
                    ),
                    Text('Chat App')
                  ],
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      controller: _scrollController,
                      itemCount: messageList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return messageList[index].id==email ? chatBubble(
                          message: messageList[index],
                        ):chatBubbleFriend(message:messageList[index]);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          onTap:(){
                            messages.add({kMessage: controller.text, kcurrentDate: DateTime.now(),'id':email});
                        controller.clear();
                        _scrollController.animateTo(
                          0,
                          curve: Curves.easeOut,
                          duration: const Duration(milliseconds: 300),
                        );
                          } ,
                          child: Icon(Icons.send)),
                        hintText: 'Send a Message',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: kPrimaryColor),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
