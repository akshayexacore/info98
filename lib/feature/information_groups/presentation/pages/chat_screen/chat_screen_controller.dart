
import 'package:get/get.dart';

class ChatScreenController extends GetxController{
    var isEmojiVisible = false.obs;
   RxBool isGalleryVisible = false.obs;
 
  void toggleEmojiPicker() {
    isEmojiVisible.value = !isEmojiVisible.value;
    print("isEmojiVisible$isEmojiVisible");
    if (isEmojiVisible.value) {
      isGalleryVisible.value = false;
    }   print("isEmojiVisible$isEmojiVisible");
  }  void toggleGallery() {
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
  }

}