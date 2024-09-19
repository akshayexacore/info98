import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:info_91_proj/feature/information_groups/presentation/pages/chat_screen/info_group_chat_screen.dart';

class ChatScreenController extends GetxController {
  var isEmojiVisible = false.obs;
  RxBool isGalleryVisible = false.obs;
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
        id:" 2",
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
bool isTextfielIsEmty(String val){
  return val.isEmpty;}
  void hideGallery() {
    isGalleryVisible.value = false;
  } //imageanddocumenandvideoselctionfunction var imageFile = Rx<File?>(null);
}
