

import 'package:contacts_service/contacts_service.dart';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


import 'package:info_91_proj/core/config/app_styles.dart';
import 'package:info_91_proj/core/file_picker_helper.dart';
import 'package:info_91_proj/core/variables.dart';
import 'package:info_91_proj/core/widgets.dart/custom_common_appbar.dart';
import 'package:info_91_proj/feature/information_groups/presentation/blocs/chat_screen_controller.dart';
import 'package:info_91_proj/feature/information_groups/presentation/pages/chat_screen/build_message_widget.dart';
import 'package:info_91_proj/feature/information_groups/presentation/pages/chat_screen/contact_list.dart';
import 'package:info_91_proj/feature/information_groups/presentation/pages/profile_screen.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:info_91_proj/feature/information_groups/presentation/widgets/custom_popupmenu.dart';

import 'package:intl/intl.dart';

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
        time: "1:00 PM",
        status: MessageStatus.read,
        messageType: MessageType.image,
        isRead: true,
        dateTime: DateTime.now()),
    ChatMessage(
        message: "Good Morning !",
        senderId: "1",
        time: "1:00 PM",
        isRead: false,
        status: MessageStatus.read,
        messageType: MessageType.text,
        dateTime: DateTime.now()),
    ChatMessage(
        message: "https://pub.dev/packages/linkify!",
        senderId: "2",
        isRead: true,
        status: MessageStatus.delivered,
        time: "1:00 PM",
        messageType: MessageType.text,
        dateTime: DateTime.now()),
    ChatMessage(
        message: "https://chatgpt.com/c/a49ae773-f7cd-477c-a7ab-5cca063d47d7",
        senderId: "1",
        messageType: MessageType.text,
        time: "1:00 PM",
        isRead: false,
        status: MessageStatus.delivered,
        dateTime: DateTime.now())
  ];

  void sendMessage(MessageType type, {List<Contact>? contactList}) {
    messages.insert(
        0,
        ChatMessage(
            messageType: type,
            message: searchController.text,
            senderId: "1",
            contactList: contactList,
            time: getCurrentTime(),
            status: MessageStatus.sent,
            dateTime: DateTime.now()));
    _scrollController.animateTo(
      0.0,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
    setState(() {});
  }

  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // this for to get contact litinitial,to avoid lag
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

  messageOntapfunction(int index, {bool isOntap = false}) {
    messages[index] =
        messages[index].copyWith(isSelcted:isOntap?false: !messages[index].isSelcted);
    setState(() {});
    messageSelectedcount();
  }

 int  messageSelectedcount(){
int selectedCount=0;
selectedCount=messages.fold(0, (i,f)=>f.isSelcted?i+1:i);
setState(() {
  
});
return selectedCount;

  }

  Widget buildShowDate() {
   
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
                isPic:messageSelectedcount()!=0?false: true,
                imageUrl: "",
                imageOntap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(),
                      ));
                },
                appBarName:messageSelectedcount()!=0?messageSelectedcount().toString(): "Information Groups",
                actionWidget: [
                  if(messageSelectedcount()!=0)...[
                    CustomPopupmenu(onSelected: (){

                    }, itemList:  [popupMenuModel(name: "Copy", value: 1)])

                  ]

                ],
              ),
              Expanded(
                child:
                    // Container(color: Colors.red,)
                    Align(
                  alignment: Alignment.topCenter,
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: messages.length,
                    reverse: true,
                    physics: AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      bool isMe = message.senderId == "1";
                      msgdate = formatMessageTimestamp(message.dateTime, index);

                      return InkWell(
                        highlightColor: AppColors.transparent,
                        splashColor: AppColors.transparent,
                        onTap: (){
                          messageOntapfunction(index,isOntap: true);
                        },
                        onLongPress: () {
                          messageOntapfunction(index);
                        },
                        child: Stack(
                          children: [
                            Align(
                                alignment: isMe
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: BuildMessageWidget(
                                  messageModel: message,
                                )),
                            Positioned.fill(
                              child: Container(
                                color: messages[index].isSelcted
                                    ? Colors.green.withOpacity(.3)
                                    : Colors.transparent,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: AppColors.white),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: _buildInputField(searchController, searchFocusnOde,
                          () {
                        sendMessage(MessageType.text);
                        searchController.clear();

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
  String getCurrentTime() {
    final now = DateTime.now();
    final formatter =
        DateFormat.jm(); // This formats the time as '1:00 PM' or '2:30 AM'
    return formatter.format(now);
  }

  Widget _buildEmojiPicker() {
    return EmojiPicker(
        onEmojiSelected: (category, emoji) {
          searchController.text = searchController.text + emoji.emoji;
          chatController.checkTextFieldEmpty(searchController.text.trim());
        },
        onBackspacePressed: () {
          if (searchController.text.isNotEmpty) {
            searchController.text =
                searchController.text.characters.skipLast(1).toString();
            chatController.checkTextFieldEmpty(searchController.text.trim());
          }
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ContactList(
                          contacts: Variables.userContact,
                          onSubmitFunction: (contactList) {
                            print("contactlist$contactList");
                            sendMessage(MessageType.contact,
                                contactList: contactList);
                          },
                        ),
                      ));

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
            radius: 26.r,
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
      borderRadius: BorderRadius.circular(15),
    );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: SizedBox(
              height: 50.h,
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
                      fontSize: 12.5.sp,
                      color: AppColors.text.withOpacity(.75)),
                  filled: true,
                  fillColor: AppColors.google,
                  border: border,
                  errorBorder: border,
                  enabledBorder: border,
                  focusedBorder: border,
                  prefixIcon: Obx(() => IconButton(
                        icon: Icon(
                          chatController.isEmojiVisible.value
                              ? Icons.keyboard
                              : Icons.sentiment_satisfied_outlined,
                          color: AppColors.primary,
                          size: 24.sp,
                        ),
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
                    icon: Icon(
                      Icons.attach_file,
                      color: AppColors.primary,
                      size: 24.sp,
                    ),
                    onPressed: chatController.toggleGallery,
                  ),
                ),
              ),
            ),
          ),
          Obx(() => IconButton(
                icon: chatController.isTextFieldEmpty.value
                    ? Icon(
                        Icons.photo_camera_outlined,
                        color: AppColors.primary,
                        size: 24.sp,
                      )
                    : Icon(
                        Icons.send,
                        color: AppColors.primary,
                        size: 24.sp,
                      ),
                onPressed: () {
                  chatController.isTextFieldEmpty.value
                      ? filePickerHelper.pickFiles("image", context, "")
                      : onSend();
                  chatController.checkTextFieldEmpty(controller.text.trim());
                },
              )),
        ],
      ),
    );
  }
}

enum MessageType { text, image, document, audio, video, reply, contact }

enum MessageStatus {
  sent,
  delivered,
  read,
}

class ChatMessage {
  final String message;
  final String senderId;
  final bool isRead;
  final String time;
  final DateTime dateTime;
  final MessageType messageType;
  MessageStatus status;
  final String? filePath;
  final bool isSelcted;
  final List<Contact>? contactList;

  ChatMessage({
    required this.dateTime,
    required this.messageType,
    this.filePath,
    this.contactList,
    required this.time,
    this.isSelcted = false,
    required this.message,
    required this.senderId,
    required this.status,
    this.isRead = false,
  });

  ChatMessage copyWith({
    String? message,
    String? senderId,
    bool? isRead,
    String? time,
    DateTime? dateTime,
    MessageType? messageType,
    MessageStatus? status,
    String? filePath,
    bool? isSelcted,
    List<Contact>? contactList,
  }) {
    return ChatMessage(
      message: message ?? this.message,
      senderId: senderId ?? this.senderId,
      isRead: isRead ?? this.isRead,
      time: time ?? this.time,
      dateTime: dateTime ?? this.dateTime,
      messageType: messageType ?? this.messageType,
      status: status ?? this.status,
      filePath: filePath ?? this.filePath,
      isSelcted: isSelcted ?? this.isSelcted,
      contactList: contactList ?? this.contactList,
    );
  }

  // Method to mark the message as read
  ChatMessage markAsRead() {
    return ChatMessage(
        message: message,
        senderId: senderId,
        isRead: true,
        dateTime: dateTime,
        messageType: messageType,
        isSelcted: this.isSelcted,
        status: status,
        time: time);
  }
}
