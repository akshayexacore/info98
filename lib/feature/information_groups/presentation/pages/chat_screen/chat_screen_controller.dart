import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChatScreenController extends GetxController {
  var isEmojiVisible = false.obs;
  RxBool isGalleryVisible = false.obs;

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
