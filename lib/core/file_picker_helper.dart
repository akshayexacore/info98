import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'dart:io';

class FilePickerHelper {
  final picker = ImagePicker();
  late File _imageFile;
  FilePickerResult? result;

  Future<void> pickFiles(String filetype, BuildContext context, String? source ,{Function(dynamic)? onDone}) async {
    switch (filetype) {
      case 'image':
        await _handleImageSelection(context, source,onDone);
        break;
      case 'MultipleFile':
        await _handleMultipleFileSelection(context);
        break;
      default:
        print('Unsupported file type');
    }
  }

  Future<void> _handleImageSelection(BuildContext context, String? source, Function(dynamic)? onDone) async {
    final pickedImage = await picker.pickImage(
        source: source == "gallery" ? ImageSource.gallery : ImageSource.camera);

    if (pickedImage == null) {
      // User canceled the file picking
      Navigator.pop(context);
      return;
    }

    _imageFile = File(pickedImage.path);
    var compressedImage = await compressFile(_imageFile);
    _imageFile = File(compressedImage.path);

    if (await _isFileSizeWithinLimit(compressedImage, )) {
      _showImagePreviewDialog(context, source, _imageFile,onDone);
    } else {
      _showSizeExceedDialog(context);
    }
  }

  Future<void> _handleMultipleFileSelection(BuildContext context) async {
    result = await FilePicker.platform.pickFiles(
        allowMultiple: false, allowCompression: true);

    if (result == null) {
      // User canceled the file picking
      return;
    }

    for (PlatformFile file in result!.files) {
      if (_isFileSizeWithinLimitFromSize(file.size, maxSizeInMB: 5)) {
        // Handle file upload
        print('File path: ${file.path}');
        print('File size: ${file.size}');
      } else {
        _showSizeExceedDialog(context);
      }
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

  Future<bool> _isFileSizeWithinLimit(XFile results, { int sized = 1024}) async {
      final fileSizeInBytes = await results.length();
          final fileSizeInKB = fileSizeInBytes / sized;
          final fileSizeInMB = fileSizeInKB / sized;
          print('File size: $fileSizeInKB KB ($fileSizeInMB MB)');
          int maxSizeBytes = 10 * 1024 * 1024;
          print("File size: $maxSizeBytes");
          
    return fileSizeInMB <= maxSizeBytes;
  }

  bool _isFileSizeWithinLimitFromSize(int sizeInBytes, {required int maxSizeInMB}) {
    final fileSizeInMB = sizeInBytes / (1024 * 1024);
    return fileSizeInMB <= maxSizeInMB;
  }

  void _showImagePreviewDialog(BuildContext context, String? source, File imageFile, Function(dynamic)? onDone) {
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
                    height: MediaQuery.of(context).size.height / 1.35,
                    child: Center(
                        child: Image.file(
                      imageFile,
                      fit: BoxFit.fitHeight,
                    ))),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      onPressed: () {
                        // Handle file upload
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

  void _showSizeExceedDialog(BuildContext context) {
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
  }
}
