import 'package:chat_ui/data/chat.dart';
import 'package:chat_ui/models/user.dart';
import 'package:chat_ui/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// ignore: must_be_immutable
class FavoriteContacts extends StatelessWidget {
  BuildContext context;

  Widget firstRow() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Favorite Contacts',
            style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 15,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0),
          ),
          IconButton(
            icon: Icon(Icons.more_horiz),
            iconSize: 30,
            color: Colors.blueGrey,
            onPressed: () {},
          )
        ],
      ),
    );
  }

  Widget avatar(User user) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () => openChat(context, user),
        child: Column(
          children: <Widget>[
            CircleAvatar(
              radius: 35.0,
              backgroundImage: AssetImage(user.imageUrl),
            ),
            SizedBox(
              height: 6.0,
            ),
            Text(
              user.name,
              style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }

  Widget secondRow() {
    return Container(
      height: 120,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: favorites.length,
          itemBuilder: (BuildContext context, int index) {
            User user = favorites[index];
            return avatar(user);
          }),
    );
  }

  @override
  Widget build(BuildContext buildContext) {
    context = buildContext;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 6),
      child: Column(
        children: <Widget>[firstRow(), secondRow()],
      ),
    );
  }
}
