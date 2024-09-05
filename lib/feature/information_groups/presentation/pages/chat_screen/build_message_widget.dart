import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:info_91_proj/core/config/app_styles.dart';
import 'package:info_91_proj/feature/information_groups/presentation/pages/chat_screen/info_group_chat_screen.dart';
import 'package:info_91_proj/feature/information_groups/presentation/widgets/texts.dart';
import 'package:url_launcher/url_launcher.dart';

class BuildMessageWidget extends StatelessWidget {
  final ChatMessage messageModel;
  const BuildMessageWidget({super.key, required this.messageModel});

  @override
  Widget build(BuildContext context) {
    switch (messageModel.messageType) {
      case MessageType.text:
        return _buildTextMessage(messageModel, context);
      case MessageType.image:
        return _buildImageMessage(messageModel, context);
      case MessageType.document:
        return _buildDocumentMessage(messageModel);
      case MessageType.audio:
        return _buildAudioMessage(messageModel);
      case MessageType.video:
        return _buildVideoMessage(messageModel);
      case MessageType.reply:
        return _buildReplyMessage(messageModel);
      default:
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
          maxWidth: MediaQuery.of(context).size.width - 90,
        ),
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: isMe ? AppColors.lightChat : AppColors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: IntrinsicWidth(child: child));
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
            child: Expanded(
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
          ),
        ],
      ),
    );
  }

  Widget _buildImageMessage(
    ChatMessage message,
    BuildContext context,
  ) {
    bool isMe = message.senderId == "1";
    return commonBuildMessageOuter(
        context: context,
        isMe: isMe,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                  "https://www.sureteam.co.uk/wp-content/uploads/2019/06/New_healthy_working_system.jpeg"),
            ),
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
              child: Expanded(
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
            ),
          ],
        ));
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
}
