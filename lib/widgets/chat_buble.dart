
import 'package:flutter/material.dart';

import '../constants.dart';
import '../models/message.dart';

class ChatBuble extends StatelessWidget {
  const ChatBuble({
    super.key, required this.message,
  });
final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
          padding: EdgeInsets.symmetric(horizontal: 16,vertical: 32),
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
              bottomRight: Radius.circular(32),
            ),
          ),
          //color: kPrimaryColor,
      
          child: Text(message.message,style: TextStyle(
            color: Colors.white,
          ),)
      ),
    );
  }
}




class ChatBubleForaFriend extends StatelessWidget {
  const ChatBubleForaFriend({
    super.key, required this.message,
  });
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
          padding: EdgeInsets.symmetric(horizontal: 16,vertical: 32),
          decoration: BoxDecoration(
            color: Color(0xff006D84),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
              bottomLeft: Radius.circular(32),
            ),
          ),
          //color: kPrimaryColor,

          child: Text(message.message,style: TextStyle(
            color: Colors.white,
          ),)
      ),
    );
  }
}