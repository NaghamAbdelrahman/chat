import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../model/message.dart';
import '../../providers/user_provider.dart';

class MessageWidget extends StatelessWidget {
  Message message;

  MessageWidget(this.message);

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return message.senderId == userProvider.user?.id
        ? SentMessage(message.dateTime!, message.content!)
        : RecievedMessage(
            message.dateTime!, message.content!, message.senderName!);
  }
}

class SentMessage extends StatelessWidget {
  int dateTime;
  String contentMessage;

  SentMessage(this.dateTime, this.contentMessage);

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(userProvider.user?.fullName ?? ''),
        Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(12),
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                )),
            child: Text(
              contentMessage,
              style: const TextStyle(color: Colors.white),
            )),
        Text(formatMessageDate(dateTime)),
      ],
    );
  }
}

class RecievedMessage extends StatelessWidget {
  int dateTime;
  String contentMessage;
  String senderName;

  RecievedMessage(this.dateTime, this.contentMessage, this.senderName);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          senderName,
          style: const TextStyle(color: Color(0xFF787993)),
        ),
        const SizedBox(
          height: 4,
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12),
                topLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              )),
          child:
              Text(contentMessage, style: const TextStyle(color: Colors.white)),
        ),
        Text(
          formatMessageDate(dateTime),
          style: const TextStyle(color: Color(0xFF787993)),
        ),
      ],
    );
  }
}

String formatMessageDate(int messageDateTime) {
  DateTime dateTime = DateTime.fromMicrosecondsSinceEpoch(messageDateTime);
  DateFormat dateFormat = DateFormat('hh:mm a');
  return dateFormat.format(dateTime);
}
