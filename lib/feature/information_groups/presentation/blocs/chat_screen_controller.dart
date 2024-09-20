import 'dart:io';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:info_91_proj/feature/information_groups/presentation/pages/chat_screen/info_group_chat_screen.dart';
import 'package:intl/intl.dart';
import 'package:xid/xid.dart';

class ChatScreenController extends GetxController {
  var isEmojiVisible = false.obs;
  RxBool isGalleryVisible = false.obs;
  final ScrollController scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();
  var selectedMessage = <ChatMessage>[].obs;

  RxList<ChatMessage> messages = [
    ChatMessage(
        message: "Good Morning, Have a Good Day!",
        id: "1",
        senderId: "2",
        time: "1:00 PM",
        status: MessageStatus.read,
        messageType: MessageType.image,
        isRead: true,
        dateTime: DateTime.now()),
    ChatMessage(
        message: "Good Morning !",
        senderId: "1",
        id: " 2",
        time: "1:00 PM",
        isRead: false,
        status: MessageStatus.read,
        messageType: MessageType.text,
        dateTime: DateTime.now()),
    ChatMessage(
        message: "https://pub.dev/packages/linkify!",
        senderId: "2",
        isRead: true,
        id: "3",
        status: MessageStatus.delivered,
        time: "1:00 PM",
        messageType: MessageType.text,
        dateTime: DateTime.now()),
    ChatMessage(
        message: "https://chatgpt.com/c/a49ae773-f7cd-477c-a7ab-5cca063d47d7",
        senderId: "1",
        messageType: MessageType.text,
        time: "1:00 PM",
        id: "4",
        isRead: false,
        status: MessageStatus.delivered,
        dateTime: DateTime.now())
  ].obs;

  final picker = ImagePicker();
  var isTextFieldEmpty = true.obs;

  void toggleEmojiPicker() {
    isEmojiVisible.value = !isEmojiVisible.value;

    if (isEmojiVisible.value) {
      isGalleryVisible.value = false;
    }
  }

  void checkTextFieldEmpty(String text) {
    isTextFieldEmpty.value = text.trim().isEmpty;
  }

  void toggleGallery() {
    isGalleryVisible.value = !isGalleryVisible.value;
    if (isGalleryVisible.value) {
      isEmojiVisible.value = false;
    }
  }

  void hideEmojiPicker() {
    isEmojiVisible.value = false;
  }

  bool isTextfielIsEmty(String val) {
    return val.isEmpty;
  }

  void hideGallery() {
    isGalleryVisible.value = false;
  } //imageanddocumenandvideoselctionfunction var imageFile = Rx<File?>(null);

  void sendMessage(MessageType type, {List<Contact>? contactList}) {
    var xid = Xid();
    print(xid);
    messages.insert(
        0,
        ChatMessage(
            messageType: type,
            message: searchController.text,
            senderId: "1",
            id: "$xid",
            contactList: contactList,
            time: getCurrentTime(),
            status: MessageStatus.sent,
            dateTime: DateTime.now()));
    scrollController.animateTo(
      0.0,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  String getCurrentTime() {
    final now = DateTime.now();
    final formatter =
        DateFormat.jm(); // This formats the time as '1:00 PM' or '2:30 AM'
    return formatter.format(now);
  }

  messageOntapfunction(int index, {bool isOntap = false}) {
    


    if (isOntap && messages[index].isSelcted==true) {
     
      selectedMessage.removeWhere((message){
     
       return messages[index].id==message.id;
      });
    }else{    if (selectedMessage.contains(messages[index].id)) {
    selectedMessage.removeWhere((message)=> messages[index].id==message.id);
    } else {
      selectedMessage.add(messages[index]);
    }}
    messages[index] = messages[index]
        .copyWith(isSelcted: isOntap ? false : !messages[index].isSelcted);
    print(selectedMessage);
  }

  int messageSelectedcount() {
    int selectedCount = 0;
    selectedCount = messages.fold(0, (i, f) => f.isSelcted ? i + 1 : i);

    return selectedCount;
  }

  //selected message only contain text checkig function
  bool checkOnlySelectedMessageIsText() {
    for (var message in selectedMessage) {
      if (message.messageType != MessageType.text) {
        return false;
      }
    }
    return true;
  }

  void copySelectedMessages(BuildContext context) {
    print("object${checkOnlySelectedMessageIsText()}");
    if (checkOnlySelectedMessageIsText()) {
     
      String copiedText = selectedMessage
          .map((id) => id.message)
          .join('\n');
           print("object$copiedText");
      Clipboard.setData(ClipboardData(text: copiedText));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Messages copied')),
      );

      selectedMessage.clear();
for(var i=0;i<messages.length;i++){
  messages[i]=messages[i].copyWith(isSelcted: false);
}
    }
  }
}
