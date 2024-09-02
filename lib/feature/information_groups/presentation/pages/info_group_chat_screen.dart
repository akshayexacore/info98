import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:info_91_proj/core/config/app_styles.dart';
import 'package:info_91_proj/core/widgets.dart/custom_common_appbar.dart';
import 'package:info_91_proj/feature/information_groups/presentation/pages/profile_screen.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart' as foundation;

class ChatScreen extends StatefulWidget {
  ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _isEmojiVisible = false;
   bool _isgallery = false;
  FocusNode searchFocusnOde = FocusNode();
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchFocusnOde.addListener(() {
      if (searchFocusnOde.hasFocus) {
        setState(() {
          _isEmojiVisible = false;
        });
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
            if (_isEmojiVisible) {
              setState(() {
                _isEmojiVisible = false;
              });
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
                  _isEmojiVisible?_buildEmojiPicker():_isgallery?bottomSheet(context):Container(),
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
          setState(() {
            searchController.text = searchController.text + emoji.emoji;
          });
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
        mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                child: iconCreation(
                    icon: Icons.photo,
                    text: "Photos",
                    color:  AppColors.secondary),
                onTap: () {
                  // pickFiles("image", context, "gallery");
                },
              ),
              InkWell(
                onTap: () {
                  // pickFiles("Video", context, "");
                },
                child: iconCreation(
                    icon: Icons.document_scanner, text: "Contacts", color: AppColors.secondary),
              ),InkWell(
                onTap: () {
                  // pickFiles("Video", context, "");
                },
                child: iconCreation(
                    icon: Icons.document_scanner, text: "Contacts", color: AppColors.secondary),
              ),
              InkWell(
                onTap: () {
                  // pickFiles("MultipleFile", context, "");
                },
                child: iconCreation(
                    icon: Icons.insert_drive_file,
                    text: "Document",
                    color:  AppColors.secondary),
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
                  setState(() {
                    _isEmojiVisible = false;_isgallery=false;
                  });
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
                  prefixIcon: IconButton(
                    icon: Icon(searchFocusnOde.hasFocus
                        ? Icons.emoji_emotions
                        : Icons.keyboard),
                    onPressed: () {
                      setState(() {
                        _isEmojiVisible = !_isEmojiVisible;_isgallery=false;
                        if (_isEmojiVisible) {
                          searchFocusnOde.unfocus(); // Hide the keyboard
                        } else {
                          searchFocusnOde.requestFocus(); // Show the keyboard
                        }
                      });
                    },
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.attach_file),
                    onPressed: () {setState(() {
                      _isEmojiVisible=false;
                      _isgallery=true;
                    });
                      // showModalBottomSheet(
                      //   backgroundColor: Colors.transparent,
                      //   context: context,
                      //   builder: (context) => bottomSheet(context),
                      // );
                    },
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
