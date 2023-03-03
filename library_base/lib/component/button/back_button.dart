import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyBackButton extends StatelessWidget {

  const MyBackButton({
    Key? key,
    this.icon,
    this.onPressed
  }) : super(key: key);

  final Widget? icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    return IconButton(
      icon: icon ?? Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
      onPressed: () {
        if (onPressed != null) {
          onPressed!();
        } else {
          Get.back();
        }
      },
    );
  }
}