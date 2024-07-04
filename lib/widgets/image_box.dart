import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class ImageBox extends StatelessWidget {
  const ImageBox({
    super.key,
    this.path,
    required this.onPickImage,
  });

  final String? path;
  final void Function(XFile file) onPickImage;

  @override
  Widget build(BuildContext context) {
    if (path != null) {
      return GestureDetector(
        onTap: _onPickImage,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Image.file(
            File(path!),
            width: 104.w,
            height: 104.h,
            fit: BoxFit.cover,
          ),
        ),
      );
    }
    return GestureDetector(
      onTap: _onPickImage,
      child: Image.asset(
        'assets/png/logo.png',
        width: 104.w,
        height: 104.h,
      ),
    );
  }

  void _onPickImage() async {
    final temp = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (temp == null) return;
    onPickImage(temp);
  }
}
