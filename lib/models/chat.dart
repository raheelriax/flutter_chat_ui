import 'package:chat_ui/models/message.dart';
import 'package:chat_ui/models/user.dart';

class Chat {
  final User sender;
  final List<Message> messages;

  Chat({this.sender, this.messages});
}
