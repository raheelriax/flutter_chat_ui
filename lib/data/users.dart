import 'package:faker/faker.dart';
import 'package:chat_ui/models/chat.dart';
import 'package:chat_ui/models/message.dart';
import 'package:chat_ui/models/user.dart';

int _index = 0;

User _generateUser(String name) {
  return User(
    id: _index++,
    name: "${name[0].toUpperCase()}${name.substring(1)}",
    imageUrl: "./assets/images/users/$name.jpg",
  );
}

const List<String> userNames = const [
  'becky',
  'chang',
  'edwin',
  'jessica',
  'jhon',
  'jordan',
  'judi',
  'liza',
  'marry',
  'nick',
  'susan'
];

// Generate list of users based on names
final List<User> users = userNames.map(_generateUser).toList();

final User currentUser = _generateUser('rashid');