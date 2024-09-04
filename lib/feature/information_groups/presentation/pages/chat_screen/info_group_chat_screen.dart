import 'dart:io';

import 'package:contacts_service/contacts_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:info_91_proj/core/config/app_styles.dart';
import 'package:info_91_proj/core/file_picker_helper.dart';
import 'package:info_91_proj/core/widgets.dart/custom_common_appbar.dart';
import 'package:info_91_proj/feature/information_groups/presentation/pages/chat_screen/chat_screen_controller.dart';
import 'package:info_91_proj/feature/information_groups/presentation/pages/chat_screen/contact_list.dart';
import 'package:info_91_proj/feature/information_groups/presentation/pages/profile_screen.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:info_91_proj/feature/information_groups/presentation/widgets/texts.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final ChatScreenController chatController = Get.put(ChatScreenController());
  FocusNode searchFocusnOde = FocusNode();
  FilePickerHelper filePickerHelper = FilePickerHelper();
  final ScrollController _scrollController = ScrollController();
  Animation<Offset>? _animation;
  AnimationController? _animationController1;
  Tween<Offset>? _animationTween;
  String msgdate = '';
  List<ChatMessage> messages = [
    ChatMessage(
        message: "Good Morning, Have a Good Day!",
        senderId: "2",
        isRead: true,
        dateTime: DateTime.now()),
    ChatMessage(
        message: "Good Morning !",
        senderId: "1",
        isRead: false,
        dateTime: DateTime.now()),
    ChatMessage(
        message: "https://pub.dev/packages/linkify!",
        senderId: "2",
        isRead: true,
        dateTime: DateTime.now()),
    ChatMessage(
        message: "https://chatgpt.com/c/a49ae773-f7cd-477c-a7ab-5cca063d47d7",
        senderId: "1",
        isRead: false,
        dateTime: DateTime.now())
  ];

  TextEditingController searchController = TextEditingController();
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
    _animationController1 = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    _animationTween = Tween<Offset>(
      begin: Offset(2, -1),
      end: Offset(2, .2),
    );
    _animation = _animationTween!.animate(
      CurvedAnimation(
        parent: _animationController1!,
        curve: Curves.ease,
      ),
    );
  }

  String formatMessageTimestamp(DateTime timestamp, int index) {
    DateTime now = DateTime.now();
    DateTime yesterday = DateTime.now().subtract(Duration(days: 1));
    DateTime lastWeek =
        DateTime.now().subtract(Duration(days: DateTime.now().weekday + 6));
    // if (!checkUniqueness==true) {
    //   // If checkUniqueness is false, return null without checking the uniqueness of the date.
    //   return "";
    // }
    print("date $now");
    if (timestamp.year == now.year &&
        timestamp.month == now.month &&
        timestamp.day == now.day) {
      return ' Today ';
    } else if (timestamp.year == yesterday.year &&
        timestamp.month == yesterday.month &&
        timestamp.day == yesterday.day) {
      return 'Yesterday ';
    } else if (timestamp.isAfter(lastWeek)) {
      return DateFormat('EEEE').format(timestamp);
    } else {
      return DateFormat('d MMM yyyy').format(timestamp);
    }
  }

  Widget buildShowDate() {
    print("fghjjghj$msgdate");
    return AnimatedBuilder(
        animation: _animation!,
        builder: (context, child) {
          return Transform.translate(
            offset: _animation!.value,
            child: child,
          );
        },
        child: Container(
            padding: EdgeInsets.only(top: 5, bottom: 5, right: 5, left: 5),
            constraints: BoxConstraints(maxWidth: 110, maxHeight: 30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: msgdate != ""
                  ? Color.fromARGB(209, 199, 219, 235)
                  : Colors
                      .transparent, // Consider adjusting the color as needed
            ),
            child: Center(
              child: Container(
                  child: Text(
                msgdate,
                textAlign: TextAlign.center,
              )),
            )));
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return SafeArea(
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
        child: Scaffold(
          body: Column(
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
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Stack(
                    children: [
                      Positioned(
                        left: MediaQuery.of(context).size.width / 2,
                        top: 30,
                        child: Center(
                          child: SlideTransition(
                            position: _animation!,
                            child: buildShowDate(),
                          ),
                        ),
                      ),
                      ListView.builder(
                        controller: _scrollController,
                        itemCount: messages.length,
                        reverse: true,
                        physics: AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final message = messages[index];
                          bool isMe = message.senderId == "1";
                          msgdate =
                              formatMessageTimestamp(message.dateTime, index);

                          return Align(
                            alignment: isMe
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Container(
                              constraints: BoxConstraints(
                                minWidth:
                                    MediaQuery.of(context).size.width - 300,
                                maxWidth:
                                    MediaQuery.of(context).size.width - 90,
                              ),
                              padding: EdgeInsets.all(8),
                              margin: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              decoration: BoxDecoration(
                                color: isMe
                                    ? AppColors.lightChat
                                    : AppColors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Linkify(
                                    linkStyle: GoogleFonts.poppins(
                                        decorationColor: Colors.blue),
                                    onOpen: (link) async {
                                      if (!await launchUrl(
                                          Uri.parse(link.url))) {
                                        throw Exception(
                                            'Could not launch ${link.url}');
                                      }
                                    },
                                    text: message.message ?? "",
                                    textAlign: TextAlign.left,
                                    style: chatTextstyle,
                                  ),
                                  if (!isMe && message.isRead) ...[
                                    SizedBox(height: 5),
                                    Text(
                                      'Read',
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                // padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: AppColors.white),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: _buildInputField(searchController, searchFocusnOde,
                          () {
                        messages.insert(
                            0,
                            ChatMessage(
                                message: searchController.text,
                                senderId: "1",
                                dateTime: DateTime.now()));
                        searchController.clear();
                        _scrollController.animateTo(
                          0.0,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                        );
                        setState(() {});
                      }),
                    ),
                    Obx(() => chatController.isEmojiVisible.value
                        ? _buildEmojiPicker()
                        : chatController.isGalleryVisible.value
                            ? bottomSheet(context)
                            : Container()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Contact> contacts = [];
  Future<void> _requestContactPermission() async {
    if (await Permission.contacts.request().isGranted) {
      print('Contact permission get');
      fetchContacts();
    } else {
      // Handle permission denied
      print('Contact permission denied');
    }
  }

  Future<void> fetchContacts() async {
    print('Contact permission get');
    try {
      final Iterable<Contact> contacts = await ContactsService.getContacts();
      print('Contact permission ge2t${contacts.length}');

      this.contacts = contacts.toList();
      if (contacts.isNotEmpty) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ContactList(
                contacts: this.contacts,
              ),
            ));
      }
    } catch (e) {
      print('Error fetching contacts: $e');
    }
  }

  Widget _buildEmojiPicker() {
    return EmojiPicker(
        onEmojiSelected: (category, emoji) {
          searchController.text = searchController.text + emoji.emoji;
        },
        onBackspacePressed: () {
          // if (searchController.text.isNotEmpty) {
          //     searchController.text = searchController.text.substring(0, searchController.text.length - 1);
          //   }
        },
        textEditingController: TextEditingController(),
        scrollController: ScrollController(),
        config: Config(
          height: 256,
          checkPlatformCompatibility: true,
          emojiViewConfig: EmojiViewConfig(
            backgroundColor: Colors.transparent,
            // Issue: https://github.com/flutter/flutter/issues/28894
            emojiSizeMax: 28 *
                (foundation.defaultTargetPlatform == TargetPlatform.iOS
                    ? 1.2
                    : 1.0),
          ),
          swapCategoryAndBottomBar: false,
          skinToneConfig: const SkinToneConfig(),
          categoryViewConfig: const CategoryViewConfig(
              // Set the background to yellow
              indicatorColor: AppColors.primary,
              iconColorSelected: AppColors.primary),
          bottomActionBarConfig: const BottomActionBarConfig(
            backgroundColor: AppColors.primary,
            buttonColor: AppColors.primary,
          ),
          searchViewConfig: const SearchViewConfig(
              backgroundColor: AppColors.primary,
              buttonColor: AppColors.white,
              buttonIconColor: AppColors.white),
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
                  filePickerHelper.pickFiles("image", context, "gallery");
                },
              ),
              InkWell(
                onTap: () {
                  filePickerHelper.pickFiles("MultipleFile", context, "");
                },
                child: iconCreation(
                    icon: Icons.insert_drive_file,
                    text: "Document",
                    color: AppColors.secondary),
              ),
              InkWell(
                onTap: () {
                  _requestContactPermission();
                  // pickFiles("Video", context, "");
                },
                child: iconCreation(
                    icon: Icons.document_scanner,
                    text: "Contacts",
                    color: AppColors.secondary),
              ),
              iconCreation(
                  icon: Icons.location_pin,
                  text: "Location",
                  color: AppColors.secondary),
            ],
          ),
        ],
      ),
    );
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
      TextEditingController controller, FocusNode focusnode, Function onSend) {
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
                onChanged: (val) {
                  chatController.checkTextFieldEmpty(val);
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
            Obx(() => IconButton(
                  icon: chatController.isTextFieldEmpty.value
                      ? Icon(Icons.camera)
                      : Icon(Icons.send),
                  onPressed: () {
                    chatController.isTextFieldEmpty.value
                        ? filePickerHelper.pickFiles("image", context, "")
                        : onSend();
                  },
                )),
          ],
        ),
      ),
    );
  }
}

class ChatMessage {
  final String message;
  final String senderId;
  final bool isRead;
  final DateTime dateTime;

  ChatMessage({
    required this.dateTime,
    required this.message,
    required this.senderId,
    this.isRead = false,
  });

  // Method to mark the message as read
  ChatMessage markAsRead() {
    return ChatMessage(
        message: message, senderId: senderId, isRead: true, dateTime: dateTime);
  }
}
