import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:info_91_proj/core/config/app_styles.dart';
import 'package:info_91_proj/core/widgets.dart/custom_common_appbar.dart';
import 'package:info_91_proj/feature/information_groups/presentation/pages/chat_screen/chat_screen_controller.dart';
import 'package:info_91_proj/feature/information_groups/presentation/pages/profile_screen.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart' as foundation;

class ChatScreen extends StatefulWidget {
  ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatScreenController chatController = Get.put(ChatScreenController());
  FocusNode searchFocusnOde = FocusNode();
  TextEditingController searchController = TextEditingController();
  FilePickerResult? result;
  PlatformFile? file;
  late File _imageFile;
  final ImagePicker picker = ImagePicker();
  XFile? image;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchFocusnOde.addListener(() {
      if (searchFocusnOde.hasFocus) {
        chatController.hideEmojiPicker();
        chatController.hideGallery();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: WillPopScope(
          onWillPop: () {
            if (chatController.isEmojiVisible.value ||
                chatController.isGalleryVisible.value) {
              chatController.hideEmojiPicker();
              chatController.hideGallery();
            } else {
              Navigator.pop(context);
            }
            ;
            return Future.value(false);
          },
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  height: h,
                  child: Column(
                    children: [
                      CustomAppBar(
                        isPic: true,
                        imageUrl: "",
                        imageOntap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfileScreen(),
                              ));
                        },
                        appBarName: "Information Groups",
                        actionWidget: [
                          TextButton(
                              onPressed: () {}, child: const Text("Submit"))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: AppColors.white),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child:
                            _buildInputField(searchController, searchFocusnOde),
                      ),
                      Obx(() => chatController.isEmojiVisible.value
                          ? _buildEmojiPicker()
                          : chatController.isGalleryVisible.value
                              ? bottomSheet(context)
                              : Container()),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmojiPicker() {
    return EmojiPicker(
        onEmojiSelected: (category, emoji) {
          searchController.text = searchController.text + emoji.emoji;
        },
        textEditingController: TextEditingController(),
        scrollController: ScrollController(),
        config: Config(
          height: 256,
          checkPlatformCompatibility: true,
          emojiViewConfig: EmojiViewConfig(
            // Issue: https://github.com/flutter/flutter/issues/28894
            emojiSizeMax: 28 *
                (foundation.defaultTargetPlatform == TargetPlatform.iOS
                    ? 1.2
                    : 1.0),
          ),
          swapCategoryAndBottomBar: false,
          skinToneConfig: const SkinToneConfig(),
          categoryViewConfig: const CategoryViewConfig(),
          bottomActionBarConfig: const BottomActionBarConfig(),
          searchViewConfig: const SearchViewConfig(),
        ));
  }

  Widget bottomSheet(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 7.5,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                child: iconCreation(
                    icon: Icons.photo,
                    text: "Photos",
                    color: AppColors.secondary),
                onTap: () {
                  pickFilesFunc("image", context, "gallery");
                },
              ),
              InkWell(
                onTap: () {
                  // pickFiles("Video", context, "");
                },
                child: iconCreation(
                    icon: Icons.document_scanner,
                    text: "Contacts",
                    color: AppColors.secondary),
              ),
              InkWell(
                onTap: () {
                  // pickFiles("Video", context, "");
                },
                child: iconCreation(
                    icon: Icons.document_scanner,
                    text: "Contacts",
                    color: AppColors.secondary),
              ),
              InkWell(
                onTap: () {
                  // pickFiles("MultipleFile", context, "");
                },
                child: iconCreation(
                    icon: Icons.insert_drive_file,
                    text: "Document",
                    color: AppColors.secondary),
              ),
              // iconCreation(
              //     icon: Icons.location_pin,
              //     text: "Location",
              //     color: Colors.blue),
              // iconCreation(
              //     icon: Icons.all_inbox,
              //     text: "Task/Job",
              //     color: const Color(0xFF519BE0)),
            ],
          ),
        ],
      ),
    );
  }

  void pickFilesFunc(
      String? filetype, BuildContext context, String? source) async {
    print("inside the case");
    switch (filetype) {
      case 'image':
        print("inside the ssscase");
        // result = await FilePicker.platform
        //     .pickFiles(type: FileType.image, allowMultiple: false,allowCompression: true);
        image = await picker.pickImage(
            source:
                source == "gallery" ? ImageSource.gallery : ImageSource.camera);
        _imageFile = File(image!.path);
        var results = await compressFile(_imageFile);
        _imageFile = File(results.path);
        // result= await
        int sized = 1024;
        if (image != null) {
          // for (PlatformFile file in image!.files) {
          final fileSizeInBytes = await results.length();
          final fileSizeInKB = fileSizeInBytes / sized;
          final fileSizeInMB = fileSizeInKB / sized;
          print('File size: $fileSizeInKB KB ($fileSizeInMB MB)');
          int maxSizeBytes = 10 * 1024 * 1024;
          print("File size: $maxSizeBytes");
          if (fileSizeInMB <= maxSizeBytes) {
            print('File pathinside: ${image!.path}');
            setState(() {
              if (source == "camera") {
                // BlocProvider.of<AttachmentBloc>(context)
                //  .add(UploadPictureEvent(image:_imageFile));
              } else {
                showDialog(
                  barrierColor: Color.fromARGB(255, 238, 230, 230),
                  context: context,
                  builder: (BuildContext context) {
                    return Builder(builder: (context) {
                      return Container(
                        color: Colors.black,
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 30,
                                      )),
                                ],
                              ),
                            ),
                            Container(
                                height:
                                    MediaQuery.of(context).size.height / 1.35,
                                child: Center(
                                    child: Image.file(
                                  _imageFile,
                                  fit: BoxFit.fitHeight,
                                ))),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: IconButton(
                                  onPressed: () {
                                    // BlocProvider.of<AttachmentBloc>(context)
                                    //              .add(UploadPictureEvent(image: _imageFile));
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(Icons.done),
                                  color: Colors.blue,
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    });
                  },
                );
              }
            });
          } else {
            print('File path: ${image!.path}');
            print('File size: ${image!.length()}');
            // File size exceeds the allowed limit
            print('File size exceeds the limit.');
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Text("Image size exceeds the limit"),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Cancel")),
                      ],
                    )
                  ],
                );
              },
            );
            // Handle accordingly, for example, show an error message.
          }
          // }
        } else {
          Navigator.pop(context);
          // User canceled the file picking
        }
        // BlocProvider.of<AttachmentBloc>(context)
        //     .add(UploadPictureEvent(image: result!));
        // loadSelectedFiles(result!.files);

        setState(() {});
        break;
      case 'Video':
        result = await FilePicker.platform.pickFiles(
            type: FileType.video, allowMultiple: false, allowCompression: true);
        // if (result == null) return;
        // file = result!.files.first;

        if (result != null) {
          for (PlatformFile file in result!.files) {
            int maxSizeBytes = 15 * 1024 * 1024; // Set the maximum size to 1 MB
            if (file.size <= maxSizeBytes) {
              // File size is within the allowed limit
              print('File path: ${file.path}');
              print('File size: ${file.size}');
              // BlocProvider.of<AttachmentBloc>(context)
              //       .add(UploadVideoEvent(video: result!));
            } else {
              print('File path: ${file.path}');
              print('File size: ${file.size}');
              // File size exceeds the allowed limit
              print('File size exceeds the limit.');
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Text("Vedio size exceeds the limit"),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Cancel")),
                        ],
                      )
                    ],
                  );
                },
              );
              // Handle accordingly, for example, show an error message.
            }
          }
        } else {
          // User canceled the file picking
        }
        setState(() {});
        break;
      case 'Audio':
        result = await FilePicker.platform.pickFiles(
            type: FileType.audio, allowMultiple: false, allowCompression: true);

        if (result == null) return;
        file = result!.files.first;

        if (result != null) {
          for (PlatformFile file in result!.files) {
            int maxSizeBytes = 10 * 1024 * 1024; // Set the maximum size to 1 MB
            if (file.size <= maxSizeBytes) {
              // File size is within the allowed limit
              print('File path: ${file.path}');
              print('File size: ${file.size}');
              // BlocProvider.of<AttachmentBloc>(context)
              //     .add(UploadAudioEvent(audio: result!));
            } else {
              print('File path: ${file.path}');
              print('File size: ${file.size}');
              // File size exceeds the allowed limit
              print('File size exceeds the limit.');
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Text("Audio size exceeds the limit"),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Cancel")),
                        ],
                      )
                    ],
                  );
                },
              );
              // Handle accordingly, for example, show an error message.
            }
          }
        } else {
          // User canceled the file picking
        }
        setState(() {});
        break;
      case 'All':
        result = await FilePicker.platform.pickFiles();
        if (result == null) return;
        file = result!.files.first;
        setState(() {});
        break;
      case 'MultipleFile':
        result = await FilePicker.platform
            .pickFiles(allowMultiple: false, allowCompression: true);

        if (result != null) {
          for (PlatformFile file in result!.files) {
            int maxSizeBytes = 5 * 1024 * 1024; // Set the maximum size to 1 MB
            if (file.size <= maxSizeBytes) {
              // File size is within the allowed limit
              print('File path: ${file.path}');
              print('File size: ${file.size}');
              // BlocProvider.of<AttachmentBloc>(context)
              //       .add(UploadFilesEvent(files: result!));
            } else {
              print('File path: ${file.path}');
              print('File size: ${file.size}');
              // File size exceeds the allowed limit
              print('File size exceeds the limit.');
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Text("Media size exceeds the limit"),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Cancel")),
                        ],
                      )
                    ],
                  );
                },
              );
              // Handle accordingly, for example, show an error message.
            }
          }
        } else {
          // User canceled the file picking
        }
        // if (result == null) return;
        // loadSelectedFiles(result!.files);
        break;
    }
  }

  Future<XFile> compressFile(File file) async {
    final filePath = file.absolute.path;
    // Create output file path
    // eg:- "Volume/VM/abcd_out.jpeg"
    final lastIndex = filePath.lastIndexOf(new RegExp(r'.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      outPath,
      quality: 15,
    );
    print(file.lengthSync());
    print(result!.length());
    return result;
  }

  Widget iconCreation(
      {required IconData icon, required Color color, required String text}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(
              icon,
              color: Colors.white,
              size: 29,
            ),
          ),
        ),
        Text(
          text,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        )
      ],
    );
  }

  Widget _buildInputField(
      TextEditingController controller, FocusNode focusnode) {
    var border = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(20),
    );
    return Expanded(
      // padding: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: controller,
                focusNode: focusnode,
                onTap: () {
                  chatController.hideEmojiPicker();
                  chatController.hideGallery();
                },
                decoration: InputDecoration(
                  hintText: 'Type your message here',
                  hintStyle: GoogleFonts.poppins(
                      fontSize: 13.sp, color: AppColors.text.withOpacity(.75)),
                  filled: true,
                  fillColor: AppColors.google,
                  border: border,
                  errorBorder: border,
                  enabledBorder: border,
                  focusedBorder: border,
                  prefixIcon: Obx(() => IconButton(
                        icon: Icon(chatController.isEmojiVisible.value
                            ? Icons.keyboard
                            : Icons.emoji_emotions),
                        onPressed: () {
                          chatController.toggleEmojiPicker();
                          print(chatController.isEmojiVisible.value);
                          if (chatController.isEmojiVisible.isTrue) {
                            searchFocusnOde.unfocus(); // Hide the keyboard
                          } else {
                            searchFocusnOde.requestFocus(); // Show the keyboard
                          }
                        },
                      )),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.attach_file),
                    onPressed: chatController.toggleGallery,
                  ),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.send),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
