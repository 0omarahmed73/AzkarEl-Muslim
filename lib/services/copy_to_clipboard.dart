import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CopyService {
  void copyToClipboardService(Color textColor, String text2) {
    TextEditingController _controller = TextEditingController();
    _controller.text = text2;
    Clipboard.setData(ClipboardData(text: _controller.text));
    Get.snackbar('تم النسخ!', 'تمت عملية النسخ بنجاح.',
        snackPosition: SnackPosition.BOTTOM,
        colorText: textColor,
        margin: EdgeInsets.all(10));
  }
}
