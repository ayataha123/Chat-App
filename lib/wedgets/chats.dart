
import 'package:chat_app/model/chat.dart';
import 'package:flutter/material.dart';
class Chats extends StatelessWidget {
   Chats({
    Key? key,
    required this.email,
    required this.chatUser
  }) : super(key: key);

  final Object? email;
  ChatUser chatUser;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
           // Navigator.pushNamed(context, chatPage.id,arguments: email);
          },
          child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              child: Image.asset(chatUser.image),
              radius: 30,
            ),
            const SizedBox( width: 8),
            Text(chatUser.name,style: TextStyle(fontSize: 16),),
          ],
          ),
        ),
        const SizedBox(height: 8,)
      ],
    );
  }
}