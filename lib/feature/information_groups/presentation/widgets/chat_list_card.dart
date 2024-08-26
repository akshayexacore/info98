import 'package:flutter/material.dart';
import 'package:info_91_proj/core/config/app_styles.dart';

class ChatListItem extends StatelessWidget {
  final Chat chat;
  final Function onTap;
  const ChatListItem({super.key, required this.chat, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(chat.avatarUrl),
        radius: 25.0,
      ),
      title: Text(
        chat.name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        chat.message,
        style: const TextStyle(
            color: Colors.black, overflow: TextOverflow.ellipsis),
      ),
      trailing: Column(
        children: [
          Text(
            chat.time,
            style: const TextStyle(color: Colors.black, fontSize: 12.0),
          ),
          if (chat.itemcount != 0 && chat.itemcount != null) ...[
            const SizedBox(
              height: 5,
            ),
            const CircleAvatar(
              radius: 13,
              backgroundColor: AppColors.primaryAccent,
              child: Text(
                "1",
                style: TextStyle(color: Colors.white),
              ),
            )
          ]
        ],
      ),
      onTap: () {
        onTap();
        // Handle tap event (e.g., navigate to chat details)
      },
    );
  }
}

class Chat {
  final String name;
  final String message;
  final String time;
  final String avatarUrl;
  final int? itemcount;

  Chat({
    required this.name,
    required this.message,
    required this.time,
    this.itemcount,
    required this.avatarUrl,
  });
}
