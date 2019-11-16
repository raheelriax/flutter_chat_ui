import 'package:faker/faker.dart';
import 'package:chat_ui/models/user.dart';
import 'package:chat_ui/models/chat.dart';
import 'package:chat_ui/data/users.dart';
import 'package:chat_ui/models/message.dart';

final Faker faker = Faker();
const List<String> _postFix = ['AM', 'PM'];
String _getTime() {
  final int digit = faker.randomGenerator.integer(12, min: 1);
  return digit > 9 ? "$digit" : "0$digit";
}
// Generate a dynamic list of messages

final List<Chat> chats = users.map((User user) {
  Chat chat = Chat(
    sender: user,
    messages: Iterable<int>.generate(200).toList().map((number) {
      return new Message(
          sender: faker.randomGenerator.element([user, currentUser]),
          unread: faker.randomGenerator.boolean(),
          isLiked: faker.randomGenerator.boolean(),
          time:
              "${_getTime()}: ${_getTime()} ${faker.randomGenerator.element(_postFix)}",
          text: faker.lorem.sentence());
    }).toList(),
  );
  chat.messages.sort((Message a, Message b) => a.time.compareTo(b.time));
  return chat;
}).toList();

final List<User> favorites =
    users.where((user) => user.name.contains('a')).toList();
