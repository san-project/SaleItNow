import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/rendering.dart';

Future<List<File>> pickImages() async {
  List<File> images = [];
  try {
    var files = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );
    if (files != null && files.files.isNotEmpty) {
      for (int i = 0; i < files.files.length; i++) {
        images.add(File(files.files[i].path!));
      }
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return images;
}

Future<File?> pickSingleImage() async {
  File? image;
  try {
    var files = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );
    if (files != null) {
      image = File(files.files.first.path!);
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return image;
}
