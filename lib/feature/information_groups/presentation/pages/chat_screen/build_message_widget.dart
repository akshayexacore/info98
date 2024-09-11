import 'dart:io';

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:info_91_proj/core/config/app_styles.dart';
import 'package:info_91_proj/core/image_view.dart';
import 'package:info_91_proj/core/tiny/app_button.dart';
import 'package:info_91_proj/core/tiny/app_divider.dart';
import 'package:info_91_proj/feature/information_groups/presentation/pages/chat_screen/info_group_chat_screen.dart';
import 'package:info_91_proj/feature/information_groups/presentation/pages/contactSelected_view_screen.dart';

import 'package:info_91_proj/feature/information_groups/presentation/widgets/texts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class BuildMessageWidget extends StatelessWidget {
  final ChatMessage messageModel;
  BuildMessageWidget({super.key, required this.messageModel});

  @override
  Widget build(BuildContext context) {
    switch (messageModel.messageType) {
      case MessageType.text:
        return _buildTextMessage(messageModel, context);
      case MessageType.image:
        return BuildChatImage(
          message: messageModel,
        );
      case MessageType.document:
        return _buildDocumentMessage(messageModel);
      case MessageType.audio:
        return _buildAudioMessage(messageModel);
      case MessageType.video:
        return _buildVideoMessage(messageModel);
      case MessageType.reply:
        return _buildReplyMessage(messageModel);
      case MessageType.contact:
        return _buildConatctMessage(messageModel, context);
      default:
        return SizedBox.shrink();
    }
  }

  Widget _buildTextMessage(ChatMessage message, BuildContext context) {
    bool isMe = message.senderId == "1";
    return commonBuildMessageOuter(
      context: context,
      isMe: isMe,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Linkify(
            linkStyle: GoogleFonts.poppins(decorationColor: Colors.blue),
            onOpen: (link) async {
              if (!await launchUrl(Uri.parse(link.url))) {
                throw Exception('Could not launch ${link.url}');
              }
            },
            text: message.message ?? "",
            textAlign: TextAlign.left,
            style: chatTextstyle,
          ),
          Align(
            alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message.time,
                  style: GoogleFonts.poppins(
                      color: Color(0xff666666),
                      fontWeight: FontWeight.w400,
                      fontSize: 11.sp),
                ),
                SizedBox(
                  width: 1.w,
                ),
                if (isMe) _buildMessageStatus(message.status),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentMessage(ChatMessage message) {
    return ListTile(
      title: Text(message.message),
      subtitle: Text(message.senderId),
    );
  }

  Widget _buildAudioMessage(ChatMessage message) {
    return ListTile(
      title: Text(message.message),
      subtitle: Text(message.senderId),
    );
  }

  Widget _buildVideoMessage(ChatMessage message) {
    return ListTile(
      title: Text(message.message),
      subtitle: Text(message.senderId),
    );
  }

  Widget _buildReplyMessage(ChatMessage message) {
    return ListTile(
      title: Text(message.message),
      subtitle: Text(message.senderId),
    );
  }

  Widget _buildConatctMessage(ChatMessage message, BuildContext context) {
    int contactListCount = message.contactList?.length ?? 0;
    bool isMe = message.senderId == "1";
    return commonBuildMessageOuter(
      context: context,
      isMe: isMe,
      child: Column(
        children: [
          ListTile(
            leading: AppCustomCirleProfileIamge(
              isStringImag: false,
              memoryImage: null,
              radius: 25.r,
            ),
            title: Text(contactListCount == 1
                ? message.contactList![0].displayName ?? ""
                : "${message.contactList?[0].displayName} and ${contactListCount - 1} others"),
          ),
          Align(
            alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message.time,
                  style: GoogleFonts.poppins(
                      color: Color(0xff666666),
                      fontWeight: FontWeight.w400,
                      fontSize: 11.sp),
                ),
                SizedBox(
                  width: 1.w,
                ),
                if (isMe) _buildMessageStatus(message.status),
              ],
            ),
          ),
          customDivider(),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              customTextButton("View All", onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SelectedContactListView(
                          contactList: message.contactList ?? []),
                    ));
              })
            ],
          ),
        ],
      ),
    );
  }
}

class BuildChatImage extends StatefulWidget {
  final ChatMessage message;
  BuildChatImage({super.key, required this.message});

  @override
  State<BuildChatImage> createState() => _BuildChatImageState();
}

class _BuildChatImageState extends State<BuildChatImage> {
  late String _localPath;

  Map<String, bool> _downloadStatus = {};

  Map<String, bool> _downloadloading = {};

  Future<void> _downloadImage(String imageUrl) async {
    setState(() {
      _downloadloading[imageUrl] = true;
    });
    final response = await http.get(Uri.parse(imageUrl));
    final directory = await getApplicationDocumentsDirectory();
    _localPath = directory.path;

    final filePath = '$_localPath/${imageUrl.split('/').last}';
    final file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    await ImageGallerySaver.saveFile(file.path);
    setState(() {
      _downloadloading[imageUrl] = false;
      _downloadStatus[imageUrl] = true;
      print("download${_downloadStatus[imageUrl]}");
    });
  }

  Future<void> requestStoragePermission() async {
    // Check if the platform is Android
    if (Platform.isAndroid) {
      // Check if the device is running Android 11 (API 30) or higher
      if (await _isAndroid11OrHigher()) {
        // Request MANAGE_EXTERNAL_STORAGE for Android 11+
        var status = await Permission.manageExternalStorage.status;
        if (!status.isGranted) {
          status = await Permission.manageExternalStorage.request();
        }
        if (!status.isGranted) {
          print('Manage External Storage permission denied');
          return;
        }
      } else {
        // For Android versions below 11, request storage permission
        var status = await Permission.storage.status;
        if (!status.isGranted) {
          status = await Permission.storage.request();
        }
        if (!status.isGranted) {
          print('Storage permission denied');
          return;
        }
      }
    }
  }

  /// Check if the Android version is 11 (API 30) or higher.
  Future<bool> _isAndroid11OrHigher() async {
    return Platform.isAndroid && (await _getAndroidVersion()) >= 11;
  }

  /// Method to get the current Android version.
  Future<int> _getAndroidVersion() async {
    // In a real-world scenario, you can fetch the version using platform channels or native Android code.
    // For now, we return 30, which is Android 11 (API 30).
    return 30; // Simulating Android 11
  }

  Future<void> _checkPermissionsAndImageExistence() async {
    // Request storage permission at runtime
    if (await _requestStoragePermission()) {
      _checkDownloaded(
          "https://www.sureteam.co.uk/wp-content/uploads/2019/06/New_healthy_working_system.jpeg");
    } else {
      print("Storage permission denied");
    }
  }

  Future<bool> _requestStoragePermission() async {
    var status = await Permission.storage.status;

    if (!status.isGranted) {
      status = await Permission.storage.request();
    }

    return status.isGranted;
  }

  @override
  void initState() {
    _checkPermissionsAndImageExistence();
    super.initState();
  }

  Future<void> _checkDownloaded(String imageUrl) async {
    final directory = await getApplicationDocumentsDirectory();
    _localPath = directory.path;
    final filePath = '$_localPath/${imageUrl.split('/').last}';
    final file = File(filePath);

    bool exists = await _isImageInGallery(imageUrl);
    print("ssssssssssssssssss${exists}");
    setState(() {
      _downloadStatus[imageUrl] = exists;
      _downloadloading[imageUrl] = exists;
    });
  }

  Future<bool> _isImageInGallery(String imageUrl) async {
    try {
      if (!(await Permission.storage.request().isGranted)) {
        throw PlatformException(
            code: 'PERMISSION_DENIED',
            message: 'Storage permission not granted');
      }

      String picturesDirectory = await getPicturesDirectory(imageUrl);

      // Check if the image exists in the pictures directory
      String filePath = '$picturesDirectory/${imageUrl.split('/').last}';
      bool exists = await File(filePath).exists();

      return exists;
    } catch (e) {
      print('Error checking image existence: $e');
      return false;
    }
  }

  Future<String> getPicturesDirectory(String imageUrl) async {
    try {
      // Get the external storage directory
      Directory? externalDir = await getExternalStorageDirectory();
      if (externalDir == null) {
        throw Exception('External storage directory not found');
      }
      String name = " ${imageUrl.split('?').first.split('/').last}";
      // Navigate to the pictures directory (assuming it's named "Pictures")
      String picturesPath = '${externalDir.path}/$name';
      Directory picturesDir = Directory(picturesPath);
      if (!await picturesDir.exists()) {
        throw Exception('Pictures directory not found');
      }

      return picturesPath;
    } catch (e) {
      print('Error getting pictures directory: $e');
      rethrow; // Re-throw the error for handling in the caller
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isMe = widget.message.senderId == "1";

    return commonBuildMessageOuter(
        context: context,
        isMe: isMe,
        child: SizedBox(
          width: 250.w,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Stack(children: [
                  Image(
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const SizedBox(
                          child: Center(
                              child: CircularProgressIndicator(
                                  color: Colors.white)),
                        );
                      },
                      // width: 200,
                      // height: 200,
                      fit: BoxFit.fill,
                      image: ResizeImage(
                          NetworkImage(
                            "https://www.sureteam.co.uk/wp-content/uploads/2019/06/New_healthy_working_system.jpeg",
                          ),
                          width: 250,
                          height: 200,
                          allowUpscaling: true,
                          policy: ResizeImagePolicy.fit)),
                  Positioned(
                      child: _downloadStatus[
                                  "https://www.sureteam.co.uk/wp-content/uploads/2019/06/New_healthy_working_system.jpeg"] !=
                              true
                          ? BlurryContainer(
                              color: Colors.transparent,
                              child: Container(
                                  height: 20,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          _downloadImage(
                                              "https://www.sureteam.co.uk/wp-content/uploads/2019/06/New_healthy_working_system.jpeg");
                                        },
                                        child: _downloadloading[
                                                    "https://www.sureteam.co.uk/wp-content/uploads/2019/06/New_healthy_working_system.jpeg"] !=
                                                true
                                            ? Card(
                                                color: Color.fromARGB(
                                                    147, 255, 255, 255),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.download,
                                                      size: 36,
                                                    ),
                                                    Text(
                                                      "download",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    SizedBox(
                                                      width: 2,
                                                    )
                                                  ],
                                                ))
                                            : CircularProgressIndicator(),
                                      ),
                                    ],
                                  )),
                              height: 200.h,
                              width: 250.w,
                            )
                          : SizedBox())
                ]),
              ),
              Linkify(
                linkStyle: GoogleFonts.poppins(decorationColor: Colors.blue),
                onOpen: (link) async {
                  if (!await launchUrl(Uri.parse(link.url))) {
                    throw Exception('Could not launch ${link.url}');
                  }
                },
                text: widget.message.message ?? "",
                textAlign: TextAlign.left,
                style: chatTextstyle,
              ),
              Align(
                alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.message.time,
                      style: GoogleFonts.poppins(
                          color: Color(0xff666666),
                          fontWeight: FontWeight.w400,
                          fontSize: 11.sp),
                    ),
                    SizedBox(
                      width: 1.w,
                    ),
                    if (isMe) _buildMessageStatus(widget.message.status),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

Widget _buildMessageStatus(MessageStatus status) {
  if (status == MessageStatus.sent) {
    return Icon(
      Icons.check,
      color: Colors.grey,
      size: 13.sp,
    ); // Single tick
  } else if (status == MessageStatus.delivered) {
    return Icon(
      Icons.done_all,
      color: Colors.grey,
      size: 13.sp,
    ); // Double gray ticks
  } else if (status == MessageStatus.read) {
    return Icon(
      Icons.done_all,
      color: Colors.blue,
      size: 13.sp,
    ); // Double blue ticks
  } else {
    return SizedBox.shrink();
  }
}

Widget commonBuildMessageOuter(
    {required Widget child,
    required BuildContext context,
    required bool isMe}) {
  return Container(
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width - 300,
        maxWidth: MediaQuery.of(context).size.width - 100,
      ),
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: isMe ? AppColors.lightChat : AppColors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: IntrinsicWidth(child: child));
}
