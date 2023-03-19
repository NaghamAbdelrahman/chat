import 'package:chat/ui/chat/chat_thread.dart';
import 'package:flutter/material.dart';

import '../../model/room.dart';

class RoomWidget extends StatelessWidget {
  Room room;

  RoomWidget(this.room);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, ChatThread.routeName, arguments: room);
      },
      child: Card(
        margin: const EdgeInsets.all(15),
        elevation: 18,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset('assets/images/${room.catId}.png',
                  width: 90, height: 90),
              Text(room.name ?? '',
                  style: Theme.of(context).textTheme.subtitle2),
            ],
          ),
        ),
      ),
    );
  }
}
