import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChatScreenController extends GetxController {
  var isEmojiVisible = false.obs;
  RxBool isGalleryVisible = false.obs;
  var imageFile = Rx<File?>(null);
  var videoFile = Rx<PlatformFile?>(null);
  var audioFile = Rx<PlatformFile?>(null);
  var multipleFiles = RxList<PlatformFile>().obs;
  final picker = ImagePicker();

  void toggleEmojiPicker() {
    isEmojiVisible.value = !isEmojiVisible.value;
    print("isEmojiVisible$isEmojiVisible");
    if (isEmojiVisible.value) {
      isGalleryVisible.value = false;
    }
    print("isEmojiVisible$isEmojiVisible");
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

  void hideGallery() {
    isGalleryVisible.value = false;
  } //imageanddocumenandvideoselctionfunction var imageFile = Rx<File?>(null);
}
