import 'package:chat_ui/data/chat.dart';
import 'package:chat_ui/models/chat.dart';
import 'package:chat_ui/models/message.dart';
import 'package:chat_ui/utils/utils.dart';
import 'package:chat_ui/widgets/category_selector.dart';
import 'package:chat_ui/widgets/favorite_contacts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget _buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        iconSize: 30,
        color: Colors.white,
        onPressed: () {},
      ),
      title: Center(
        child: Text(
          'Chats',
          style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
      elevation: 0.0,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          iconSize: 30.0,
          color: Colors.white,
          onPressed: () {},
        )
      ],
    );
  }

  Widget _buildBody() {
    return Column(
      children: <Widget>[CategorySelector(), _buildFavoriteAndChatList()],
    );
  }

  Widget _buildFavoriteAndChatList() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        child: Column(
          children: <Widget>[
            FavoriteContacts(),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  child: _buildChatList(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildChatList() {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: chats.length,
        itemBuilder: (BuildContext context, int index) {
          final Chat chat = chats[index];
          final Message message = chat.messages[chat.messages.length - 1];
          return GestureDetector(
            onTap: () => openChat(context, chat.sender),
            child: Container(
              margin: EdgeInsets.only(top: 5, bottom: 5, right: 20),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 17),
              decoration: BoxDecoration(
                  color: message.unread
                      ? Theme.of(context).selectedRowColor
                      : Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: _buildChatRow(chat, message),
            ),
          );
        });
  }

  Widget _buildChatRow(Chat chat, Message message) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            CircleAvatar(
              radius: 35,
              backgroundImage: AssetImage(chat.sender.imageUrl),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  chat.sender.name,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.50,
                  child: Text(
                    message.text,
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ],
        ),
        Column(
          children: <Widget>[
            Text(
              message.time,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            message.unread
                ? Container(
                    child: Text(
                      'NEW',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    width: 40,
                    height: 20,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(30)),
                    alignment: Alignment.center,
                  )
                : Text('')
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }
}
