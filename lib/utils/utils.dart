import 'package:chat_ui/models/user.dart';
import 'package:chat_ui/screens/conversation.dart';
import 'package:flutter/material.dart';

void openChat(BuildContext context, User user) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) => Conversation(
                user: user,
              )));
}
